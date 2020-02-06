Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B94BC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F031B2192A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580999116;
	bh=QEMNpwj8u0i9GDmW1D++d6YKmdbNXhIhHKW1hViMruQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HruvkXbLjnDpPKk2digAgdqnV+TI0c3PCJUABnK5KHBegwdU6XoRvVbg8gh6So45o
	 S1G22pumwm5RGKWDPAgy0DVwB3rgsJBRFkWUt7Fr1ijudUU2q/9rzsY2NGmrtb1H+O
	 /6qNc/j9chM39ZrDpp86VLb94nfqBlen7Qy7LTZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgBFOZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:25:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbgBFOZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:25:14 -0500
Subject: Re: [GIT PULL] sound fixes for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580999114;
        bh=QEMNpwj8u0i9GDmW1D++d6YKmdbNXhIhHKW1hViMruQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vUR5ZhroMuZeIRm4WxV9ewjROnv5ICXnGihwwEz/Xf+V5Ua73aiM8+l1Wts66+ass
         rjw5h5zdidBFUxVI6Xk2Pitr4BTpiykVPaG8ZhYeRqIWoQqszSYabW/0B9D39bpoxc
         NrLg9lONk7n5rtFMFLpDn6XEy6CZzmydrJ1MNTAo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hv9ojq22d.wl-tiwai@suse.de>
References: <s5hv9ojq22d.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hv9ojq22d.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-fix-5.6-rc1
X-PR-Tracked-Commit-Id: 6954b323a183dc18fa9bf2ad700e0ed344918c5f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 750ce8ccd8a875ed9410fab01a3f468dab692eb4
Message-Id: <158099911434.19829.3153055834668513407.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Feb 2020 14:25:14 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 06 Feb 2020 14:26:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/750ce8ccd8a875ed9410fab01a3f468dab692eb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
