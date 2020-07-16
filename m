Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C46EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317D5206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ib09A2Us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgGPTu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbgGPTu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:50:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470E8C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 12:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4o95Wx4Xr3wKGeqyIoxGkqsADzM47hwJnHVeNYra3h0=; b=Ib09A2UsYxdNO72EOfZfz8z+xO
        y944CWAoIqbyoEvpyH27rmC5EPqFTBJzDgd2SEJnNZnCpwJvbjM+iTRpxKRN/YyWdtPsqMXM7+T2+
        RCz4GedkJQMDFVvHGQuUOClQ9K4Kx4UOwVSVSVocPUaYsfRxiOUoYS2sLr1vtbdEes/GHicplgxOl
        PXHXLONqRcR2aw+ND9QTRxrj5yNiQiB4gwx7fPaUyMsLUz9QiiXDzbQVwedhij0V8lVgyyaFtVxCf
        V2eYMrylBrhMGucAyP6KW/gM3DiHj+TlhgMXcvmNWMyv2nwkAappx2nZLYJx787hxGSZ3aDmmQUqA
        Tr84ixUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jw9tV-0002fJ-Dw; Thu, 16 Jul 2020 19:50:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 11E72300130;
        Thu, 16 Jul 2020 21:50:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF016203C0BEC; Thu, 16 Jul 2020 21:50:10 +0200 (CEST)
Date:   Thu, 16 Jul 2020 21:50:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/split_lock: Enumerate split lock feature on Sapphire
 Rapids
Message-ID: <20200716195010.GV10769@hirez.programming.kicks-ass.net>
References: <1593208534-33721-1-git-send-email-fenghua.yu@intel.com>
 <20200716193659.GA66451@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716193659.GA66451@romley-ivt3.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 12:37:00PM -0700, Fenghua Yu wrote:
> Hi, Thomas, Boris, Ingo,
> 
> On Fri, Jun 26, 2020 at 02:55:34PM -0700, Fenghua Yu wrote:
> > Add Sapphire Rapids processor to CPU list to enumerate split lock
> > feature.
> > 
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  arch/x86/kernel/cpu/intel.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> > index c25a67a34bd3..dca069ad6671 100644
> > --- a/arch/x86/kernel/cpu/intel.c
> > +++ b/arch/x86/kernel/cpu/intel.c
> > @@ -1148,6 +1148,7 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
> >  	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	1),
> >  	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		1),
> >  	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		1),
> > +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	1),
> >  	{}
> >  };
> 
> Any comment on this patch?

The only comment I have is that us needing it is ludicrous :/ What's the
bloody point of having it 'enumerated' if you then still have to use FMS
lists.

There's nowhere near enough cursing in the comment that goes with that
list.
