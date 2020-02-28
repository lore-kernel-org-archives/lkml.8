Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15F3C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89881246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="mmrGt5hO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgB1Sbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:31:38 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53560 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgB1Sbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:31:38 -0500
Received: from zn.tnic (p200300EC2F084600A41928AC2BDFCE32.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:4600:a419:28ac:2bdf:ce32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 937B21EC0235;
        Fri, 28 Feb 2020 19:31:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582914696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vKcgGMDU+mnrcvNjUC9MBKQ22KHBpf5+JRGEkK8GD44=;
        b=mmrGt5hOFiItfdIEDb54DKRpElQ5SdUE70XxYSUujJGPd9YCt2RyhbS2cETMY0MhylblVb
        r8MpT8zC1m30xyb0VzgNBbUT7By6qrp4YHRcE3xntTzslXJ+R4sVMuANZ8UrUkJLYhVndp
        yy91QM/mxtRwjc3QD9j3UlMP52PFPNo=
Date:   Fri, 28 Feb 2020 19:31:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 8/8] x86/fpu/xstate: Restore supervisor xstates for
 __fpu__restore_sig()
Message-ID: <20200228183131.GE25261@zn.tnic>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
 <20200121201843.12047-9-yu-cheng.yu@intel.com>
 <20200221175859.GL25747@zn.tnic>
 <77f3841a92df5d0c819699ee3612118d566b7445.camel@intel.com>
 <20200228121724.GA25261@zn.tnic>
 <89bcab262d6dad4c08c4a21e522796fea2320db3.camel@intel.com>
 <20200228162359.GC25261@zn.tnic>
 <6f91699c91f9ea0f527e80ed3ea2999444a8d2d1.camel@intel.com>
 <20200228172202.GD25261@zn.tnic>
 <9a283ad42da140d73de680b1975da142e62e016e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a283ad42da140d73de680b1975da142e62e016e.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 10:11:44AM -0800, Yu-cheng Yu wrote:
> CET has 16 bytes for ring-3 setting, 24 bytes for ring-0.
> Saving supervisor states somewhere else and copying back is not better
> either.

Well, if you're going to save a lot bigger user states area which is
going to be absolutely wasted cycles in that case, you better save those
couple of bytes in another buffer and then copy them into the final state
buffer which gets restored.

> We save supervisor states only when xfeatures_mask_supervisor() is not
> zero.

And on which systems is it not zero? On systems which have supervisor
features or on systems which have *and* *are* *using* supervisor
features?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
