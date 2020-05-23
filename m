Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2028EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 00:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3840206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 00:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbgEWAp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 20:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbgEWApz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 20:45:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799DBC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 17:45:55 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jcIIF-00075d-P1; Sat, 23 May 2020 02:45:39 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 1BECF100D0B; Sat, 23 May 2020 02:45:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Don Porter <porter@cs.unc.edu>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, bp@alien8.de, luto@kernel.org,
        hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: Re: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
In-Reply-To: <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
References: <20200511045311.4785-1-sashal@kernel.org> <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com> <20200515164013.GF29995@sasha-vm> <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com> <20200518153407.GA499505@tassilo.jf.intel.com> <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com> <87v9ksvoaq.fsf@nanos.tec.linutronix.de> <20200519164853.GA19706@linux.intel.com> <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
Date:   Sat, 23 May 2020 02:45:39 +0200
Message-ID: <87h7w7qy18.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don,

Don Porter <porter@cs.unc.edu> writes:
> On 5/19/20 12:48 PM, Jarkko Sakkinen wrote:
>> On Tue, May 19, 2020 at 01:03:25AM +0200, Thomas Gleixner wrote:
>>>
>>> That justifies to write books which recommend to load a kernel module
>>> which creates a full unpriviledged root hole. I bet none of these papers
>>> ever mentioned that.
>
> I wanted to clarify that we never intended the Graphene kernel module 
> you mention for production use, as well as to comment in support of this 
> patch.

let me clarify, that despite your intentions:

    - there is not a single word in any paper, slide deck, documentation
      etc. which mentions that loading this module and enabling FSGSBASE
      behind the kernels back is a fully unpriviledged root hole.

    - the module lacks a big fat warning emitted to dmesg, that this
      turns the host kernel into a complete security disaster.

    - the module fails to set the TAINT_CRAP flag when initialized.

This shows a pretty obvious discrepancy between intention and action.

> Setting the fs register in userspace is an essential feature for running 
> legacy code in SGX.  We have been following LKML discussions on this 
> instruction for years, and hoping this feature would be supported by 
> Linux, so that we can retire this module.

The way to get things done in the kernel is to actively work on the
problem. Hoping that someone else will fix that for you is naive at
best. Wilful ignorance might be a less polite but nevertheless accurate
term.

> To our knowledge, every SGX library OS has a similar module, waiting
> for this or a similar patch to be merged into Linux.  This indicates a
> growing user base that needs this instruction.

I'm failing to understand that a whole industry which is so confident
about their ultimate solution to the security problem puts possible
users and customers into the situation to decide between:

 1) Secure host kernel (with known limitations)

 2) SGX enclaves

I would not mind if this would be a choice between fire and frying pan,
but this is a choice between a well understood reality and a very
dangerous illusion.

> Nonetheless, Graphene is moving towards adoption in production systems, 
> and we are actively working to make the code base secure and robust. 
> This issue has been on our to-do list before a production release.  It 
> would certainly make our lives easier to deprecate our module and just 
> use a robust, in-kernel implementation.

Would make your life easier?

Having proper in kernel FSGSBASE support is the only solution to that
problem and this has been true since the whole SGX frenzy started. Intel
failed to upstream FSGSBASE since 2015 (sic!). See

  https://lore.kernel.org/lkml/alpine.DEB.2.21.1903261010380.1789@nanos.tec.linutronix.de/

for a detailed time line. And that mail is more than a year old.

Since then there happened even more trainwrecks including the revert of
already queued patches a few days before the 5.3 merge window opened.

After that we saw yet more broken variants of that patch set including
the fail to provide information which is required to re-merge that.

Instead of providing that information the next version re-introduced the
wreckage which was carefully sorted out during earlier review cycles up
to the revert.

So you (and everybody else who has interrest in SGX) just sat there,
watched and hoped that this will solve itself magically. And with that
"hope" argument you really want to make me believe that all of this was
against your intentions?

It's beyond hillarious that the renewed attempt to get FSGSBASE support
merged does not come from the company which has the main interest to get
this solved, i.e Intel.

Based on your argumentation that all of this is uninteded, I assume that
the pull request on github which removes this security hole from
graphene:

        https://github.com/oscarlab/graphene/pull/1529

is perfectly fine, right?

Quite the contrary, it's completely usesless and at the same time
perfectly fitting into this picture:

  The changelog is SGX marketing compliant: Zero technical content. Not
  a single word about the real implications of that blantant violation
  of any principle of sane (security) engineering.

Not that I'm surprised about this. That change originates from Intel and
the poor sod who had to place the pull request - coincidentally a few
days after this insanity became public - was not allowed to spell out
the real reasons why this removal is necessary.

Please read security relevant changelogs in the kernel git tree and then
explain to me the utter void in this one.

Looking at the advertising which all involved parties including the
Confidential Computing Consortium are conducting, plus the fact that
Intel has major investments in SGX supporting companies and projects,
this is one of the worst marketing scams I've seen in decades.

This all violates the fundamental engineering principle of "correctnes
first" and I'm flabbergasted that academic research has degraded into
the "features first" advocating domain.

What's worse it that public funded research is failing to serve the
public interest and instead is acting as an advertsiing machine for their
corporate sponsors.

Thanks,

        Thomas
 
