Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B111C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EB842075F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589833479;
	bh=UIlMPsBxt/3uFwd+3ALl23XD8Bu8p/uo768abtKMRwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cqn5Nb0lAzZM1UWVxQapNYvRnfm5tDBGn84Wmq/0m6KB8zRu79aFlFJ3qvmhNKbTK
	 iPRvSb83fpf/QDjC4U0tk0rm5d3W9zCbF3lb6GGZRbWkIepfgYb8lVzhUHYsCOe7Wp
	 bJe/gqJkdj0a4PbYKGxttJaT4q8X/6LDy/yxpD28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgERUYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 16:24:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgERUYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 16:24:38 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4C1A20643;
        Mon, 18 May 2020 20:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589833476;
        bh=UIlMPsBxt/3uFwd+3ALl23XD8Bu8p/uo768abtKMRwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tn29R9dKPUJfqsTE8NE6p03cYjeImGx6DWT2c3MUS0so9ZohoZF4pxUCWPZrLczPU
         WbzVSi/Fi60JtKYr0yakOO8aUJqIGV17K5vSSzijMEYQ4A5ouh/7rgMywJvtMkMXCN
         c3TPDLJmT+SECYThftL6vQ607f1CsmUZU/aBi/jQ=
Date:   Mon, 18 May 2020 16:24:35 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, luto@kernel.org,
        hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com,
        Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org
Subject: Re: [PATCH v12 10/18] x86/fsgsbase/64: Enable FSGSBASE instructions
 in helper functions
Message-ID: <20200518202435.GD33628@sasha-vm>
References: <20200511045311.4785-11-sashal@kernel.org>
 <87v9ktw1ev.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v9ktw1ev.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for taking the time to review this.

