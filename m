Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D58C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC17C2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596802205;
	bh=Gb0cPuLIe0bMb0g+aVRlrZgigx5Ntb7ULTCO6GIv/Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GAwPxS4+C/PnI8F40Y0+VJ/WeGPgXORMPRaKY5Lb2n9n5UfRI6/0sy/L3R3k3uZlZ
	 dc88SO2ABu528yIKqrSOWCiWfWKB3P3qsCAFBIaACKKSaiieA/JSi8pUWYjYjSFN2I
	 EwcI4oZLIyQdG6wBVPs7F3s2TkBk02Gc713eaoEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgHGMKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgHGMJ7 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:09:59 -0400
Received: from quaco.ghostprotocols.net (unknown [186.208.79.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C46020866;
        Fri,  7 Aug 2020 12:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596802199;
        bh=Gb0cPuLIe0bMb0g+aVRlrZgigx5Ntb7ULTCO6GIv/Yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ISNZvYModwKynAmPBg5NmrzLLYNglisCFyQvI7m1pOdwRu0YE8VwboGSW5E90tqzn
         b4MLNge26dmN0vXPlUT3stYQS/XLkYdGWHdpIe7l1iGueDbJ/16jVkSd9IuAcAd54A
         ydNukO+QKKS91pK3KsT3RRoWaUuZeZm2HVi35nzc=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EA1B740481; Fri,  7 Aug 2020 09:09:56 -0300 (-03)
Date:   Fri, 7 Aug 2020 09:09:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf record: Skip side-band event setup if
 HAVE_LIBBPF_SUPPORT is not set
Message-ID: <20200807120956.GB2456573@kernel.org>
References: <20200805022937.29184-1-yao.jin@linux.intel.com>
 <20200806194357.GA539212@krava>
 <20200807120824.GA2456573@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807120824.GA2456573@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 07, 2020 at 09:08:24AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Aug 06, 2020 at 09:43:57PM +0200, Jiri Olsa escreveu:
> > On Wed, Aug 05, 2020 at 10:29:37AM +0800, Jin Yao wrote:
> > > We received an error report that perf-record caused 'Segmentation fault'
> > > on a newly system (e.g. on the new installed ubuntu).
> > > 
> > >  (gdb) backtrace
> > >  #0  __read_once_size (size=4, res=<synthetic pointer>, p=0x14) at /root/0-jinyao/acme/tools/include/linux/compiler.h:139
> > >  #1  atomic_read (v=0x14) at /root/0-jinyao/acme/tools/include/asm/../../arch/x86/include/asm/atomic.h:28
> > >  #2  refcount_read (r=0x14) at /root/0-jinyao/acme/tools/include/linux/refcount.h:65
> > >  #3  perf_mmap__read_init (map=map@entry=0x0) at mmap.c:177
> > >  #4  0x0000561ce5c0de39 in perf_evlist__poll_thread (arg=0x561ce68584d0) at util/sideband_evlist.c:62
> > >  #5  0x00007fad78491609 in start_thread (arg=<optimized out>) at pthread_create.c:477
> > >  #6  0x00007fad7823c103 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> > 
> > hum, I recall discussing the same issue,
> > I thought it was already fixed :-\ in any case:
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> I added this:
> 
> Fixes: 23cbb41c939a ("perf record: Move side band evlist setup to separate routine")
> 
> To help this fixe go back to a few stable kernels. Technically the
> problem was introduced much earlier, when the side band thread was
> added, but then this would require more cherry-picking of patches and
> since we have a workaround, i.e. build with libbpf, I think this is
> enough.

I backtrack on that, as the sideband event is not just for BPF... The
switch-output-event code uses it as well, so it can't be dependent on
LIBBPF being built...

I'll see what I can do

- Arnaldo
