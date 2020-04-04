Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACF2C2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 18:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6A0206F8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 18:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586026506;
	bh=co6S5nqk9pXW3GBobrf6g6ZQMvkXKDKPOJe2G/9W3Js=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=cca5IwE6l9L81PXDUZLxeKV0poNDl1JyAvq7RSWljLybpLYoY2ZIOlK+wIeEqLLzx
	 9ox9ifaQxZXoYQ1Po6Rjq7yc1V9+3b0O/C9TczEZ95eVl934bo4gXYEvxZIDfcNMjM
	 7ezaimBBkma4GuVcvxVw4Vr6gVqwuozRnm/34Wfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgDDSzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 14:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgDDSzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 14:55:03 -0400
Subject: Re: [git pull] exfat
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586026503;
        bh=co6S5nqk9pXW3GBobrf6g6ZQMvkXKDKPOJe2G/9W3Js=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IPrwhwMAXEDEUDILHSKQp5KMKBKHu9YNGKk10p7aZgjSBPbx+U49aCWxSASyJxWbA
         gORGgtfyGbZMS2y1MMggzKXTqVd34CfFW2DfH7XCqqZRTjWCR6OGJYL6URppLPNKbW
         3FN3Tzc66le5Hb/W9CDW0ycUCVsjYr7by5gu9QHE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200404183528.GO23230@ZenIV.linux.org.uk>
References: <20200404183528.GO23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200404183528.GO23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.exfat
X-PR-Tracked-Commit-Id: 9acd0d53800c55c6e2186e29b6433daf24617451
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83eb69f3b80f7cf2ca6357fb9c23adc48632a0e3
Message-Id: <158602650335.4238.17886859766655851150.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Apr 2020 18:55:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Apr 2020 19:35:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.exfat

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83eb69f3b80f7cf2ca6357fb9c23adc48632a0e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
