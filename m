Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C44DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2921A2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598432813;
	bh=KLBWFTqIGdn6a1M534qrDK+NOnMbELdfxkrei37Ruxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=J4ddUmBovPAEUF1xH2l6yCK361480hir52HWVdBenxIxFCyBwBObvr+LZjq1Neog+
	 vJon+U2Ya2Lp9vx7mdciRtZ9RjQ8+ejF4jrwBapNIyA6B7UkSNcCwIasUCJuGbMdt3
	 4CvGIEukOT5jV+Pibj5NNLsjahZ4p8v0li7CVr7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgHZJGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:06:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbgHZJGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:06:49 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AE00206FA;
        Wed, 26 Aug 2020 09:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598432809;
        bh=KLBWFTqIGdn6a1M534qrDK+NOnMbELdfxkrei37Ruxc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M1et6vgEx9Tml0fXkvzI0PV1xJGB+sI9E1iDWewTwheg0Naz9xHddgbU8Bahl227c
         qzuIqMAZc0DvN5exenz9ltXM3eDLHE9Ucjsb0lBi0GvkT+lxQ85HAYpYERDuJw5gF5
         jI7QkkVILP6yVTZFi371oaQSzhDe3IoNrm/vwJI8=
Date:   Wed, 26 Aug 2020 18:06:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-Id: <20200826180645.9b609fc05df2a149564df1b8@kernel.org>
In-Reply-To: <20200826172239.ff175be78ee5f3a4380579c3@kernel.org>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
        <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
        <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
        <20200825151538.f856d701a34f4e0561a64932@kernel.org>
        <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
        <d3027772a6834f89a1ddc07c0fefaa0a@trendmicro.com>
        <20200826172239.ff175be78ee5f3a4380579c3@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 17:22:39 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed, 26 Aug 2020 07:07:09 +0000
> "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com> wrote:
> 
> > 
> > > -----Original Message-----
> > > From: peterz@infradead.org <peterz@infradead.org>
> > > Sent: Tuesday, August 25, 2020 8:09 PM
> > > To: Masami Hiramatsu <mhiramat@kernel.org>
> > > Cc: Eddy Wu (RD-TW) <Eddy_Wu@trendmicro.com>; linux-kernel@vger.kernel.org; x86@kernel.org; David S. Miller
> > > <davem@davemloft.net>
> > > Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function entry is not optimized (trigger by int3 breakpoint)
> > >
> > > Surely we can do a lockless list for this. We have llist_add() and
> > > llist_del_first() to make a lockless LIFO/stack.
> > >
> > 
> > llist operations require atomic cmpxchg, for some arch doesn't have CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG, in_nmi() check might still needed.
> > (HAVE_KRETPROBES && !CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG): arc, arm, csky, mips
> 
> Good catch. In those cases, we can add in_nmi() check at arch dependent code.

Oops, in_nmi() check is needed in pre_kretprobe_handler() which has no
arch dependent code. Hmm, so we still need an weak function to check it...

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
