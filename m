Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1835AC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7392176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=waifu.club header.i=@waifu.club header.b="s0MeqOnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgBSH2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:28:22 -0500
Received: from mx1.cock.li ([185.10.68.5]:35299 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbgBSH2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:28:21 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=waifu.club; s=mail;
        t=1582097297; bh=rDCX0rPj2NphfuIrQrrcOhO9sJLDdTgRun+b8SQDr7s=;
        h=Date:From:To:Subject:From;
        b=s0MeqOnp4UxbGX2B6SpCtZJu8623Od0MxNOMe6oH3ZBPtlUs5LAcQ3izQfDb5iAMj
         t7mENgGc0wROBNkjfXt3t6Q5szZMu6jRpwarF5MUU4KmDOa3gRqs63dWgN+KQj3fz2
         I2lfQnzj8Ln8IpBXr4HihlUu8CtnubhORAko//E6jD5ECY019S9dIwNynlfgjoWcLc
         BnNDSwggm7GpUE2gGOSZqhzKQyM0CuG+S/pJmQVdJK3pHfVv1m4fjeOCLwIZS3w9ID
         siMHCjRX0L8pVO72GjY/hfL/F0YYWHmuLvrSVy8E+eBIbdsA+DWvDA4NbHcP4WpsR5
         8W6lNsvK2GacQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Feb 2020 07:28:16 +0000
From:   agentoranger@waifu.club
To:     linux-kernel@vger.kernel.org
Subject: The GPL has teeth, but they're not attached to a jaw.
Message-ID: <c69e51177a4e28b699b18fffe70ca726@waifu.club>
X-Sender: agentoranger@waifu.club
User-Agent: Roundcube Webmail/1.3.10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPL has teeth, but they're not attached to a jaw.

Dear RMS; If you don't want to defend free software in the courts 
anymore, if you don't want to be involved at all, maybe you need to make 
an announcement. People still look up to you as "the head", but if you 
want to be an "old decrepit man with no drive" now... you need to tell 
everyone about your retirement.

This "we can't do anything" thought is complete bullshit from Bradly 
Kuhn, and whatever other morons you're hanging out with these days: it 
does NOT come from ANY ip lawyers. You have a good case on the GCC side, 
and the linux kernel copyright holders have a great case, atleast on the 
law (now on recovery...)

You can nail these people (Grsecurity) to a pillar.
But you won't encourage that.

You've sold the GPL dream down the BSD river. Why? Because some women 
complained about your opinions? This is pathetic, get some testosterone 
injections and fight.

What are you afraid of? Grsecurity suing you for libel too? They are 
blatantly violating the GPL. Section 6 and section 4. They are both 
civilly liable for damages, and (since they've made over 1k off of their 
direct copyright infringement) criminally liable. That is: Bradly 
spengler aswell as those assisting him.

Why should any of us (mostly men) programmers have anything to do with 
Free Software if YOU will not bear your teeth once in awhile and force 
compliance with the license you have asked us to use: to put fear into 
those who would otherwise violate it and bar us from the full fruits of 
our programmatic efforts?

Tell me that? Or do you just not care if men contribute to Free Software 
anymore: You think the women will do this hobby for free like the men 
have? They won't. You're living in a dreamworld if you think otherwise 
(men fall in love with engineering; that's why they're willing to do it 
for free). The same dreamworld where you listen to the likes of Bradly 
Kuhn, even now, a completely unqualified individual who always tryst to 
STYMIE and SLOWDOWN any legal action this past half decade (or more).

I can't believe 1) some woman complaining and 2) Grsecurity's 
libel-lawsuit threats have shut you up, taken you down, and ended Free 
Software (the share-and-share-alike strain). But that's what has 
happened.

Grsecurity has gotten away with it, every other company knows it, they 
are BLATANTLY violating section 6 and 4 (of v2 of the GPL), EVERYONE 
knows it, NOTHING will be done about it. GPL is BSD license, 
effectively, because the white male programmers are scumbag wimps who 
won't even SUE. They won't even _SUE_. It doesn't take any physical 
effort to sue. If you'd bother to register your copyrights lawyers would 
be happy to help you with getting those statutory damages.

This is... it's just beyond words. It's basically all a lie: everything 
you've claimed to others: because without enforcement the GPL and all it 
stands for, all you've campaigned for, is just ... well just as 
effective as this email.



With regret,
