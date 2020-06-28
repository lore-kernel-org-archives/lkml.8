Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CFDC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E29520702
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593369932;
	bh=gb1bW97m7h1ccsRszhA/CR2eqm9vibiIpHfPlKaHDZ0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=eOww/kEY94Rqd0JarUWAOY1kUMv0ayvuW0w7JMah54grHcN2Fu+IYqhzZA+C0KZsI
	 XimWf/K+twzzbR/2n0G8Rjk0utc+LK0Y3Jxmhb0PFXIgx6VQD2rRybDyYplT3HzYNW
	 NyQLLCvA98yYC0BuZ6+vCSFF9be7EEdc4dQ000Ik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgF1Spa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 14:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:32860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgF1SpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 14:45:13 -0400
Subject: Re: [GIT PULL] objtool/urgent for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593369913;
        bh=gb1bW97m7h1ccsRszhA/CR2eqm9vibiIpHfPlKaHDZ0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1vowzsmw6lRsG4sySgH2d1uz4LU3fffOiHbfU0IvcUdsWDzNIPZOg1szk/8/3KAT6
         1aClQftn8shJDqn0vSeu340ODK5YxI/MKn8wKHrAjiR4a7r3GJ5IBY+z4QeySZzFfs
         LueJrbCS8vHkj8szIxkTvc5RK+KepN6WVz3tSx3U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200628141245.GB18884@zn.tnic>
References: <20200628141245.GB18884@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200628141245.GB18884@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 tags/objtool_urgent_for_5.8_rc3
X-PR-Tracked-Commit-Id: 0f1441b44e823a74f3f3780902a113e07c73fbf6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ecb59a56666506ebb1197f89ca7d587bd83309e
Message-Id: <159336991308.7125.4223248816804002931.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jun 2020 18:45:13 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Jun 2020 16:12:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_5.8_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ecb59a56666506ebb1197f89ca7d587bd83309e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
