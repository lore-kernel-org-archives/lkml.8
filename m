Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F170C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F3724656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sEqHHWBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAVIqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 03:46:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44610 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgAVIqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Suf4eYMeV3bbzs85+fbkbcrXnj+DZbv4YKgfLiPhuRw=; b=sEqHHWBToqqcisEOnRPcoN3lX
        Z5t3aVo2S85ziCTQK5LqLvKoPBgwB26UW4dQJGdCkCksnbG3HOoOSWPO6qmTZBv6bvzoH1cpXhFWQ
        YxbKa/gFTLDZHUfj2p5QFx9T7ar/Sj6H23f5ndDuaUTHhZ8gN+jwpt/Iq8Wne3whzi5QLv1hUeEyR
        tdqVuhHq3fVcw6M/FH0pQ54uvJjPyyYwP7tK17wcJS3ZfXMTyje1y+G6plnTUYuzjg3ByyepRkzjt
        nH6VPsVaLKpXFdUlzrbMXjUL9ei3pTMJfVaAinjh7XBn0kwdCjEwYGQtynK2ORyXHmXBy6d7qu/Bl
        hbcFdErIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuBeI-00084X-IL; Wed, 22 Jan 2020 08:46:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 09762304121;
        Wed, 22 Jan 2020 09:44:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6ECBB2B703E5D; Wed, 22 Jan 2020 09:46:04 +0100 (CET)
Date:   Wed, 22 Jan 2020 09:46:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] x86/mm/pat: silence a data race in cpa_4k_install
Message-ID: <20200122084604.GP14914@hirez.programming.kicks-ass.net>
References: <20200121151503.2934-1-cai@lca.pw>
 <CANpmjNPR+mbadR0DDKGUhTkaXJi=vsHmhvq3+Rz0Hrx=E9V_Qg@mail.gmail.com>
 <20200121152853.GI7808@zn.tnic>
 <44A4276D-5530-4DAA-8FC7-753D03ADD2F3@lca.pw>
 <CANpmjNO7mTEMc6pvpVVXdu2r6cMg_N8QkRffEHHG-WNFXE4CjA@mail.gmail.com>
 <20200121154528.GK7808@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121154528.GK7808@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 04:45:28PM +0100, Borislav Petkov wrote:
> On Tue, Jan 21, 2020 at 04:36:49PM +0100, Marco Elver wrote:
> > Isn't the intent "x86/mm/pat: Mark intentional data race" ?  The fact
> > that KCSAN no longer shows the warning is a side-effect.  At least
> > that's how I see it.
> 
> Perhaps because you've been dealing with KCSAN for so long. :-)
> 
> The main angle here, IMO, is that this "fix" is being done solely for
> KCSAN. Or is there another reason to "fix" intentional data races? At
> least I don't see one. And the text says

Documentation. It is a clear and concise marker of intent. Unintended
data races are bad.

Also, we've been adding annotations to the kernel source forever,
sparse, lockdep, etc.. now KCSAN. All we have to do is make sure they're
minimally invasive, and in that regard the date_race() marker is spot on
IMO.

