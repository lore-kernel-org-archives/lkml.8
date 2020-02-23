Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79168C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 11:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F6E20637
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 11:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=waifu.club header.i=@waifu.club header.b="yvC+tz6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgBWLED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 06:04:03 -0500
Received: from mx1.cock.li ([185.10.68.5]:52975 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726023AbgBWLED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 06:04:03 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=waifu.club; s=mail;
        t=1582455838; bh=IJTBgyv66sdEtH/QBo2cuVCt13PZ+jNPq0FYUiFqCfI=;
        h=Date:From:To:Cc:Subject:From;
        b=yvC+tz6jDAWQOLMrsry40BAWvRR0MMFTnyeWhphAGuex4V5jBivdY5C56lGOzrp0d
         FMyohfw1ltwq0rd99ajiAdHcRsG8rtMMYwbF9CDFmzNl6NKfSDd71v2GGUDfc6/TSL
         l9WquAO4tGxBA4OoMyVCW22NoG2WaYANW67QP2szSb6nTHn483b2riJdwJCvRhohqe
         gKhgfNuaqXRJtmdVl7ilXudLee7cRAZfCpVk7isBV/MioAXepSygwkXQL+Zys+SzTJ
         VP59IdwR9pgelRcun0q6CsZAJiPDRxnUH+vFlBzC7mpZ5oZXnpLfu7CMWHibhMufJo
         pbaoXGPq5otug==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 23 Feb 2020 11:03:56 +0000
From:   whywontyousue@waifu.club
To:     linux-kernel@vger.kernel.org
Cc:     rms@gnu.org, bruce@perens.com, bind-users@lists.isc.org
Subject: Re: General Discussion about GPLness
Message-ID: <8b0e828da35ab77c1ad4603768c6eab6@waifu.club>
X-Sender: whywontyousue@waifu.club
User-Agent: Roundcube Webmail/1.3.10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Stephan von Krawczynski;

Universal City Studios Inc v Reimerdes, piece of shit.

"[The court] reasoned that Ferret consumers who used the Ferret as a 
plug-in to the Real Player altered the Real Player user interface by 
adding the Snap search button or replacing it with the Stream box search 
engine button. The court concluded that the plaintiff raised sufficently 
serious questions going to the merits of its claims to warrant an 
injunction pending trial"

Want to violate the linux kernel copyright, you fucking piece of shit? 
Yes you do. Yes modifying the running kernel with violating pieces is 
copyright infringement, you fucking piece of shit. Yes you should be 
sued. Just as Open Source Security (Grsecurity) should be sued for their 
violations (of section 4 and 6 of the linux kernel copyright license 
(they're also violating the GCC copyrights too)).

Will they be sued? Will you be sued? No: Linux copyright holders are 
scared little wageslave worker bees. They aren't going to sue you; 
sorry. Why are you even announcing you intent to violate the copyright? 
Why even give these dogs such intellectual deference?

I wish OpenSourceSecurity would be sued. I wish you would be sued. But 
linux WERKIN MAHN wage slave piece of shit idiots won't do it: I hate 
them much more than I hate the violators. Complete Dogs. They could move 
from strenght to strenght, from victory to victory; but they're scared 
for their "JEHRB"s. I have to say: white men are pathetic scum. If Linux 
was built by others there would rightfully be lawsuits.



> Stephan von Krawczynski wrote:
> Hello all,
> 
> you may have already heard about it or not (several times in the past),
> non-kernel devices run into a symbol export problem as soon as 
> something is
> only exported GPL from the kernel.
> Currently there is a discussion regarding zfs using this call chain:
> 
> vdev_bio_associate_blkg (zfs) -> blkg_tryget (kernel) -> 
> percpu_ref_tryget
> (kernel) -> rcu_read_unlock (kernel) -> __rcu_read_unlock (kernel)
> 
> where __rcu_read_[lock|unlock] is a GPL symbol now used by (not GPL 
> exported)
> percpu_ref_tryget.
> 
> That this popped up (again) made me think a bit more general about the 
> issue.
> And I do wonder if this rather ideologic problem is on the right track
> currently. Because what the kernel tries to do with the export GPL 
> symbol
> stuff is to prevent any other licensed software from _using_ it in 
> _runtime_.
> It does not try to prevent use/copy of the source code inside another 
> non-gpl
> project.
> And I do think that this is not the intention of GPL. If it were, then 
> 100% of
> all mobile phones on this planet are illegal. All of them use GPL 
> software
> from non-gpl software, be it kernel modules or apps - and I see no 
> difference
> in the two. The constructed difference between kernel mode software and
> user-space software is pure ideology. Because during runtime everything 
> is
> just call-chained.
> Which means if you fopen() a file in user-space it of course uses GPL 
> symbols
> down in the chain somewhere. The contents of the opened file are not
> heaven-sent.
> If you/we follow the current completely ideology-driven GPL strategy 
> then I am
> all for completely giving up this whole project. In real world you 
> simply
> cannot use such a piece of software. The success of linux during the 
> last
> years (i.e. decade) is not based on the pure GPL strategy, but on the
> successful interaction between linux and non-GPL software.
> Just think of the billions of smartphones all using a non-gpl firmware
> (underneath, and there is no GPL version at all), the kernel (with 
> non-gpl
> modules) and apps (quite some of which are non-gpl).
> This is only one prominent example, but there are lots of others.
> In the end it all sums up to one simple question:
> Can one _use_ GPL software during runtime as a base for own projects of 
> any
> license type or not? We are not talking about _copying_ gpl code, we 
> are
> talking about runtime use.
> If runtime use is generally allowed, then the export gpl symbol stuff 
> inside
> the kernel code is nonsense. Because to use the kernel you must be 
> allowed to
> call it, no matter from where.
> Hit me.
> 
> --
> Regards,
> Stephan
