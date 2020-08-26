Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37950C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA1121775
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598449913;
	bh=JfrtYoof4J1qKW2voT8243gmgO0ySPSskG0PqMYl7jQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gyv9eW9t+GMJpzPynDif4dk3FVrNKiPHZH8KdHljaWp+Q+1v3QfyiAuesrQCLoMVi
	 GfJ/SMPJfjZsvhwyKU3fCJIyVSvKsE6t/wY0HmV/9Ag675tkasYbZ79GQIsnPonFKg
	 +h0Pw0e+130hgPL3pS9tijhWxnxt+lIPaJIhlFeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgHZNvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:51:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730554AbgHZNvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:51:49 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31A40208E4;
        Wed, 26 Aug 2020 13:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598449908;
        bh=JfrtYoof4J1qKW2voT8243gmgO0ySPSskG0PqMYl7jQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j/E+zt4UuuQbMklEfPBZsLYVlz1BsUK3CPW+SRpjuODk4VgDqLZw0PM7/G2GgnGdb
         5YUQfoEKYZvFdChl6JIUwa4S9vSoibnk3+X0WC+PfzQ8nVBetsbnMBy5FD5lxePLtn
         Fd+ggB9OJPpECHpCuRcc5bpKArQeB0JHRfqmfwF4=
Date:   Wed, 26 Aug 2020 22:51:44 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-Id: <20200826225144.6df009f67b3516a3d0d58e6e@kernel.org>
In-Reply-To: <42c65d9e434945c183ead8bef3d89de2@trendmicro.com>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
        <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
        <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
        <20200825151538.f856d701a34f4e0561a64932@kernel.org>
        <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
        <d3027772a6834f89a1ddc07c0fefaa0a@trendmicro.com>
        <20200826172239.ff175be78ee5f3a4380579c3@kernel.org>
        <20200826180645.9b609fc05df2a149564df1b8@kernel.org>
        <20200826190041.2d0ff0fbe154ba62163b0c00@kernel.org>
        <20200826102545.GF1362448@hirez.programming.kicks-ass.net>
        <42c65d9e434945c183ead8bef3d89de2@trendmicro.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 13:36:15 +0000
"Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com> wrote:

> 
> 
> > -----Original Message-----
> > From: peterz@infradead.org <peterz@infradead.org>
> > Sent: Wednesday, August 26, 2020 6:26 PM
> > To: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Eddy Wu (RD-TW) <Eddy_Wu@trendmicro.com>; linux-kernel@vger.kernel.org; x86@kernel.org
> > Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function entry is not optimized (trigger by int3 breakpoint)
> >
> > On Wed, Aug 26, 2020 at 07:00:41PM +0900, Masami Hiramatsu wrote:
> > > Of course, this doesn't solve the llist_del_first() contention in the
> > > pre_kretprobe_handler(). So anyway we need a lock for per-probe llist
> > > (if I understand llist.h comment correctly.)
> >
> > Bah, lemme think about that. Kprobes really shouldn't be using locks :/
> 
> Maybe we can have per-cpu free list for retprobe_instance?
> This ensure we only have one user requesting free instance at a time, given that pre_kretprobe_handler() wont recursive.

That will restrict kretprobe not to probe the recursive call loop... 
and if a thread is scheduled, another thread will not be probed too.

I think lockless kretprobe is finally implemented by merging it's
shadow-stack with func-graph tracer.

Thank you,

> 
> We may be wasting memory if target function perfer some cpu though.
> 
> 
> TREND MICRO EMAIL NOTICE
> 
> The information contained in this email and any attachments is confidential and may be subject to copyright or other intellectual property protection. If you are not the intended recipient, you are not authorized to use or disclose this information, and we request that you notify us by reply mail or telephone and delete the original message from your mail system.
> 
> For details about what personal information we collect and why, please see our Privacy Notice on our website at: Read privacy policy<http://www.trendmicro.com/privacy>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
