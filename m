Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E29C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 12:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFBD206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 12:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=waifu.club header.i=@waifu.club header.b="VcNMyCas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgBWM4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 07:56:19 -0500
Received: from mx1.cock.li ([185.10.68.5]:46317 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726592AbgBWM4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 07:56:19 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=waifu.club; s=mail;
        t=1582462574; bh=4ITLP1PGeo1OSB8THVq3LWuy2mKx3wLhor3GPRr25vs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VcNMyCasv+cKcIEd3T/Ul42UJ/jnSKlPjDFpwrQvzRwaTX/monqFLr9Nb87enjsKx
         B1hQDPv8+D6dBy4msVpCraaCOmt3yCXfb03TTR+AHZ+8v94R/LsF9Hl1xYzb3jZupL
         MenIJBZrU8Sm0qvAfaI8MJYtz9+SKWV1Hq5Y7wnRzI0TmUVSwktcs8cIhDo6DGK/s5
         lx7mUHE78uP7pkTCW+TPo0Ig7m3fHMpk9qHXabHvt8Aiv3lNOVJz/Wk7waoaY/f+rI
         p5VaGEcXyVaqJ6+ENqWo8PQ+8qScYTiYmCrKb6ahW5SPuAEJkTr6CiimcK6dW/ZOYC
         mr/ral6ezHdlg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 23 Feb 2020 12:56:13 +0000
From:   whywontyousue@waifu.club
To:     Stephan von Krawczynski <skraw.ml@ithnet.com>
Cc:     linux-kernel@vger.kernel.org, rms@gnu.org, bruce@perens.com,
        bind-users@lists.isc.org
Subject: Re: General Discussion about GPLness
In-Reply-To: <20200223133301.03eab91d@ithnet.com>
References: <8b0e828da35ab77c1ad4603768c6eab6@waifu.club>
 <20200223133301.03eab91d@ithnet.com>
Message-ID: <2241a3e0c8dcba5b69b4f670e181d7cd@waifu.club>
X-Sender: whywontyousue@waifu.club
User-Agent: Roundcube Webmail/1.3.10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you don't understand English, it will be difficult to get any points 
across to you. I will try

In simple terms:
1) Look up the court case "Universal City Studios Inc v Reimerdes,"

2) In this case someone else' software was running at the same time as 
the other persons software, and made changes, extensions _ONLY_ when 
running. Just like a non-gpl'd (or gpl'd) module might make changes and 
extensions.

3) The court found this was obviously a modification of the Copyright 
owners Work and barred in on summary judgement.

That is why you're not allowed to do as you wish with non-gpl'd modules: 
the US Copyright Jurisprudence forbids marring a Copyright owners 
_running_ _in_memory_ property against his wishes: it's a Copyright 
violation.

That is the reason: people don't want to get sued. That is the ONLY 
reason. That's it.

The thing is, the linux copyright owners are wimps and won't sue anyone 
even for blatant infringement; so what is the conversation about?

It's like if you were in Russia, and you were copying DVDs. No one is 
going to punish you for it: so what is there to discuss? The US 
Copyright owners don't have the rocks to Invade Russia, Start a Nuclear 
Winter, and DESTROY you for your Copyright Infringement in Russia.

JUST AS, the DOG LIKE Linux Copyright owners don't have the BALLS to 
risk being blackballed from the programming industry for DEFENDING THEIR 
COPYRIGHT.

The GPL ___IS___ dead. The FSF doesn't protect GCC copyright, and is 
opposed to taking any action against blantant in-writing infringers 
(OpenSourceSecurity (Grsecurity)) of GCC, just as the LINUX COMMUNITY is 
OPPOSED to taking ANY action to defend its Copyrights and moves to 
PUNISH those rightsholders who do.

> And another thing: court is for lawyers. Whenever the lawyers take over
> something they don't (want to) understand the end is near ...

I'm a lawyer and a programmer, got something to say?


> How about talking with real names?
Why would I do that? Tell me? What is in it for me?
I can stand here, in the forest, taking shots at your bullshit. Safe. 
Secure. My words and their veracity the only measure.

But if I reveal the messanger; you'll just attack the messenger.
Tell me how _I_ benifit from telling YOU my name. Tell me.
Is it some sort of stupid werkin man white man bravado?

> I have no idea why you spam rms or bruce
> with this, as the question is all about _one_ project, namely 
> linux-kernel.

You sent a message to the LKML "Hey why can't I violate the GPL? Let's 
just do it!". IE: a licensing discussion. RMS and Bruce Perens, the 
founder of the Free Software Movement and the Open Source Initiative are 
relevant parties to the discussion.


> I'd suggest taking them off this topic again ...
You also suggested I reveal my identity on the internet...


