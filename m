Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BD5C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 00:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B920F2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 00:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578615313;
	bh=VAlinYDqvJEXPB8VGD9dAN5nUSMt7o+KIEP0+OFtBak=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KnDd+n/1wna33e9vt8L2Ytvys6cQrfcXwTWaj/CdG3Ks5NGn2O8DQYvqGG9s+Xy/C
	 Qwdq1EwNEQOyvjNaqkDbtQICgu6cYcxcrHZLqHs/ZoJU1/ZPAejaGh5340uJY/gWL3
	 NPselm8LUITP0wzBus8AH3K5k9Uvxc9K3h7JCiNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgAJAPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 19:15:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:36906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730032AbgAJAPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 19:15:07 -0500
Subject: Re: [GIT PULL] pin control fixes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578615306;
        bh=VAlinYDqvJEXPB8VGD9dAN5nUSMt7o+KIEP0+OFtBak=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=P3KJ2ohq7jUUvjpCGROCdmXUjrhRELnTZlkvAjNm0P/V2vWfTs7ITjrcOA26mri0G
         q/HXOPzQ29wK1R+Fa7Uo48vRDWNKQzOLOcRMtlyMb8UtIZEBk8LWhv+6j8180382Ri
         Vm5Wa9WbWEO6n6N8q/CCt4uv00LAkhFE9mjO27sk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdbR2Ssr1WWfS2HZ-jd6XFgEvEsqrjVAcgPsR8RerE-xfQ@mail.gmail.com>
References: <CACRpkdbR2Ssr1WWfS2HZ-jd6XFgEvEsqrjVAcgPsR8RerE-xfQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdbR2Ssr1WWfS2HZ-jd6XFgEvEsqrjVAcgPsR8RerE-xfQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
 tags/pinctrl-v5.5-4
X-PR-Tracked-Commit-Id: 35c60be220572de7d6605c4318f640d133982040
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6a55b52a1b94bc71843d71b7194ec3d9a34ffcf
Message-Id: <157861530658.24562.7669628739738928883.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jan 2020 00:15:06 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Qianggui Song <qianggui.song@amlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Jan 2020 22:51:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.5-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6a55b52a1b94bc71843d71b7194ec3d9a34ffcf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
