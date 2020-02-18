Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF571C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D482206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=waifu.club header.i=@waifu.club header.b="yzllje1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgBRK5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 05:57:41 -0500
Received: from mx1.cock.li ([185.10.68.5]:40015 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726414AbgBRK5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 05:57:40 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=waifu.club; s=mail;
        t=1582023456; bh=pgJCMCsc89IhSBD8DIOQcNQxThGyTuatXZV1ketNMjA=;
        h=Date:From:To:Subject:From;
        b=yzllje1D0ggNKxmMYlRwykD4Ie6s05iljOeFxXRl6D0J4gTxVyxw1ox9/MWFWtp4G
         flU1Yc+B40LI3d6/e8V+v4pxximbSC2VS0b1Rq7ySXz4woCQgo94PnnNUTyODaENhY
         EtNf1tK3Qwt/ioDslqvaXEhbTa89H+sKh3ympeJx6DPociq+/1KryaAa5eseovXNGm
         mHSrQH6JmzT1sa6ISfL40PZv3cyVRtLijCuIvHSZRypy/3pX9cPegSNHgr+bYvdQHa
         Q9TT6MAUWdzG6ymOh50KJKcaZHdhgAWDkHbASR8X8VhZDonSmJI6kM1Hqk45u8v0hc
         Fa6wB+qmbCp/w==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Feb 2020 10:57:36 +0000
From:   agentoranger@waifu.club
To:     linux-kernel@vger.kernel.org
Subject: Grsecurity blaims insane conspiracy theory for self-imposed legal
 woes
Message-ID: <3ee534a5d4a4a442356a528a9fe5fe18@waifu.club>
X-Sender: agentoranger@waifu.club
User-Agent: Roundcube Webmail/1.3.10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Grsecurity blaims insane conspiracy theory for self-imposed legal woes
 From the Grsecurity website: 
https://grsecurity.net/setting_the_record_straight_on_oss_v_perens_part1

> Company Background
> 
> Open Source Security, Inc. was formed in 2008 initially to handle 
> donations related to the grsecurity project, an open source project 
> started in 2001 and freely (in all senses) available to the world until 
> at least 2015. In 2015 we made our stable patches available to paid 
> customers only via our website, a right granted by the GPL. At the 
> time, we still had a freely (in all senses) test patch available. In 
> April of 2017 we stopped providing the test patches to the general 
> public.
> A Troll's Revenge
> 
> Only a few months after this, a notorious Internet troll who had used 
> grsecurity in the past and been banned from our forums for misogynistic 
> comments was apparently upset at having his access cut off completely 
> (after previously being denied access to the stable patches in 2015), 
> and came out of hibernation to extend a private and public campaign to 
> get revenge. This campaign continues today even, with posts to LKML, 
> various distribution mailing lists, and posts and comments on Slashdot, 
> Reddit, and other news aggregators. This person poses under various 
> names, usernames, and email addresses, but most recently poses as a 
> legitimate lawyer claiming the GPL can be rescinded. The emails come 
> from @redchan.it,@airmail.cc, and other anonymous mailing services with 
> usernames like "aconcernedfossdev", "visionsofalice", "gameonlinux", 
> "nisus", and "unconditionedwitness". Most commonly, the email subject 
> regarding us includes: "Why will no-one sue GrSecurity for their 
> blatant GPL violation?" or "Yes you have standing to sue GRSecurity." 
> In many instances, due to the changing names and email addresses, 
> readers are unaware this is the same "MikeeUSA" troll, a self-professed 
> misogynist and pedophile, that had been harrassing and issuing death 
> threats to women in Open Source for years.
> 
> But the anonymous troll wasn't able to inflict the kind of damage he 
> wanted to achieve alone. People saw an unstable individual mixing 
> misogynistic comments with nonsensical legal theories, making it clear 
> he was not an expert and his comments had no basis in reality. To 
> inflict the damage he wanted, he'd need to enlist the help of someone 
> the public trusts and views as an expert on license compliance matters, 
> so that it'd be accepted as fact by the public. So in private, he 
> contacted various influential people (including Richard Stallman, Eben 
> Moglen, Bradley Kuhn, and Bruce Perens) involved in Free Software/Open 
> Source in an attempt to bait them into accepting and repeating his 
> claims and wild legal theories as true. None of them took the bait, 
> except for Bruce Perens.
> 
> Perens' Collaboration
> 
(... and on it goes)
( 
https://grsecurity.net/setting_the_record_straight_on_oss_v_perens_part1 
  https://archive.is/7B9No
)
( 
https://grsecurity.net/setting_the_record_straight_on_oss_v_perens_part2 
  https://archive.is/7B9No
)
( 
https://grsecurity.net/setting_the_record_straight_on_oss_v_perens_part3 
  https://archive.is/tvlWf)
