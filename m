Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39546C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 21:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015AC246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 21:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="JHb/wjcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgB1Vru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 16:47:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40118 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgB1Vru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 16:47:50 -0500
Received: from zn.tnic (p200300EC2F08460085C27F132DF541F6.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:4600:85c2:7f13:2df5:41f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 581061EC0273;
        Fri, 28 Feb 2020 22:47:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582926468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KAekNbpydsrWNM0VycDBvsuED4RKjUysHUmbFrTNoE4=;
        b=JHb/wjczOVtUjNcbrSqW1jF8NXoV4d5nMXMq/nJhPmEaZrLh4f5uANXD/Rs3pUnjw602Ti
        itP4idDjFWy+H/zrrtRARZ1rVUbouG5VhZ8DWfWuJVXL3Wt2dN3aE/rMOoy3yTP+PHwLPm
        RqEtlxcXw/kVh/nm37kKoLMZkaW53+8=
Date:   Fri, 28 Feb 2020 22:47:42 +0100
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
Message-ID: <20200228214742.GF25261@zn.tnic>
References: <20200221175859.GL25747@zn.tnic>
 <77f3841a92df5d0c819699ee3612118d566b7445.camel@intel.com>
 <20200228121724.GA25261@zn.tnic>
 <89bcab262d6dad4c08c4a21e522796fea2320db3.camel@intel.com>
 <20200228162359.GC25261@zn.tnic>
 <6f91699c91f9ea0f527e80ed3ea2999444a8d2d1.camel@intel.com>
 <20200228172202.GD25261@zn.tnic>
 <9a283ad42da140d73de680b1975da142e62e016e.camel@intel.com>
 <20200228183131.GE25261@zn.tnic>
 <7c6560b067436e2ec52121bba6bff64833e28d8d.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c6560b067436e2ec52121bba6bff64833e28d8d.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 01:22:39PM -0800, Yu-cheng Yu wrote:
> The code is for sigreturn only.  Because of lazy-restore,
> copy_xregs_to_kernel() does not happen all the time.

What does "not all the time" mean? You need to quantify this more
precisely.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
