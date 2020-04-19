Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527F2C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 19:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E3B22251
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 19:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587324026;
	bh=9qp5K6vIdLnuHObFVn39AA8HlosiP8884381OkrW84k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bpEF33H7Hkbu6vwiNVvC9J/Hj0boQvZzxfRfFG4Yv1TAj8lS0Tx2Np5dSFNNf8N+r
	 vNZi+8DHTheSneEUXgUtFyg4ig7fr8IOZn5nPpDXcjqwI36CWrEsazkbt5L/3fihZ6
	 puHsoi5h43vLx1ALKsK0dTB2HNJF8/AasLfu0qN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgDSTUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 15:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgDSTUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 15:20:23 -0400
Subject: Re: [GIT pull] x86/urgent for 5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587324023;
        bh=9qp5K6vIdLnuHObFVn39AA8HlosiP8884381OkrW84k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YNGuI5veAfypelPq6RR6q1bDIrOWMaies/hlpgLudKHQ4tgbO1Oh1bX6dsMyAT6OO
         JM5T2zLy0SC2oYM5SdMnnn2fJ4F8dPsLS43mXKpLeWEgRw+KngIm1i4Jkh1wlCS+pI
         Xpe4qvNNpCsHFLashww8bRiUOA1N7ZC8qWzJ3dZk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158730460462.31269.9837303049447973264.tglx@nanos.tec.linutronix.de>
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
 <158730460462.31269.9837303049447973264.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158730460462.31269.9837303049447973264.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-2020-04-19
X-PR-Tracked-Commit-Id: 8b9a18a9f2494144fe23fe630d0734310fa65301
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0fe5f9ca223573167c4c4156903d751d2c8e160e
Message-Id: <158732402352.20624.17866732284836416531.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Apr 2020 19:20:23 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Apr 2020 13:56:44 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-04-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0fe5f9ca223573167c4c4156903d751d2c8e160e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
