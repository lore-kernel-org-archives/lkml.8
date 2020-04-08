Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DDDC2BB54
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6EA2076E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586316028;
	bh=qSkgLHCzBoNNW4IoSCmeylFlUu4aRmy4OtTMj0MCwcQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2Xx7A7DZNhRbxQ87cz/KibAM/y3yze/qZ81S1MATBmyGE+neYmuNRWFj1yZgn5Rwb
	 TTFI4OmrbTpyX5UH9EgyUluAaXlQFStLJj7gxfm0qy/5SofSveftpLLgUVfWUaxXX7
	 qsdS5URsNYA8q8DMDyn7pKS4nq86UrsX0NckwUvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgDHDU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 23:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgDHDU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 23:20:27 -0400
Subject: Re: [GIT PULL] LEDs changes for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586316027;
        bh=qSkgLHCzBoNNW4IoSCmeylFlUu4aRmy4OtTMj0MCwcQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gsfe9zmkqoauYrOYsKFZcmkDMTHmI3+mjWK98SsZhnXfbwLWSGIq0iTMUe/x3Z6up
         bv1kSkm98NqAiuzf3b30UJmNfeIeg7y5ngYmVH4gmDUnly9tDpq7O3sWaORPtNY4UA
         toNSftDJVgAmmtMtEGKOsaKPawzhAO5haB24FfyE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200407075753.GA19187@amd.ucw.cz>
References: <20200407075753.GA19187@amd.ucw.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200407075753.GA19187@amd.ucw.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/
 tags/leds-5.7-rc1
X-PR-Tracked-Commit-Id: 64ed6588c2ea618d3f9ca9d8b365ae4c19f76225
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38e2c63ec3d323310ba873601e864af79b90b457
Message-Id: <158631602699.18814.1138317331447805965.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Apr 2020 03:20:26 +0000
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Apr 2020 09:57:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/ tags/leds-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38e2c63ec3d323310ba873601e864af79b90b457

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
