Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028BAC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56EA24697
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgB1Qu3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:50:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37370 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgB1Qu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:50:29 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j7iqD-0002y7-Dq; Fri, 28 Feb 2020 17:50:21 +0100
Date:   Fri, 28 Feb 2020 17:50:21 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 8/8] x86/fpu/xstate: Restore supervisor xstates for
 __fpu__restore_sig()
Message-ID: <20200228165021.76pec2cdudmtpxeu@linutronix.de>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
 <20200121201843.12047-9-yu-cheng.yu@intel.com>
 <20200221175859.GL25747@zn.tnic>
 <77f3841a92df5d0c819699ee3612118d566b7445.camel@intel.com>
 <20200228121724.GA25261@zn.tnic>
 <89bcab262d6dad4c08c4a21e522796fea2320db3.camel@intel.com>
 <20200228162359.GC25261@zn.tnic>
 <6f91699c91f9ea0f527e80ed3ea2999444a8d2d1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <6f91699c91f9ea0f527e80ed3ea2999444a8d2d1.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-28 08:20:27 [-0800], Yu-cheng Yu wrote:
> On Fri, 2020-02-28 at 17:23 +0100, Borislav Petkov wrote:
> > On Fri, Feb 28, 2020 at 07:53:38AM -0800, Yu-cheng Yu wrote:
> > > Yes, saving only supervisor states is optimal, but doing XSAVES with a
> > > partial RFBM changes xcomp_bv.
> > 
> > ... and that means what exactly in plain english?
> 
> When XSAVES writes to an xsave buffer, xsave->header.xcomp_bv is set to
> include only saved components, effectively changing the buffer's format.

How large is this supervisor state at most? I guess saving the AVX512
state just to get the 2 bytes of the supervisor state at the right spot
is not really optimal.
But this is the performance division…

> I will include this in the comments.

If you do so, please state that the first hunk is only interested in the
supervisor-state bits and everything else is ignored.

> Yu-cheng

Sebastian
