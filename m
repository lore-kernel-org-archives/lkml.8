Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE495C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862A6207D8
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dEloyhVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388152AbgEXTpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 15:45:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34581 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387794AbgEXTpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 15:45:52 -0400
Received: from [IPv6:2601:646:8600:3281:f972:cb22:f020:43c1] ([IPv6:2601:646:8600:3281:f972:cb22:f020:43c1])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 04OJjQbV2518016
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sun, 24 May 2020 12:45:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 04OJjQbV2518016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020042201; t=1590349528;
        bh=PFwOAT8cwhsGVA6I32zbsFgZNgXnmnYexYhHTyGyL0I=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=dEloyhVQnlI9vUHB9uZseruChOA01fAtJSVljqtscttK0oswuXBvB6K9qSleKvdvb
         Dd0cAqcPZuw8o78L0X03+GUZtlRfj8aBJus1zCrwvEyRNrlMQLwezjsFZAOT1HoxwG
         j8bihKHfH0olhxIucdLn8+IkOujBLS+duGZjJeankgNNHad4VuMJ9NKPglSIIhEwvs
         gsoxdATGTAre+exZ0LtqrCD9EKLAQ7UHPwo+Jb/tfZXVJR8mKXFPLumLxRUNxxMgWq
         /Dw9X6AM/Y5RvE++KsZKuEHV2gnnZLjJCAUdjniVjtn4twWaASow0NqnrtsJkSDWeE
         dYP9eYSACKe3g==
Date:   Sun, 24 May 2020 12:45:18 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <87h7w7qy18.fsf@nanos.tec.linutronix.de>
References: <20200511045311.4785-1-sashal@kernel.org> <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com> <20200515164013.GF29995@sasha-vm> <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com> <20200518153407.GA499505@tassilo.jf.intel.com> <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com> <87v9ksvoaq.fsf@nanos.tec.linutronix.de> <20200519164853.GA19706@linux.intel.com> <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu> <87h7w7qy18.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
To:     Thomas Gleixner <tglx@linutronix.de>,
        Don Porter <porter@cs.unc.edu>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Andi Kleen <ak@linux.intel.com>, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, bp@alien8.de, luto@kernel.org,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
