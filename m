Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0ABC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E5F22B3F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595464505;
	bh=u1rSsbHPgNqoh0XeslusVlYRX+WU01DuBsImUOK0KhU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YxOu3Bmu3OjLH2gCTiTKsW29OuS5L/G9TFH7DAijFVJrCl06cbIcNkLb+x88PVJYN
	 fV2bgZcWuFBSvH1X7oucPtBd+QzF5g/Jc7I09eulASbQJG40Ia8cw1num2wUz85ZgG
	 Ruxk7zfiFaPaVZKzTiqmSsB52O7F9+5MlcfDHT4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbgGWAfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 20:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733289AbgGWAfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 20:35:03 -0400
Subject: Re: [GIT PULL for v5.8-rc7] media fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595464503;
        bh=u1rSsbHPgNqoh0XeslusVlYRX+WU01DuBsImUOK0KhU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BEWCZjrPcfAqkaKBq4Vd8Oicx3KluK8hEx8LX+fRx8NyL9a0+CgpG4FCatCJZJ5mm
         m2n9SoB+Kid/e9yVXAtkVM3xxPJZ7o/hvTO3ZSK1gggwvdOszoJBFoZFacz3K3bve4
         oR6/O8v0e9F1Rmm8FbQFLLgbhyITiKlQWeLE3fDk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200722155727.06ab1692@coco.lan>
References: <20200722155727.06ab1692@coco.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200722155727.06ab1692@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
 tags/media/v5.8-3
X-PR-Tracked-Commit-Id: 0d6db85131e014c128e57649793aff5aa96e065f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d15be546031cf65a0fc34879beca02fd90fe7ac7
Message-Id: <159546450312.19894.8311805112492546828.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Jul 2020 00:35:03 +0000
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Jul 2020 15:57:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.8-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d15be546031cf65a0fc34879beca02fd90fe7ac7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
