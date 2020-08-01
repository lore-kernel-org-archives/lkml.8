Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71FCC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 17:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D4D2071E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 17:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596302105;
	bh=DG5Tx/vPXCYTCi9vi9lxJbhvZLHpZ2H1q7xLnSOR5MU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YQAxH0oq30ZIPuuzOuTN80xAuC8ZOx6dIA9zc7jaFjpL2i7z54RrW7uTEcbZB58nG
	 rNQzsdD4xafXlzojx0Vx2crobj09eiJgHXkSP32mtt3PuzQuQmNpt/+2lQxmLx5JLA
	 Qjz7hYZbF6N84DmmL7CZ7Ed/p1Y1D7dHmALOLqkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgHARPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 13:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgHARPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 13:15:04 -0400
Subject: Re: [GIT PULL] pin control fixes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596302104;
        bh=DG5Tx/vPXCYTCi9vi9lxJbhvZLHpZ2H1q7xLnSOR5MU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Fj/SfM3xSeMAs+RJnKHHwsFaY1uAVifv3DxmjqgGWXo4oevOdEko7zy+JhdGKLNI2
         fMd132foQQEbuYvx9a3vxoK2PQzcfGpqbj05kTmoID4yuL9gXI5bV5w/zsombxIDUQ
         cF7odeQkPkptmHXn4dUPgfxpm+64gsVEnkMV8MVU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdaiGkpOv3fr4+PKdTiQr0jbjhMUkYo+OnHuC9yqJVvQzA@mail.gmail.com>
References: <CACRpkdaiGkpOv3fr4+PKdTiQr0jbjhMUkYo+OnHuC9yqJVvQzA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdaiGkpOv3fr4+PKdTiQr0jbjhMUkYo+OnHuC9yqJVvQzA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
 tags/pinctrl-v5.8-4
X-PR-Tracked-Commit-Id: c3c0c2e18d943ec4a84162ac679970b592555a4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d52daa8620c65960e1ef882adc1f92061326bd7a
Message-Id: <159630210404.19073.11077325187393350310.pr-tracker-bot@kernel.org>
Date:   Sat, 01 Aug 2020 17:15:04 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 1 Aug 2020 16:25:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.8-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d52daa8620c65960e1ef882adc1f92061326bd7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
