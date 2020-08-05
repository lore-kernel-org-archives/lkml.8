Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195A4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D334E22CB3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596659587;
	bh=2IhhKQbR9zpTPqGSXZpVNEIF3V+h1PoBkoxRQo/ziOA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=okAxoqRQAm0izEW3TRTAkCGNQsMx0REiN1zo2w+7t+iF8aFlO/HFWfdPZr+9140L4
	 sMsjKQzmezEZtd4fdVV4Jt/4jUkvBjK/z4etduQxj80JJlCQiF2j9HVZZXDZlQ2MK2
	 kTYE5TcczbmuuAMahDBKbPIQBP5Rj9+ZZRLpsTsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgHEUdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgHEUdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:33:05 -0400
Subject: Re: [GIT PULL] hwmon updates for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596659584;
        bh=2IhhKQbR9zpTPqGSXZpVNEIF3V+h1PoBkoxRQo/ziOA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=I1mkXCTUenDT7+EA76kQOytX2Xm4u82Ab8Y6Le97I3FxJvS6GqNP8JQw5Qlki5ln+
         TMUBrvVjy7FUq6qT/beG+WGp8sYSXWkz6OZ7AsDo1OwfVJ9Kfhps5SQBxPoHz4ZULy
         LtDCTpCKhT7urlhJO7y9AVrBBKmwNTOjFUg/uv/M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200804233002.230586-1-linux@roeck-us.net>
References: <20200804233002.230586-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200804233002.230586-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.9
X-PR-Tracked-Commit-Id: e2f75e6b5d766195d2ca584d92995a0dfe467fc7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9aebd3254c184fb6c731548b8347193bf882b6f7
Message-Id: <159665958467.13939.13689839474841609937.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 20:33:04 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  4 Aug 2020 16:30:02 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9aebd3254c184fb6c731548b8347193bf882b6f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
