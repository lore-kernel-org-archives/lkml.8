Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB6CC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A448322240
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587145523;
	bh=/dnkughh1n8P56Pxh4knn3Doyi8au2e05RCMTooUCKc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZBaIDu+WIHMq3u2d4wY0GIA10jpUu5PL+HvUaxHcthsptTkWsglGr+Ap1FQ89/ezx
	 o38pnjlw7j7Ge0tFtTxpEU0Eud6s5dqwF7tnAHF1J/8r/EemDLzPggcEmNjisNRV3Z
	 otvK4tfUK0qm0E6R741TZuzcDEbUQ5hZgFYiKD0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgDQRpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbgDQRpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:45:22 -0400
Subject: Re: [GIT PULL] sound fixes for 5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587145522;
        bh=/dnkughh1n8P56Pxh4knn3Doyi8au2e05RCMTooUCKc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=L7NkxHUrLfFYZ6sq+/APTjzwdA1SEvTjw6oO2Ovm6iLZ/56KFmHbcr3C7wx9FN4F2
         0jv2a5qiAhGThjK8W8wQVhJj8FGOukcoJnQlMw4EiVdrCV+SYeqEG09lqddG/jyu0v
         LTuy1SWOu03lBRcy2hZWSSj8TcHqJOCrT6fmtOxw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hr1wm9ud9.wl-tiwai@suse.de>
References: <s5hr1wm9ud9.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hr1wm9ud9.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.7-rc2
X-PR-Tracked-Commit-Id: 9a6418487b566503c772cb6e7d3d44e652b019b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8a6552ff1155788b9a25ad376ab42e0742eef6b
Message-Id: <158714552198.1625.111665942813850504.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Apr 2020 17:45:21 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Apr 2020 14:20:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8a6552ff1155788b9a25ad376ab42e0742eef6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
