Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C901C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 513A120691
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591727726;
	bh=Zwz9KGFZmKz/9wdCfTBPL7DKiCFvy/yodC3Hsk2nNew=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0j6GwOKkBjLPZgS0ZUoWS2kYUtswb2kPtZ2OiLdWL1a0afQ32dco/NKDiJw1huXAr
	 mDDvs3O5lj45w5qO+UQ+mNCDF65EU2wSjJI1bIRKb3kdjQ0ybHOyvdBLlg+Ga1iTPy
	 MJU2eT3IlpQHALlE02x5o51Zrhinw5qodbfaF9j4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbgFISfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731397AbgFISfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:35:23 -0400
Subject: Re: [GIT PULL] exfat update for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591727722;
        bh=Zwz9KGFZmKz/9wdCfTBPL7DKiCFvy/yodC3Hsk2nNew=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Xr3afr/iN9WN1y95nCz5uSP4OQCo2vkoUhXA6FhdGBVCcFhDLhh3t4Loq6NX5Uvhs
         W0Bkz0JtPtiie1jWTo2Dh5xGtzoCU5HCRgUPM+I9vlvRiZIfK1t2tiOXjZzPZISonr
         trxiwhKMdIFlbSuX7OinLLhRLOaQXfAaTCUZZCnc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <001301d63e3a$5bdb43d0$1391cb70$@samsung.com>
References: <CGME20200609084542epcas1p35b5e76b8b99735e2f48921b5aaf7d4c3@epcas1p3.samsung.com>
 <001301d63e3a$5bdb43d0$1391cb70$@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <001301d63e3a$5bdb43d0$1391cb70$@samsung.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
 tags/exfat-for-5.8-rc1
X-PR-Tracked-Commit-Id: fc961522ddbdf00254dd03b677627139cc1f68bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad57a1022f9e050a09812d975874b94b4fcb0f46
Message-Id: <159172772274.12427.869117657315863585.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jun 2020 18:35:22 +0000
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        'LKML' <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Jun 2020 17:45:42 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad57a1022f9e050a09812d975874b94b4fcb0f46

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
