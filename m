Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617CDC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 21:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFD2246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 21:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgB1VX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 16:23:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:30031 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgB1VX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 16:23:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 13:23:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400"; 
   d="scan'208";a="385611917"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga004.jf.intel.com with ESMTP; 28 Feb 2020 13:23:27 -0800
Message-ID: <7c6560b067436e2ec52121bba6bff64833e28d8d.camel@intel.com>
Subject: Re: [PATCH v2 8/8] x86/fpu/xstate: Restore supervisor xstates for
 __fpu__restore_sig()
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
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
Date:   Fri, 28 Feb 2020 13:22:39 -0800
In-Reply-To: <20200228183131.GE25261@zn.tnic>
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
         <20200228183131.GE25261@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-28 at 19:31 +0100, Borislav Petkov wrote:
> On Fri, Feb 28, 2020 at 10:11:44AM -0800, Yu-cheng Yu wrote:
> > CET has 16 bytes for ring-3 setting, 24 bytes for ring-0.
> > Saving supervisor states somewhere else and copying back is not better
> > either.
> 
> Well, if you're going to save a lot bigger user states area which is
> going to be absolutely wasted cycles in that case, you better save those
> couple of bytes in another buffer and then copy them into the final state
> buffer which gets restored.

The code is for sigreturn only.  Because of lazy-restore,
copy_xregs_to_kernel() does not happen all the time.  It is attractive in
terms of simplicity.

XSAVES buffer has fixed 576-byte overhead (512-byte legacy + 64-byte
header) and not suitable for partial saving.  To save only supervisor
states, we need to read out each MSR separately and store them in a struct.

> 
> > We save supervisor states only when xfeatures_mask_supervisor() is not
> > zero.
> 
> And on which systems is it not zero? On systems which have supervisor
> features or on systems which have *and* *are* *using* supervisor
> features?

On systems using supervisor features.

Yu-cheng