On 2020-02-23 12:33, Stephan von Krawczynski wrote:
> Dear whoeveryouare,
> 
> can you please state in a clearer form (more understandable to 
> non-native
> english talkers) what your true opinion on the topic is?
> And in case you did not understand what I was saying, here is clearer 
> form of
> my opinion:
> 
> A kernel module with another license (be it whatsoever) is _no_ 
> modification
> of the kernel, but an extension of its features. If feature-extension 
> is
> against the GPL (which I seriously doubt) then I would say "go back 
> onto your
> trees". Because the human race and evolution is about little else than
> feature-extension.
> 
> And another thing: court is for lawyers. Whenever the lawyers take over
> something they don't (want to) understand the end is near ...
> 
> How about talking with real names? I have no idea why you spam rms or 
> bruce
> with this, as the question is all about _one_ project, namely 
> linux-kernel.
> I'd suggest taking them off this topic again ...
> 
> --
> Regards,
> Stephan
> 
> 
> 
> On Sun, 23 Feb 2020 11:03:56 +0000
> whywontyousue@waifu.club wrote:
> 
>> Dear Stephan von Krawczynski;
>> 
>> Universal City Studios Inc v Reimerdes, piece of shit.
>> 
>> "[The court] reasoned that Ferret consumers who used the Ferret as a
>> plug-in to the Real Player altered the Real Player user interface by
>> adding the Snap search button or replacing it with the Stream box 
>> search
>> engine button. The court concluded that the plaintiff raised 
>> sufficently
>> serious questions going to the merits of its claims to warrant an
>> injunction pending trial"
>> 
>> Want to violate the linux kernel copyright, you fucking piece of shit?
>> Yes you do. Yes modifying the running kernel with violating pieces is
>> copyright infringement, you fucking piece of shit. Yes you should be
>> sued. Just as Open Source Security (Grsecurity) should be sued for 
>> their
>> violations (of section 4 and 6 of the linux kernel copyright license
>> (they're also violating the GCC copyrights too)).
>> 
>> Will they be sued? Will you be sued? No: Linux copyright holders are
>> scared little wageslave worker bees. They aren't going to sue you;
>> sorry. Why are you even announcing you intent to violate the 
>> copyright?
>> Why even give these dogs such intellectual deference?
>> 
>> I wish OpenSourceSecurity would be sued. I wish you would be sued. But
>> linux WERKIN MAHN wage slave piece of shit idiots won't do it: I hate
>> them much more than I hate the violators. Complete Dogs. They could 
>> move
>> from strenght to strenght, from victory to victory; but they're scared
>> for their "JEHRB"s. I have to say: white men are pathetic scum. If 
>> Linux
>> was built by others there would rightfully be lawsuits.
>> 
>> 
>> 
>> > Stephan von Krawczynski wrote:
>> > Hello all,
>> >
>> > you may have already heard about it or not (several times in the past),
>> > non-kernel devices run into a symbol export problem as soon as
>> > something is
>> > only exported GPL from the kernel.
>> > Currently there is a discussion regarding zfs using this call chain:
>> >
>> > vdev_bio_associate_blkg (zfs) -> blkg_tryget (kernel) ->
>> > percpu_ref_tryget
>> > (kernel) -> rcu_read_unlock (kernel) -> __rcu_read_unlock (kernel)
>> >
>> > where __rcu_read_[lock|unlock] is a GPL symbol now used by (not GPL
>> > exported)
>> > percpu_ref_tryget.
>> >
>> > That this popped up (again) made me think a bit more general about the
>> > issue.
>> > And I do wonder if this rather ideologic problem is on the right track
>> > currently. Because what the kernel tries to do with the export GPL
>> > symbol
>> > stuff is to prevent any other licensed software from _using_ it in
>> > _runtime_.
>> > It does not try to prevent use/copy of the source code inside another
>> > non-gpl
>> > project.
>> > And I do think that this is not the intention of GPL. If it were, then
>> > 100% of
>> > all mobile phones on this planet are illegal. All of them use GPL
>> > software
>> > from non-gpl software, be it kernel modules or apps - and I see no
>> > difference
>> > in the two. The constructed difference between kernel mode software and
>> > user-space software is pure ideology. Because during runtime everything
>> > is
>> > just call-chained.
>> > Which means if you fopen() a file in user-space it of course uses GPL
>> > symbols
>> > down in the chain somewhere. The contents of the opened file are not
>> > heaven-sent.
>> > If you/we follow the current completely ideology-driven GPL strategy
>> > then I am
>> > all for completely giving up this whole project. In real world you
>> > simply
>> > cannot use such a piece of software. The success of linux during the
>> > last
>> > years (i.e. decade) is not based on the pure GPL strategy, but on the
>> > successful interaction between linux and non-GPL software.
>> > Just think of the billions of smartphones all using a non-gpl firmware
>> > (underneath, and there is no GPL version at all), the kernel (with
>> > non-gpl
>> > modules) and apps (quite some of which are non-gpl).
>> > This is only one prominent example, but there are lots of others.
>> > In the end it all sums up to one simple question:
>> > Can one _use_ GPL software during runtime as a base for own projects of
>> > any
>> > license type or not? We are not talking about _copying_ gpl code, we
>> > are
>> > talking about runtime use.
>> > If runtime use is generally allowed, then the export gpl symbol stuff
>> > inside
>> > the kernel code is nonsense. Because to use the kernel you must be
>> > allowed to
>> > call it, no matter from where.
>> > Hit me.
>> >
>> > --
>> > Regards,
>> > Stephan
