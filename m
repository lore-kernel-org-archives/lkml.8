Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EA9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A6F21556
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISAm9jEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgCBUDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:03:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58186 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726545AbgCBUDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 15:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583179382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LPojLI446aoeLmtH/1lQnBQGbo8ED69kam5nyvQn7G8=;
        b=ISAm9jEi3tqMJuC26XwuRzbR+5wTZZpe87HfIH1CmKj5NdHvs6fM/DBNaUwQmvPQ5G+/mQ
        AiHPOJUfQ8ObTxUJVHIxylFy3EB2z094TEgHwKa/lXAk0oMvqz5n9LEKWViS1QB0hUq3hg
        JpU2um5fkSmvgVZp4SDgDyUfo/DQz6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-kaSIEsubPHaM28o8lGTkdg-1; Mon, 02 Mar 2020 15:02:58 -0500
X-MC-Unique: kaSIEsubPHaM28o8lGTkdg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B645801F7C;
        Mon,  2 Mar 2020 20:02:57 +0000 (UTC)
Received: from krava (ovpn-204-60.brq.redhat.com [10.40.204.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5D2160BF3;
        Mon,  2 Mar 2020 20:02:52 +0000 (UTC)
Date:   Mon, 2 Mar 2020 21:02:49 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf symbols: Don't try to find a vmlinux file when
 looking for kernel modules
Message-ID: <20200302200249.GA9761@krava>
References: <20200302191007.GD10335@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302191007.GD10335@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 04:10:07PM -0300, Arnaldo Carvalho de Melo wrote:
> The dso->kernel value is now set to everything that is in
> machine->kmaps, but that was being used to decide if vmlinux lookup is
> needed, which ended up making that lookup be made for kernel modules,
> that now have dso->kernel set, leading to these kinds of warnings when
> running on a machine with compressed kernel modules, like fedora:31:
>     
>   [root@five ~]# perf record -F 10000 -a sleep 2
>   [ perf record: Woken up 1 times to write data ]
>   lzma: fopen failed on vmlinux: 'No such file or directory'
>   lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
>   lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
>   lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
>   lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
>   lzma: fopen failed on vmlinux: 'No such file or directory'
>   lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
>   lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
>   lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
>   lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
>   lzma: fopen failed on vmlinux: 'No such file or directory'
>   lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
>   lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
>   lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
>   lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
>   lzma: fopen failed on vmlinux: 'No such file or directory'
>   lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
>   lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
>   lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
>   lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
>   lzma: fopen failed on vmlinux: 'No such file or directory'
>   lzma: fopen failed on /boot/vmlinux: 'No such file or directory'
>   lzma: fopen failed on /boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
>   lzma: fopen failed on /usr/lib/debug/boot/vmlinux-5.5.5-200.fc31.x86_64: 'No such file or directory'
>   lzma: fopen failed on /lib/modules/5.5.5-200.fc31.x86_64/build/vmlinux: 'No such file or directory'
>   [ perf record: Captured and wrote 1.024 MB perf.data (1366 samples) ]
>   [root@five ~]#
> 
> This happens when collecting the buildid, when we find samples for
> kernel modules, fix it by checking if the looked up DSO is a kernel
> module by other means.
> 
> Fixes: 02213cec64bb ("perf maps: Mark module DSOs with kernel type")

ok, I couldn't see that because kcore took over the modules,
for some reason you don't have it enabled on your system?

because I had to disable it manualy in the code.. I think
we should add some --no-kcore option for record

the fix is working for me:

Tested/Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

