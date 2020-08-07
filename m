Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CB9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 01:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A63222CAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 01:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596765372;
	bh=s6MsJr//dYnGoBao7cSD8ADX9UKC2I4PuoQ7Ehbo2tI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yowBoigGzhklvcRS5qunJGeHOJYMxpgKDXBoMd0wVa6UGH4p9bPQavDMzJIym7Caf
	 OGAypBSvhhBmRcQbHZD7j3qbiT8E3akOgM1VC8JIIdOiNY2suMRjDM/z6GntW4pZfz
	 SudPLGf03eYwnGKY7rFrcd5rqXs/iGzYpGWMJKd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHGB4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 21:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgHGB4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 21:56:08 -0400
Subject: Re: [GIT PULL] auxdisplay for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596765368;
        bh=s6MsJr//dYnGoBao7cSD8ADX9UKC2I4PuoQ7Ehbo2tI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YPporZ8CQNcdnvdnvAAubFMd0THz/JL+OBL/Fawbfd8XKDt3wSUMTkybzPWicQu8M
         1P6moAuAwGursvmnPU9fsQzWwuMhy+g/JeBWQMR38k1INAU04Js04LBzQhq+1zFtXW
         vlA5fl70iKoOQ0Kv+74daPC2LhWKYT9OG3bhbeZI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200806190421.GA4273@gmail.com>
References: <20200806190421.GA4273@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200806190421.GA4273@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.9-rc1
X-PR-Tracked-Commit-Id: 3f03b64981723b61048ea46642bcaa9b518f3ad3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed35832648b5c22ce39fe9c476065389c6f330ef
Message-Id: <159676536849.30846.13144645432553904215.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 01:56:08 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Aug 2020 21:04:21 +0200:

> https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed35832648b5c22ce39fe9c476065389c6f330ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