From:   hpa@zytor.com
Message-ID: <A9483B8B-C0DD-46CB-AD5D-D12EC61BB331@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 22, 2020 5:45:39 PM PDT, Thomas Gleixner <tglx@linutronix=2Ede> wrot=
e:
>Don,
>
>Don Porter <porter@cs=2Eunc=2Eedu> writes:
>> On 5/19/20 12:48 PM, Jarkko Sakkinen wrote:
>>> On Tue, May 19, 2020 at 01:03:25AM +0200, Thomas Gleixner wrote:
>>>>
>>>> That justifies to write books which recommend to load a kernel
>module
>>>> which creates a full unpriviledged root hole=2E I bet none of these
>papers
>>>> ever mentioned that=2E
>>
>> I wanted to clarify that we never intended the Graphene kernel module
>
>> you mention for production use, as well as to comment in support of
>this=20
>> patch=2E
>
>let me clarify, that despite your intentions:
>
>   - there is not a single word in any paper, slide deck, documentation
>     etc=2E which mentions that loading this module and enabling FSGSBASE
>      behind the kernels back is a fully unpriviledged root hole=2E
>
>    - the module lacks a big fat warning emitted to dmesg, that this
>      turns the host kernel into a complete security disaster=2E
>
>    - the module fails to set the TAINT_CRAP flag when initialized=2E
>
>This shows a pretty obvious discrepancy between intention and action=2E
>
>> Setting the fs register in userspace is an essential feature for
>running=20
>> legacy code in SGX=2E  We have been following LKML discussions on this=
=20
>> instruction for years, and hoping this feature would be supported by=20
>> Linux, so that we can retire this module=2E
>
>The way to get things done in the kernel is to actively work on the
>problem=2E Hoping that someone else will fix that for you is naive at
>best=2E Wilful ignorance might be a less polite but nevertheless accurate
>term=2E
>
>> To our knowledge, every SGX library OS has a similar module, waiting
>> for this or a similar patch to be merged into Linux=2E  This indicates
>a
>> growing user base that needs this instruction=2E
>
>I'm failing to understand that a whole industry which is so confident
>about their ultimate solution to the security problem puts possible
>users and customers into the situation to decide between:
>
> 1) Secure host kernel (with known limitations)
>
> 2) SGX enclaves
>
>I would not mind if this would be a choice between fire and frying pan,
>but this is a choice between a well understood reality and a very
>dangerous illusion=2E
>
>> Nonetheless, Graphene is moving towards adoption in production
>systems,=20
>> and we are actively working to make the code base secure and robust=2E=
=20
>> This issue has been on our to-do list before a production release=2E=20
>It=20
>> would certainly make our lives easier to deprecate our module and
>just=20
>> use a robust, in-kernel implementation=2E
>
>Would make your life easier?
>
>Having proper in kernel FSGSBASE support is the only solution to that
>problem and this has been true since the whole SGX frenzy started=2E
>Intel
>failed to upstream FSGSBASE since 2015 (sic!)=2E See
>
>https://lore=2Ekernel=2Eorg/lkml/alpine=2EDEB=2E2=2E21=2E1903261010380=2E=
1789@nanos=2Etec=2Elinutronix=2Ede/
>
>for a detailed time line=2E And that mail is more than a year old=2E
>
>Since then there happened even more trainwrecks including the revert of
>already queued patches a few days before the 5=2E3 merge window opened=2E
>
>After that we saw yet more broken variants of that patch set including
>the fail to provide information which is required to re-merge that=2E
>
>Instead of providing that information the next version re-introduced
>the
>wreckage which was carefully sorted out during earlier review cycles up
>to the revert=2E
>
>So you (and everybody else who has interrest in SGX) just sat there,
>watched and hoped that this will solve itself magically=2E And with that
>"hope" argument you really want to make me believe that all of this was
>against your intentions?
>
>It's beyond hillarious that the renewed attempt to get FSGSBASE support
>merged does not come from the company which has the main interest to
>get
>this solved, i=2Ee Intel=2E
>
>Based on your argumentation that all of this is uninteded, I assume
>that
>the pull request on github which removes this security hole from
>graphene:
>
>        https://github=2Ecom/oscarlab/graphene/pull/1529
>
>is perfectly fine, right?
>
>Quite the contrary, it's completely usesless and at the same time
>perfectly fitting into this picture:
>
>  The changelog is SGX marketing compliant: Zero technical content=2E Not
>  a single word about the real implications of that blantant violation
>  of any principle of sane (security) engineering=2E
>
>Not that I'm surprised about this=2E That change originates from Intel
>and
>the poor sod who had to place the pull request - coincidentally a few
>days after this insanity became public - was not allowed to spell out
>the real reasons why this removal is necessary=2E
>
>Please read security relevant changelogs in the kernel git tree and
>then
>explain to me the utter void in this one=2E
>
>Looking at the advertising which all involved parties including the
>Confidential Computing Consortium are conducting, plus the fact that
>Intel has major investments in SGX supporting companies and projects,
>this is one of the worst marketing scams I've seen in decades=2E
>
>This all violates the fundamental engineering principle of "correctnes
>first" and I'm flabbergasted that academic research has degraded into
>the "features first" advocating domain=2E
>
>What's worse it that public funded research is failing to serve the
>public interest and instead is acting as an advertsiing machine for
>their
>corporate sponsors=2E
>
>Thanks,
>
>        Thomas
>=20

On a related topic (needless to say, this should never have happened and i=
s being raised at the highest levels inside Intel):

There are legitimate reasons to write a root-hole module, the main one bei=
ng able to test security features like SMAP=2E I have requested before a TA=
INT flag specifically for this purpose, because TAINT_CRAP is nowhere near =
explicit enough, and is also used for staging drivers=2E Call it TAINT_TOXI=
C or TAINT_ROOTHOLE; it should always be accompanied with a CRIT level aler=
t=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
