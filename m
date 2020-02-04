Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D52C3524B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B522084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBUFzJGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgBDT1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:27:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49220 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727331AbgBDT1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580844432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+INgdD03Tv5XHzkJmkxLNrlQlFKrzTmZGpyB4BiQ8qs=;
        b=GBUFzJGE0EXdvZrgCd66PJMMGUOpsrjioFEMdFHs1Bis9E0ytd50bcuGXmJ2yUScOS3OTg
        b5nX5bRXyQku8A7ploeWFzYW6kxCFR+0X84tQSUy8l8NQ7znyM2UDHOTh+YjEYgjM/mj43
        uDJg0sjl3pbE3/6Ewt7bGeEnfnsNYaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-QWOsU4R7MNuLzePPYZL8-Q-1; Tue, 04 Feb 2020 14:27:08 -0500
X-MC-Unique: QWOsU4R7MNuLzePPYZL8-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4B9C8018A1;
        Tue,  4 Feb 2020 19:27:06 +0000 (UTC)
Received: from krava (ovpn-204-94.brq.redhat.com [10.40.204.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C912F10018FF;
        Tue,  4 Feb 2020 19:27:01 +0000 (UTC)
Date:   Tue, 4 Feb 2020 20:26:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Marek Majkowski <marek@cloudflare.com>
Cc:     Ivan Babrou <ivan@cloudflare.com>,
        kernel-team <kernel-team@cloudflare.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, sashal@kernel.org,
        Kenton Varda <kenton@cloudflare.com>
Subject: Re: perf not picking up symbols for namespaced processes
Message-ID: <20200204192657.GB1554679@krava>
References: <CABWYdi1ZKR=jmKnjoJTik08Q9uJBvyZ4W0C29iPiUJ5ef1obvw@mail.gmail.com>
 <20191205123302.GA25750@kernel.org>
 <CABWYdi1+E7MQD8mC2xQfSP0m9_WFdx9mbLkw-36tJ8EtLaw2Jg@mail.gmail.com>
 <CAJPywTKC8=O0zmNm-W4OUENpoZfrbr1Ts38gQw2ZA608_u5wpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJPywTKC8=O0zmNm-W4OUENpoZfrbr1Ts38gQw2ZA608_u5wpw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 03:09:48PM +0000, Marek Majkowski wrote:
> On Fri, Dec 6, 2019 at 2:17 AM Ivan Babrou <ivan@cloudflare.com> wrote:
> >
> > I'm not very good at this, but the following works for me. If you this
> > is in general vicinity of what you expected, I can email patch
> > properly.
> >
> 
> Thanks for the patch, I can confirm it works. I had this problem today
> when playing
> with gvisor. Gvisor is starting up in a fresh mount namespace and perf fails
> to read the symbols. Stracing perf shows:
> 
> 11913 openat(AT_FDCWD, "/proc/9512/ns/mnt", O_RDONLY) = 197
> 11913 setns(197, CLONE_NEWNS) = 0
> 11913 stat("/home/marek/bin/runsc-debug", 0x7fffffff8480) = -1 ENOENT
> (No such file or directory)
> 11913 setns(196, CLONE_NEWNS) = 0
> 
> Which of course makes no sense - the runsc-debug binary does not exist in the
> empty mount namespace of the restricted runsc process.

hi,
could you guys please share more details on what you run exactly,
and perhaps that change you mentioned?

thanks,
jirka

