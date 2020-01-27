Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AC3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E952467F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580152506;
	bh=5PJ1QmOz7vqKCGA8OAbZfdhW0dpAIj0rV2gNmSaB8q4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QXr02fO0AQwQ0jnTF3kd5pAGv8hNu/qr77jWqz+0WiXAgFlx+iQ2BU8wo5hZrGMxU
	 O1AzAZAM/765/qxAnoV/RPgOC+bKUPehg/LUdv8K4L6owhUl5vxIaF54CvSnN59frB
	 x2fbQGYc2Pb/yC/bUs4Rs2+atqGdGFXTqLThm/FA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgA0TPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:15:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgA0TPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 14:15:04 -0500
Subject: Re: [GIT PULL] i3c: Changes for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580152504;
        bh=5PJ1QmOz7vqKCGA8OAbZfdhW0dpAIj0rV2gNmSaB8q4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oosBFCBJvs84VjFQU8lZl92Q41FR48HxVKpfL9tzwMBQaquJJMt3V9BU/dIWZBhzO
         +jfKCYtHkWG1ZfJvhhhDNR6f9aGfryIUVYsiHqpC0TOAefPrAT06l1a9ek24Wn1YPN
         ZxF9QE0xRVykGmhTDx/ey8LE62XGHskf7e2pThvM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200127093443.0f52c6b3@collabora.com>
References: <20200127093443.0f52c6b3@collabora.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200127093443.0f52c6b3@collabora.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git i3c/for-5.6
X-PR-Tracked-Commit-Id: 3952cf8ff2f7751ee2f9d6cc6140df4667853250
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9b627a449889e9dacfe9e7ac3cdf829a0004845
Message-Id: <158015250427.1024.3046247350246362257.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 19:15:04 +0000
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-i3c <linux-i3c@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 09:34:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git i3c/for-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9b627a449889e9dacfe9e7ac3cdf829a0004845

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
