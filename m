Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D362C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463A424125
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581112530;
	bh=x4jVxI0ZMxL9jmduN8iNSalk/GJgxwf8ZGViWkqSW+o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KNM22NCfZ6b3uWj4jWN1NjRVZsO5+OMKrr/KweED/YT2ctQGR1SfcDWduSPi6HYbk
	 fUEHis5X8QWgMpLFs+sbh7e62lcVSwJTwm5RHKfH4ZsQ0VKUPXQfafWYx4uBA7CYCZ
	 ptQdEcBgZzh69KntsHOnxRImz1UWuSFjBiZifKc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgBGVz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 16:55:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727764AbgBGVzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:55:22 -0500
Subject: Re: [PULL REQUEST] i2c for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581112522;
        bh=x4jVxI0ZMxL9jmduN8iNSalk/GJgxwf8ZGViWkqSW+o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1N9CBzMjd1PwwQGgrPWOrGVyoaV0+YifzCvd8LQttgqOerrMWPccmMgnripqwmNZ+
         hCpjwAII65fcpsFHq96F6yCQMe1pzfhwsd1dHtYPVPpL6HoZczM7g0AUrcot7yWVBw
         S+WwweJ3eShl6klipA0kvTiz2JKBi9Q9xryIEoWI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200207171923.GA9783@ninjato>
References: <20200207171923.GA9783@ninjato>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200207171923.GA9783@ninjato>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.6
X-PR-Tracked-Commit-Id: b49f8e0e7bd17b968129790e40f9e2566f4f95ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11777ee8b04acab07c96959e9c6ac6a1603d0958
Message-Id: <158111252224.9631.1092673712656215961.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Feb 2020 21:55:22 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Feb 2020 18:19:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11777ee8b04acab07c96959e9c6ac6a1603d0958

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
