Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8FCC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097B32084E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgBYNdy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 08:33:54 -0500
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:3190 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbgBYNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 08:33:54 -0500
Received: from [10.68.100.236] (h10-gesig.woeg.acw.at [217.116.178.11] (may be forged))
        (authenticated bits=0)
        by esgaroth.tuxoid.at (8.15.2/8.15.2) with ESMTPSA id 01PDXQ31001483
        (version=TLSv1 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Tue, 25 Feb 2020 14:33:26 +0100
From:   Bernd Petrovitsch <bernd@tuxoid.at>
Subject: Re: General Discussion about GPLness
To:     Stephan von Krawczynski <skraw.ml@ithnet.com>
Cc:     linux-kernel@vger.kernel.org
References: <8b0e828da35ab77c1ad4603768c6eab6@waifu.club>
 <20200223133301.03eab91d@ithnet.com>
 <2241a3e0c8dcba5b69b4f670e181d7cd@waifu.club>
 <20200223153909.1ba91bae@ithnet.com>
 <dadb648cd23ee79dacf5992ff5ca6094@waifu.club>
 <20200223214757.5adf49e4@ithnet.com>
 <7896b0b9-c12e-5327-f531-95097cf04eca@tuxoid.at>
 <20200224112917.201ffb29@ithnet.com>
X-Pep-Version: 2.0
Message-ID: <4de67383-671d-1870-e385-55dbf49dc8f3@tuxoid.at>
Date:   Tue, 25 Feb 2020 13:33:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224112917.201ffb29@ithnet.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-DCC--Metrics: esgaroth.tuxoid.at 1480; Body=2 Fuz1=2 Fuz2=2
X-Virus-Scanned: clamav-milter 0.97 at esgaroth.tuxoid.at
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

On 24/02/2020 10:29, Stephan von Krawczynski wrote:
> On Mon, 24 Feb 2020 00:46:03 +0100
> Bernd Petrovitsch <bernd@tuxoid.at> wrote:
[...]
>> On 23/02/2020 21:47, Stephan von Krawczynski wrote:
[...]
>> ... publish implicitly with a GPLv2 or compatible license ...
> 
> Ok, you cannot really mean this. Because what you say is that no company
> making some hardware is allowed to produce a closed-source kernel driver for

It's not that simple - in neither direction (and no, I won't give guidelines
or reproduce the lame excuses and/or other reasons for creating "proprietary
Linux kernel drivers". They can very probably be found via $SEARCH_ENGINE
anyways).

The law term is "derived work" (you will probably find lots of
discussions if you $SEARCH_ENGINE it) and it's up to the module/driver
author to prove that the module/driver is not derived work from the
GPLed software it interoperates.
If you copy a skeleton driver (or cannibalise another driver) it's hard
to say it's not derived.

For the syscall layer, there exists POSIX, SUSv3 et.al. as well as lots
of more or more-the-like less identical implementations long before the
first line of .c of the Kernel.

One ugly and nasty thing about law is that it's not automatically
correct just because one (company or person) does/claims it. And it
doesn't make it right, legal, etc.
Not sueing that one also doesn't change a bit of the legal status.

Another even more ugly and nasty thing about a given law is that it's
bound to it's jurisdiction. Yes, some countries/goverments/
administrations want to extend it beyond their own and several can
actually do that but we are again in political swamp.
In short: Law people basically ignored the globalization as I see almost
no progress in the last decades in that area - just lame excuses and
propaganda-style discussions about the "law less internet" - there is
no "law less" area on the world as everywhere is at least one
jurisdiction.

> it. You know who are the last ones on the planet taking that approach? It's> China. If you want to build some car there, you have to give them all the

It is neither technically nor law-wise relevant and/or interesting or a
point for or against anything if some powers-that-be plain simply ignore
laws. At most, it's a political thing ....

> details of everything and only then are allowed to do a joint-venture with
> chinese where you are not allowed to hold a majority.

And every sane company which sees this should think about it and then
decide if they want to go there. I wouldn't do that (and hadn't do that
15 years ago).
Obviously a lot of them have no problem with these kind of "giving away
intellectual property, know-how and God knows what more". There are many
more stories about "what happens after moving $FACTORY to China" which
are off-topic here ....

> You are saying that every company creating new hardware must open up the
> details to it so that they themselves or someone else is capable to write a
> GPL-driver for it. Is that the world you want to live in? China? Really?

For one that's IMHO the basic intention of the GPL (read and think about
"the four essential freedoms" on
https://www.gnu.org/philosophy/free-sw.html and their implications).
And one main reason is that the user of the driver withthe 4 freedoms is
capable of fixing errors in it - ask RMS about it;-)

And it's IMNSHO *not* the intention of China to produce an open, better
world - quite the contrary - so please don't try compare that or use that
in any discussion/analysis.

BTW it's IMHO a major difference between publishing documentation for
everyone just for creating interoperable software and forcing others to
release (all?) information and allow major influence for nation-controlled
bodies to company/project/organizations as such.

>>> defined and open interface for interaction. No kernel code is modified in
>>> that  
>>
>> And that's a point which is completely wrong: the only *defined*
>> interface of the kernel is sys-calls, /proc and similar. And all of this
>> is from user-space to kernel-space and back.
> 
> This is "said" to be so. But since I wrote several kernel drivers I know that
> there is at least a skeleton of what a driver should look like. And this means
> that there is a definition. I know what you mean. It is said that none of the

