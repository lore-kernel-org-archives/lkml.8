Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448CDC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6B0206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgCMKaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:30:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:20815 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbgCMKaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:30:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 03:30:02 -0700
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400"; 
   d="scan'208";a="237179068"
Received: from unknown (HELO localhost) ([10.252.52.87])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 03:29:59 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Greg KH <greg@kroah.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Bird\, Tim" <Tim.Bird@sony.com>,
        "ksummit-discuss\@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "tech-board-discuss\@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Tech-board-discuss] [Ksummit-discuss] Linux Foundation Technical Advisory Board Elections -- Change to charter
In-Reply-To: <20200313093548.GA2089143@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <6d6dd6fa-880f-01fe-6177-281572aed703@labbott.name> <20200312003436.GF1639@pendragon.ideasonboard.com> <MWHPR13MB0895E133EC528ECF50A22100FDFD0@MWHPR13MB0895.namprd13.prod.outlook.com> <20200313031947.GC225435@mit.edu> <87d09gljhj.fsf@intel.com> <20200313093548.GA2089143@kroah.com>
Date:   Fri, 13 Mar 2020 12:30:20 +0200
Message-ID: <877dzolf7n.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020, Greg KH <greg@kroah.com> wrote:
> On Fri, Mar 13, 2020 at 10:58:00AM +0200, Jani Nikula wrote:
>> On Thu, 12 Mar 2020, "Theodore Y. Ts'o" <tytso@mit.edu> wrote:
>> > So that means we need to be smart about how we pick the criteria.
>> > Using a kernel.org account might be a good approach, since it would be
>> > a lot harder for a huge number of sock puppet accounts to meet that
>> > criteria.
>> 
>> Per [1] and [2], kernel.org accounts "are usually reserved for subsystem
>> maintainers or high-profile developers", but apparently it's at the
>> kernel.org admins discretion to decide whether one is ultimately
>> eligible or not. Do we want the kernel.org admin to have the final say
>> on who gets to vote? Do we want to encourage people to have kernel.org
>> accounts for no other reason than to vote?
>
> We are using the "kernel.org account" as a way to verify that you really
> are part of our developer/maintainer community and that you are part of
> the "web of trust" and an actual person.
>
> That is the goal here, if you know of some other way to determine this,
> please let us know.  We went through many iterations of this and at the
> moment, it is the best we can come up with.

Ted's mail seemed like it was thrown around as an idea, not something
you're settling on.

> Also, note that the "kernel.org admin" is really a team of people who
> have been doing this for 9 years, it's not a single person responsible
> for giving out new accounts to people that do not meet the obvious
> requirement levels as published on kernel.org
>
>> Furthermore, having a kernel.org account imposes the additional
>> requirement that you're part of the kernel developers web of trust,
>
> That is exactly what we want.

Fair enough.

>> i.e. that you've met other kernel developers in person. Which is a kind
>> of awkward requirement for enabling electronic voting to be inclusive to
>> people who can't attend in person.
>
> Yes, we know that, but it does mean that you are "known" to someone
> else, which is the key here.
>
>> Seems like having a kernel.org account is just a proxy for the criteria,
>> and one that also lacks transparency, and has problems of its own.
>
> What is not transparent about how to get a kernel.org account?

There is no way of knowing whether you're eligible to vote until you
apply for a kernel.org account and either get approved or rejected.

The current "obvious" requirement levels are not obvious to me. How many
contributions is enough? Is everyone in MAINTAINERS eligible, or do you
have to be a high-profile maintainer/developer? What is a high-profile
developer? How many people in the web of trust must you have met in
person?

And it actually seems like you think it's a good thing the admin team
can make a subjective decision on the above.

It may seem completely transparent and fair and objective on the
*inside*, but it does not look that way on the *outside*. Which is kind
of the definition of transparent. Or lack of.

>> Not that I'm saying there's an easy solution, but obviously kernel.org
>> account is not as problem free as you might think.
>
> We are not saying it is "problem free", but what really is the problem
> with it?

Seems that some of what I thought was a bug is a feature for you, so I
suppose it's better to focus on the transparency.

On that note, and since this relates to the charter, how's the "The TAB
shall provide transparent and timely reporting (through any mechanism it
deems appropriate) to the Community at large on all of its activities"
coming along...?

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
