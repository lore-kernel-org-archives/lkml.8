Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB703C33CA7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 23:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7672071A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578786608;
	bh=0H4x/7iRB/IvL3h7QOI+RDOOXkuKUFe7AXRtVBf7I/E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QVpaoneSM1oip8j+fNivfXS6AvQG741KkqPDt+Jy3uDMAy4CInHUKzVCm7fAotTOd
	 qRlyTRKMEds9qnbJOGKsGcGqXoO/Lyh5/o3gWleVy7x7CC6oMgYD7hKzX2lneEk9vH
	 KJwt4r5Bx6YjcUKSMk1ozcY2YaN+i10n5Y6fu7jA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731751AbgAKXuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 18:50:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731722AbgAKXuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 18:50:04 -0500
Subject: Re: [PULL REQUEST] i2c for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578786603;
        bh=0H4x/7iRB/IvL3h7QOI+RDOOXkuKUFe7AXRtVBf7I/E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=h+xcqrnVneEF0lIYoK4HOdp4aZXk8pl2j5hSJCF+O7pmv0Uk2rA24YYuRenbkbBuU
         RoR8mB4xhav4eFPXr0oVj4NTuEM3DCR61n3HZbgdHLO2nkd6U9HawAB8wcokmeQIuV
         YyJCjTJrmDUiAXxQsRP4J+lKoNQT5rEhKbVYPtus=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200111200704.GA5308@kunai>
References: <20200111200704.GA5308@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200111200704.GA5308@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current
X-PR-Tracked-Commit-Id: cf8ce8b80f8bf9669f6ec4e71e16668430febdac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6327edceb62bc4c91195e2dc6d5574a53005cb5a
Message-Id: <157878660393.3074.4059137287771008632.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jan 2020 23:50:03 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Jan 2020 21:07:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6327edceb62bc4c91195e2dc6d5574a53005cb5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