No, that's only an implementation model - even if it's published in a book.
The point is: It may change with any git-commit so it's a total different story
than syscalls et.al. (which are set in stone and it may produce "funny"
discussions if people want to bug-fix something there).

And you always have implicit skeleton (e.g. simple) drivers (think "/dev/null"
if you are looking for a minimalistic char driver) which people take as model
or even copy and edit them.
BTW if you copied a GPLv2 driver/skeleton/enough source code, you also copied
it's license too. Authors rights and copyright 101 .....

> interfacing is defined as some standard written in stone. But we all know the
> reason: the project wants to stay evulatory and wants to be able to implement
> new - possibly better ideas. But only because its flowing does not mean there> is none. Else there would not be lots of people working on different drivers
> filesystems and the like. They all have to meet at some point in the code. And
> that meeting point(s) is(are) the open interface. And it's open because

But it's not a *defined* interface in any technical interpretation. Do you
consider an interface which changes in every release (without backward
compatibility) a "defined interface"? I don't ....

At most it's a documented interface ...

If you want a *defined* driver interface, go to the Windows world as M$FT is
committed to maintain kernel-internal interfaces across major versions (yes,
they don't do it in 100% of all cases - just talk to Windows driver
maintainers which have to touch their driver with at least every version
...).

> everyone is allowed to read the source and use the exported functions (be them
> GPL-defined or not) to write some _extensions_.
>  
>> There is no (and never was) a "defined interface" within the kernel
>> (inter-operating in kernel space) in any direction simply because the
>> kernel-internal (infra)structure changes more or less constantly - some
>> may call that evolution;-)
[...]
>> And I don't get what an "open interface" here couls seriously mean. You
>> surely don't want to call the list of the GPL_EXPORTed C functions
>> (which may change from one kernel version to the next) an "open
>> interface" (whatever that should suggest).
>>
>> At most the list of GPL_EXPORTed C functions is a de-facto interface and
>> that may change from one git-commit to the next.
> 
> The lifetime of the details of this interface is not relevant. Some last
> years, some maybe only days. Nevertheless the EXPORT per se means that someone
> _else_ should and can use them. Otherwise there would be no EXPORT definition.

EXPORT has the same semantics from the (running) kernel to modules that
"extern" has in .c from one .o to another .o as you can't use the function
in a module without EXPORT - not more, not less.

>>> sense. But you fail to understand that.
>>> Hopefully others here do. I do not expect them to stand up and jump into a
>>> discussion where you are a part of. But I hope people start to think about
>>> it  
>>
>> And you are barking up the wrong tree. The discussion has to happen in
>> the ZFS-world so that they fix their license if they want to interface
>> with any GPL software (without sys-calls etc. in between - WTF it works
>> via FUSE) like they seen to do now.
> 
> Ok, now please stay serious. FUSE is nothing more than a hack for people who

I'm dead serious. I actually thought we talked about license/law stuff and
runtime situations which have no relevance when it comes to license/law issues.

> want to make case studies on projects but is completely useless in production.
> Because it is DEAD slow. If you want to check out, look at glusterfs (that
And it solves the license issue. That's the price to pay, it's one possible
solution to your license problem, it's up to you where you find the - Your -
least cumbersome compromise ....

> never managed to be implemented as kernel driver). And nobody used ZFS on FUSE,
> because it was unusably slow. Since it has become a kernel space driver it is
> amongst the best fs around.

That's all completely irrelevant for license and law discussions.

> But zfs is not the main issue. It is only an example of the problem. 

So what's the main issue that you abuse ZFS for your agenda?

You feel limited by the GPLv2 (or any othre license)? Then don't use such
software. Problem solved.

Hell, there are people out there who will help only in GPL projects (and not
BSD and near-BSD as that's basically - and intentionally(!)- a "proprietary
license on call").

> Companies and other entities must be allowed to make kernel drivers and
> therefore interface with the kernel in kernel space no matter what licensing

Everyone can integrate ZFS on their own and themselves in their product
without any license issue.

> they prefer. This is my opinion. I would love to hear if this really is the
> projects' policy or not though. This is what this thread is all about.
> 
> Of course, I would prefer a GPL driver as well. That's why I use ATI and not
> nvidia. But nevertheless I think nvidia and all the others should be allowed
> to make their drivers. I'd say the rest is market/customer choice.

Market/customer choice is completely irrelevant for license and law
discussions.

Well, please search in the LKML archives - we have such discussions every
other year here and it won't (and can't) change the GPLv2 (or other versions)
as such.
And for a license change of the Linux kernel, you need the explicit agreement
from all contributors (at least for the more than trivial patches like "fixed
typo" etc. - that's another law discussion when my patch is not trivial enough
so that authors rights/copyright is actually applicable),

MfG,
	Bernd

PS: For all others: That's the end of the discussion from my side - I already
    wrote more than enough and I don't think can (or want) write anything not
    already written in this thread (by /me - of course;-).
-- 
"I dislike type abstraction if it has no real reason. And saving
on typing is not a good reason - if your typing speed is the main
issue when you're coding, you're doing something seriously wrong."
    - Linus Torvalds

