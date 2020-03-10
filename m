Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48093C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11774222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCJUgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:36:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:59441 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgCJUgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:36:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 13:36:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,538,1574150400"; 
   d="scan'208";a="441428430"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga005.fm.intel.com with ESMTP; 10 Mar 2020 13:36:19 -0700
Message-ID: <e62e968c0980b091d7b263401ddd10162773678f.camel@intel.com>
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
Date:   Tue, 10 Mar 2020 13:36:19 -0700
In-Reply-To: <20200306205039.GA5337@cz.tnic>
References: <6f91699c91f9ea0f527e80ed3ea2999444a8d2d1.camel@intel.com>
         <20200228172202.GD25261@zn.tnic>
         <9a283ad42da140d73de680b1975da142e62e016e.camel@intel.com>
         <20200228183131.GE25261@zn.tnic>
         <7c6560b067436e2ec52121bba6bff64833e28d8d.camel@intel.com>
         <20200228214742.GF25261@zn.tnic>
         <c8da950a64db495088f0abe3932a489a84e4da97.camel@intel.com>
         <20200229143644.GA1129@zn.tnic>
         <6778d141a3cdbbe51cdeb3a8efb9c34e0951f6c6.camel@intel.com>
         <53e795ffbc029de316985476fd61845b7a9e824f.camel@intel.com>
         <20200306205039.GA5337@cz.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-06 at 21:50 +0100, Borislav Petkov wrote:
> On Wed, Mar 04, 2020 at 10:18:46AM -0800, Yu-cheng Yu wrote:
> > There is another way to keep this patch...
> > 
> > if (xfeatures_mask_supervisor()) {
> > 	fpu->state.xsave.xfeatures &= xfeatures_mask_supervisor();
> 
> Is the subsequent XSAVE in copy_user_to_fpregs_zeroing() going to
> restore the user bits in XSTATE_BV you just cleared?
> 
> Sorry, it looks like it would but the SDM text is abysmal.

I checked and this won't work.



Earlier you wrote:

  53973 / (3*60 + 35) =~ 251 XSAVES invocations per second!

I would argue that the kernel does much more than that for context
switches.

These are from:
  perf record -a make -j32 bzImage

# Samples: 11M of event 'cycles'
# Event count (approx.): 7610600069602
#
# Overhead  Symbol
     2.19%  [.] ht_lookup_with_hash
     1.74%  [.] _int_malloc
     1.46%  [.] _cpp_lex_token
     1.46%  [.] ggc_internal_alloc
     1.10%  [.] cpp_get_token_with_location
     1.10%  [.] malloc
     1.05%  [.] _int_free
     0.71%  [.] elf_read
     0.70%  [.] ggc_internal_cleared_alloc
     0.69%  [.] htab_find_slot
     0.69%  [.] c_lex_with_flags
     0.61%  [.] get_combined_adhoc_loc
     0.57%  [.] linemap_position_for_column
[...]
     0.00%  [.] 0x0000000000bad020
     0.00%  [.] 0x0000000000b4952b
     0.00%  [k] __fpu__restore_sig

Here, __fpu__restore_sig() actually takes very little percentage.
Consider this and later maintenance, I think copy_xregs_to_kernel() is at
least not worse than saving each state separately.

Yu-cheng


