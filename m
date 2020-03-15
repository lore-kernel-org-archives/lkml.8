Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC68C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 20:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634E92073D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 20:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584303912;
	bh=maFSA+24jsDFeYuZo4uwv9MvgxmEOwF+KErJCxuzpFo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yMhPTdGJOZyy6EDib5ERXYm9h18N2216ZlpeTY3+qZ8px//8LDM9kUdEOpBty0OzP
	 FklMheRoB2BjL6Fr8uVhaxCEQSg/kXGMnVAsfliQc8Aaee4XethKa7NyElfD2dPJNV
	 yWaYNBOjZSjncLOoijHO1rMtY+O1Mb7z8f5zlv00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgCOUZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 16:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729186AbgCOUZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 16:25:09 -0400
Subject: Re: [GIT pull] efi/urgent for 5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584303909;
        bh=maFSA+24jsDFeYuZo4uwv9MvgxmEOwF+KErJCxuzpFo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SCPydrpL0I6zuMaJgxvtusgTpiIGsU1fmh8RzDwEThLr9A9D4rGviIczgWm6UdeBt
         y4y/SHV+qXMvO6dn5Q+xAaDARGd2HSDKgE8Jk41ZbyhLPRhEUPYIe8sJmSKKxOmpFl
         aWoiFyZEU55Oxn8gX5CZb5pXvavAW0K9HtWY9O44=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158428527861.14940.12920965330771600615.tglx@nanos.tec.linutronix.de>
References: <158428527861.14940.12920965330771600615.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158428527861.14940.12920965330771600615.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 efi-urgent-2020-03-15
X-PR-Tracked-Commit-Id: d6c066fda90d578aacdf19771a027ed484a79825
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b67775e124572a7028e930c306ed68cc2f90b29b
Message-Id: <158430390949.13594.10700533031571131898.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Mar 2020 20:25:09 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Mar 2020 15:14:38 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2020-03-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b67775e124572a7028e930c306ed68cc2f90b29b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
