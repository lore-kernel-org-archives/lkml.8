Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F90C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E53620784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585682127;
	bh=qZSb3OdmQUNfO+CyuanGJJ/FcbBBSs9CE7irqbmMU/M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kDCGYLw2X7IWbVqlVy074Up7EmqHCLv52SU6Mio47pQTU/bJ2edxa1AhvUhg5u4rK
	 57tUvfoWnUNoyOEuMpQAtUmdjhn6L9KJ/V+1I2kmr8vVMa4HgMg8s8nNm0GPOppTsK
	 x3e5p1Ui0Zgyx7URpRPB/e4eFnhWQ1DzygjHXeTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbgCaTP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731390AbgCaTPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:15:18 -0400
Subject: Re: [GIT PULL] arch/microblaze patches for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585682118;
        bh=qZSb3OdmQUNfO+CyuanGJJ/FcbBBSs9CE7irqbmMU/M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lp0mfeviT1L+KrbkTZg7EChEHbCf21F8aZoNweq8yOSjpvju6KJE+NRSJmQrqqRQu
         4mgrTRBoAgs46jcghrbokEiXG8ntl7cGBG5RMkaXAmGxSsx5KhpVkdidHAIrXYa4Ly
         AG0843HBYrwPbTkTSKQqIfgeZKSe4BYuwSCY9NGQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <07af6b9e-1f01-0e2b-c5e0-69041eb2aca6@monstr.eu>
References: <07af6b9e-1f01-0e2b-c5e0-69041eb2aca6@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <07af6b9e-1f01-0e2b-c5e0-69041eb2aca6@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git
 tags/microblaze-v5.7-rc1
X-PR-Tracked-Commit-Id: 9fd1a1c9b3f2a38a5357a13335e0b9e5f21d093b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8222fd5b80c7ec83f257060670becbeea9b50b9
Message-Id: <158568211814.28667.2232170284573684863.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 19:15:18 +0000
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Mar 2020 16:54:39 +0200:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8222fd5b80c7ec83f257060670becbeea9b50b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
