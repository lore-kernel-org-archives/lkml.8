Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ABCC35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 22:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2AB2253D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 22:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581201335;
	bh=y/qqCZ+HKy7RKisAiQiEzsM1iapxTUgHLK7XD+oF1XU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=W0N9XJIOf98FXOghwLYBzdve1y06wFWyBXGBQk3C0UE69Lmpie2X/Hqe641Wo8o7F
	 ZHpwFFAPuzhMTohxXONV3s2gVnefs3dy6XX8LRPrZvCU5Zo9XnZYKQIFnu7Q3qjXlj
	 YnUnSdCDq0OS73lEDPPKjK8XXOAXujilB2xlBfKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBHWfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 17:35:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:57010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727668AbgBHWfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 17:35:30 -0500
Subject: Re: [GIT PULL 5/5] ARM: SoC: late updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581201329;
        bh=y/qqCZ+HKy7RKisAiQiEzsM1iapxTUgHLK7XD+oF1XU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xBXpJBZs1D+EzSa36WZyGUqfv8aEm6QcbZM5RgndL33sEi9Ubfghqt65cBsGt9FwS
         opoQU5jjTR8ck43pblO4D1zftrSWnz45kDWFe4M0MG8nVgB2tOtgGh/0+1fbnH+jQd
         evMesRDkd6w5PChvttx0BlrQ30uvPBmfmY285r1E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200208112018.29819-6-olof@lixom.net>
References: <20200208112018.29819-1-olof@lixom.net>
 <20200208112018.29819-6-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200208112018.29819-6-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-late
X-PR-Tracked-Commit-Id: a832eb203ecd34e486bdde0042cf166e687eb227
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ef1a30c6bd2555d4177fc9286df32e9166d58ba
Message-Id: <158120132971.28764.13683295178503395137.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Feb 2020 22:35:29 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arm@kernel.org,
        soc@kernel.org, Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  8 Feb 2020 03:20:18 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-late

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ef1a30c6bd2555d4177fc9286df32e9166d58ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
