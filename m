Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEC5C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE7621775
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0qXkrXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgCBTUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:20:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53541 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727526AbgCBTUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583176819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nN5b0eOb5d9AS1df7QP1NTDW5BtLlM0vcmSTXw9KGzQ=;
        b=N0qXkrXzo0ftsUVhFscZNLni3VfwJPFh0KQ/e3PYKdw5C7yA8RYNoDjj3UzIEX5uNPYmkL
        9M1PqTNtkh/fH0Vt4yprnidhYtHtmW7seU/p3+kM/E+zl+vFUBxInXT11PaftYPC6lVlWg
        2hQCHhtVnHXp6hlLRZdEbB1rEAH6mnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-Y89D0tjSNuaLVG0mZ9Knmg-1; Mon, 02 Mar 2020 14:20:15 -0500
X-MC-Unique: Y89D0tjSNuaLVG0mZ9Knmg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD5A3B0568;
        Mon,  2 Mar 2020 19:20:13 +0000 (UTC)
Received: from krava (ovpn-205-46.brq.redhat.com [10.40.205.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6647439E;
        Mon,  2 Mar 2020 19:20:11 +0000 (UTC)
Date:   Mon, 2 Mar 2020 20:20:08 +0100
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
Message-ID: <20200302192008.GB263077@krava>
References: <20200302191007.GD10335@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302191007.GD10335@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

cool, I just saw your other email and was going to check on it ;-)
ging to check on this and review

jirka

> 
> Fixes: 02213cec64bb ("perf maps: Mark module DSOs with kernel type")
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kim Phillips <kim.phillips@amd.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ---
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 1077013d8ce2..26bc6a0096ce 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1622,7 +1622,12 @@ int dso__load(struct dso *dso, struct map *map)
>  		goto out;
>  	}
>  
> -	if (dso->kernel) {
> +	kmod = dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE ||
> +		dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP ||
> +		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE ||
> +		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
> +
> +	if (dso->kernel && !kmod) {
>  		if (dso->kernel == DSO_TYPE_KERNEL)
>  			ret = dso__load_kernel_sym(dso, map);
>  		else if (dso->kernel == DSO_TYPE_GUEST_KERNEL)
> @@ -1650,12 +1655,6 @@ int dso__load(struct dso *dso, struct map *map)
>  	if (!name)
>  		goto out;
>  
> -	kmod = dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE ||
> -		dso->symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP ||
> -		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE ||
> -		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
> -
> -
>  	/*
>  	 * Read the build id if possible. This is required for
>  	 * DSO_BINARY_TYPE__BUILDID_DEBUGINFO to work
> 