On Mon, May 18, 2020 at 08:20:08PM +0200, Thomas Gleixner wrote:
>Sasha Levin <sashal@kernel.org> writes:
>> +unsigned long x86_gsbase_read_cpu_inactive(void)
>> +{
>> +	unsigned long gsbase;
>> +
>> +	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
>> +		bool need_restore = false;
>> +		unsigned long flags;
>> +
>> +		/*
>> +		 * We read the inactive GS base value by swapping
>> +		 * to make it the active one. But we cannot allow
>> +		 * an interrupt while we switch to and from.
>> +		 */
>> +		if (!irqs_disabled()) {
>> +			local_irq_save(flags);
>> +			need_restore = true;
>> +		}
>> +
>> +		native_swapgs();
>> +		gsbase = rdgsbase();
>> +		native_swapgs();
>> +
>> +		if (need_restore)
>> +			local_irq_restore(flags);
>
>Where does this crap come from?
>
>This conditional irqsave gunk is clearly NOT what was in the tip tree
>before it got reverted:
>
>  a86b4625138d ("x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions")

It wasn't in the reverted series, it came in Intel's v9 series, with
these comments in the cover letter:

	Updates from v8 [10]:
	[...]
	* Simplified GS base helper functions (Tony L.)

>In https://lore.kernel.org/r/87ftcrtckg.fsf@nanos.tec.linutronix.de I
>explicitely asked for this:
>
>     - Made sure that the cleanups I did when merging them initially have
>       been picked up. I'm not going to waste another couple of days on
>       this mess just to revert it because it hadn't seen any serious
>       testing in development.
>
>and you confirmed in https://lore.kernel.org/r/20200426025243.GJ13035@sasha-vm
>
>       Based on your revert
>       (https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/cpu&id=049331f277fef1c3f2527c2c9afa1d285e9a1247)
>       I believe that we have all the relevant patches in the series.

And I did, Thomas. While I'm not intimately familiar with the code I
made sure that all the patches that came on top of the merged series
before it got reverted made it into this new series. However, more work
has happened here after the revert and I would expect that the code in
this new series will be different than the code you reverted last year.

>And the above while it might not have exploded yet, is simply broken
>because the 'swapgs rd/wr swapgs' sequence is not protected against
>kprobes. There is even a big fat comment in that original commit:
>
> /*
>  * Out of line to be protected from kprobes. It is not used on Xen
>  * paravirt. When paravirt support is needed, it needs to be renamed
>  * with native_ prefix.
>  */
>
>Yes, you surely got all patches from the git tree and made sure that the
>result reflects that.
>
>I've just extracted the original commits from git and applied them and
>fixed the trivial rejects. Then I diffed the result against this lot:
>
> - That above gunk, which is the worst of all

Changed in v9 of the series.

> - In paranoid_exit()
>
>-	TRACE_IRQS_IRETQ_DEBUG
>+	TRACE_IRQS_OFF_DEBUG

(assuming we're looking at the same thing here, ) Changed in v8 of the
series.

> - Dropped comments vs. FENCE_SWAPGS and a gazillion of comment
>   changes to make reading the diff harder.

Changed in every version after the revert:

  - v7:
    - "Add more comments for entry changes"
  - v8:
    - "Carried on Thomas' edits on multiple changelogs and comments"
  - v9:
    - "Fixed typos (Randy D.) and massaged a few sentences in the
      documentation"

>Then I gave up looking at it.
>
>It took me ~ 20 minutes (ignoring selftests and documentation) to fixup
>the rejects and create a patch queue which is reflecting the state
>before the revert and does not have complete crap in it.
>
>This required to add one preparatory patch dealing with the changes in
>copy_thread_tls() and no, not by inlining all of that twice.
>
>It took me another 5 minutes to get rid of the local_irq_save/restore()
>in save_fsgs() on top without any conditional crap.
>
>I'm seriously tired of this FSGSBASE mess. Every single version I've
>looked at in several years was a trainwreck.
>
>Don't bother to send out a new version of this in a frenzy. For my
>mental sake I'm not going to look at yet another cobbled together
>trainwreck anytime soon.
>
>If you read the above carefully you might find a recipe of properly
>engineering this so it's easy to verify against the old version.

I'm a bit confused about the surprise here that v12 is different than
the reverted patches. There were multiple rounds of review which
resulted in the code being more than just a revert of the revert along
with a small fix.

This very issue was brought up by Andy in v7 of the series:

On Mon, Sep 16, 2019 at 11:38 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 12 Sep 2019, Andy Lutomirski wrote:
> > On 9/12/19 1:06 PM, Chang S. Bae wrote:
> > > Updates from v7 [7]:
> > > (1) Consider FSGSBASE when determining which Spectre SWAPGS mitigations are
> > >      required.
> > > (2) Fixed save_fsgs() to be aware of interrupt conditions
> > > (3) Made selftest changes based on Andy's previous fixes and cleanups
> > > (4) Included Andy's paranoid exit cleanup
> > > (5) Included documentation rewritten by Thomas
> > > (6) Carried on Thomas' edits on multiple changelogs and comments
> > > (7) Used '[FS|GS] base' consistently, except for selftest where GSBASE has
> > >      been already used in its test messages
> > > (8) Dropped the READ_MSR_GSBASE macro
> > >
> >
> > This looks unpleasant to review.  I wonder if it would be better to unrevert
> > the reversion, merge up to Linus' tree or -tip, and then base the changes on
> > top of that.
>
> I don't think that's a good idea. The old code is broken in several ways
> and not bisectable. So we really better start from scratch.

And this is what we have here, a series that has more than trivial
differences from the revert, and is more of a pain to review. Look at
what you did with your 25 minutes: you've reverted the revert and went
on to apply fixes on top of it, exactly the thing you've asked
not to do a few months prior.

No need to worry about me sending a new series, as I can't - I just
don't know what you want to see at this point: on one hand you're saying
"we really better start from scratch" and on the other hand "this
conditional irqsave gunk is clearly NOT what was in the tip tree before
it got reverted", you're making suggestions to change comments only to
later complain that "a gazillion of comment changes make reading the
diff harder". 

-- 
Thanks,
Sasha
