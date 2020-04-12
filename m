Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86322C2BB55
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 17:35:20 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8EE20732
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 17:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEU18KQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8EE20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgDLRfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 13:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgDLRfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 13:35:06 -0400
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EFBC0A88B8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 10:25:27 -0700 (PDT)
Subject: Re: [GIT pull] timers/urgent for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586712327;
        bh=yvzv1LKOd1YIqJtMG9SKGDaKZQRPTgXzVkah023zX6I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OEU18KQCJ9Ji2cbNOcdTFiDWlh4wj+2yWb/f0+wgf2Q4H2Rhx5NEjYQZMbQVppATT
         /s+1dwQL138WxpqEvbmd5o9RkGAUUZnwaAlm1VDycQ5cuWGjR2J4wnfZ6I5jM8IeE7
         hStCG54ym6MTQKK2RFHJV3+Pl8Vev6S/cL8LMzVk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158670112139.20085.3639703190488837403.tglx@nanos.tec.linutronix.de>
References: <158670111777.20085.1305752188791047060.tglx@nanos.tec.linutronix.de>
 <158670112139.20085.3639703190488837403.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158670112139.20085.3639703190488837403.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-2020-04-12
X-PR-Tracked-Commit-Id: 0f538e3e712a517bd351607de50cd298102c7c08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0785249f8b93836986e9d1bdeefd2a2c13f160af
Message-Id: <158671232711.12917.724965248038678496.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Apr 2020 17:25:27 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Apr 2020 14:18:41 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-04-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0785249f8b93836986e9d1bdeefd2a2c13f160af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
