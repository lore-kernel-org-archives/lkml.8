Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD93C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F6C20671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387768AbgERSUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbgERSUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:20:22 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A5AC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:20:21 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jakMz-00014W-EN; Mon, 18 May 2020 20:20:09 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 5F7B7100606; Mon, 18 May 2020 20:20:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org
Subject: Re: [PATCH v12 10/18] x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions
In-Reply-To: <20200511045311.4785-11-sashal@kernel.org>
Date:   Mon, 18 May 2020 20:20:08 +0200
Message-ID: <87v9ktw1ev.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sasha Levin <sashal@kernel.org> writes:
> +unsigned long x86_gsbase_read_cpu_inactive(void)
> +{
> +	unsigned long gsbase;
> +
> +	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
> +		bool need_restore = false;
> +		unsigned long flags;
> +
> +		/*
> +		 * We read the inactive GS base value by swapping
> +		 * to make it the active one. But we cannot allow
> +		 * an interrupt while we switch to and from.
> +		 */
> +		if (!irqs_disabled()) {
> +			local_irq_save(flags);
> +			need_restore = true;
> +		}
> +
> +		native_swapgs();
> +		gsbase = rdgsbase();
> +		native_swapgs();
> +
> +		if (need_restore)
> +			local_irq_restore(flags);

Where does this crap come from?

This conditional irqsave gunk is clearly NOT what was in the tip tree
before it got reverted:

  a86b4625138d ("x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions")

In https://lore.kernel.org/r/87ftcrtckg.fsf@nanos.tec.linutronix.de I
explicitely asked for this:

     - Made sure that the cleanups I did when merging them initially have
       been picked up. I'm not going to waste another couple of days on
       this mess just to revert it because it hadn't seen any serious
       testing in development.

and you confirmed in https://lore.kernel.org/r/20200426025243.GJ13035@sasha-vm

       Based on your revert
       (https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/cpu&id=049331f277fef1c3f2527c2c9afa1d285e9a1247)
       I believe that we have all the relevant patches in the series.

And the above while it might not have exploded yet, is simply broken
because the 'swapgs rd/wr swapgs' sequence is not protected against
kprobes. There is even a big fat comment in that original commit:

 /*
  * Out of line to be protected from kprobes. It is not used on Xen
  * paravirt. When paravirt support is needed, it needs to be renamed
  * with native_ prefix.
  */

Yes, you surely got all patches from the git tree and made sure that the
result reflects that.

I've just extracted the original commits from git and applied them and
fixed the trivial rejects. Then I diffed the result against this lot:

 - That above gunk, which is the worst of all

 - In paranoid_exit()

-	TRACE_IRQS_IRETQ_DEBUG
+	TRACE_IRQS_OFF_DEBUG

 - Dropped comments vs. FENCE_SWAPGS and a gazillion of comment
   changes to make reading the diff harder.

Then I gave up looking at it.

It took me ~ 20 minutes (ignoring selftests and documentation) to fixup
the rejects and create a patch queue which is reflecting the state
before the revert and does not have complete crap in it.

This required to add one preparatory patch dealing with the changes in
copy_thread_tls() and no, not by inlining all of that twice.

It took me another 5 minutes to get rid of the local_irq_save/restore()
in save_fsgs() on top without any conditional crap.

I'm seriously tired of this FSGSBASE mess. Every single version I've
looked at in several years was a trainwreck.

Don't bother to send out a new version of this in a frenzy. For my
mental sake I'm not going to look at yet another cobbled together
trainwreck anytime soon.

If you read the above carefully you might find a recipe of properly
engineering this so it's easy to verify against the old version.

Your's seriously grumpy

       tglx
