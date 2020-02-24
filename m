Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580C6C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D3D20828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgBXK30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:29:26 -0500
Received: from mail-a09.ithnet.com ([217.64.83.104]:59760 "EHLO
        mail-a09.ithnet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgBXK3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:29:25 -0500
Received: (qmail 29254 invoked by uid 0); 24 Feb 2020 10:29:23 -0000
Received: from skraw.ml@ithnet.com by mail-a09 
 (Processed in 4.581523 secs); 24 Feb 2020 10:29:23 -0000
X-Virus-Status: No
X-ExecutableContent: No
Received: from dialin014-sr.ithnet.com (HELO ithnet.com) (217.64.64.14)
  by mail-a09.ithnet.com with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 24 Feb 2020 10:29:18 -0000
X-Sender-Authentication: SMTP AUTH verified <skraw.ml@ithnet.com>
Date:   Mon, 24 Feb 2020 11:29:17 +0100
From:   Stephan von Krawczynski <skraw.ml@ithnet.com>
To:     Bernd Petrovitsch <bernd@tuxoid.at>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: General Discussion about GPLness
Message-ID: <20200224112917.201ffb29@ithnet.com>
In-Reply-To: <7896b0b9-c12e-5327-f531-95097cf04eca@tuxoid.at>
References: <8b0e828da35ab77c1ad4603768c6eab6@waifu.club>
        <20200223133301.03eab91d@ithnet.com>
        <2241a3e0c8dcba5b69b4f670e181d7cd@waifu.club>
        <20200223153909.1ba91bae@ithnet.com>
        <dadb648cd23ee79dacf5992ff5ca6094@waifu.club>
        <20200223214757.5adf49e4@ithnet.com>
        <7896b0b9-c12e-5327-f531-95097cf04eca@tuxoid.at>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 00:46:03 +0100
Bernd Petrovitsch <bernd@tuxoid.at> wrote:

> Hi all!

Hello Bernd,
 
> On 23/02/2020 21:47, Stephan von Krawczynski wrote:
> [...]
> > I do understand why you cannot enter a discussion with your real name, as
> > most  
> 
> I ignore folks who don't use their real name - this is since Usenet
> times an indication for a troll ...

Well, yes. But I don't want to start a topic and ignore the first answer right
away ... Call me naive
 
> > of your input is of zero quality - and below.  
> [...]
> >                                                              But our story
> > is about kernel modules, something everybody is free to write and publish,
> > with a  
> 
> ... publish implicitly with a GPLv2 or compatible license ...

Ok, you cannot really mean this. Because what you say is that no company
making some hardware is allowed to produce a closed-source kernel driver for
it. You know who are the last ones on the planet taking that approach? It's
China. If you want to build some car there, you have to give them all the
details of everything and only then are allowed to do a joint-venture with
chinese where you are not allowed to hold a majority.
You are saying that every company creating new hardware must open up the
details to it so that they themselves or someone else is capable to write a
GPL-driver for it. Is that the world you want to live in? China? Really?
 
> > defined and open interface for interaction. No kernel code is modified in
> > that  
> 
> And that's a point which is completely wrong: the only *defined*
> interface of the kernel is sys-calls, /proc and similar. And all of this
> is from user-space to kernel-space and back.

This is "said" to be so. But since I wrote several kernel drivers I know that
there is at least a skeleton of what a driver should look like. And this means
that there is a definition. I know what you mean. It is said that none of the
interfacing is defined as some standard written in stone. But we all know the
reason: the project wants to stay evulatory and wants to be able to implement
new - possibly better ideas. But only because its flowing does not mean there
is none. Else there would not be lots of people working on different drivers,
filesystems and the like. They all have to meet at some point in the code. And
that meeting point(s) is(are) the open interface. And it's open because
everyone is allowed to read the source and use the exported functions (be them
GPL-defined or not) to write some _extensions_.
 
> There is no (and never was) a "defined interface" within the kernel
> (inter-operating in kernel space) in any direction simply because the
> kernel-internal (infra)structure changes more or less constantly - some
> may call that evolution;-)

Yes, read above.
 
> And I don't get what an "open interface" here couls seriously mean. You
> surely don't want to call the list of the GPL_EXPORTed C functions
> (which may change from one kernel version to the next) an "open
> interface" (whatever that should suggest).
> 
> At most the list of GPL_EXPORTed C functions is a de-facto interface and
> that may change from one git-commit to the next.

The lifetime of the details of this interface is not relevant. Some last
years, some maybe only days. Nevertheless the EXPORT per se means that someone
_else_ should and can use them. Otherwise there would be no EXPORT definition.
 
> > sense. But you fail to understand that.
> > Hopefully others here do. I do not expect them to stand up and jump into a
> > discussion where you are a part of. But I hope people start to think about
> > it  
> 
> And you are barking up the wrong tree. The discussion has to happen in
> the ZFS-world so that they fix their license if they want to interface
> with any GPL software (without sys-calls etc. in between - WTF it works
> via FUSE) like they seen to do now.

Ok, now please stay serious. FUSE is nothing more than a hack for people who
want to make case studies on projects but is completely useless in production.
Because it is DEAD slow. If you want to check out, look at glusterfs (that
never managed to be implemented as kernel driver). And nobody used ZFS on FUSE,
because it was unusably slow. Since it has become a kernel space driver it is
amongst the best fs around.
But zfs is not the main issue. It is only an example of the problem. 
Companies and other entities must be allowed to make kernel drivers and
therefore interface with the kernel in kernel space no matter what licensing
they prefer. This is my opinion. I would love to hear if this really is the
projects' policy or not though. This is what this thread is all about.

Of course, I would prefer a GPL driver as well. That's why I use ATI and not
nvidia. But nevertheless I think nvidia and all the others should be allowed
to make their drivers. I'd say the rest is market/customer choice.

> MfG,
> 	Bernd

-- 
Regards,
Stephan

