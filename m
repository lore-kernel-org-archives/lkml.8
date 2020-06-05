Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC54C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0946207DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591391724;
	bh=9VQN3uC2vV5ELJ6LIaLUAU//aK5hXgvOhUtIGb8Kx28=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kf3HxbR1P4ZGCmdf7K8Y+FfzJ+cbkhIyCOa8xFMz99Z4977abFGyg7eLV5L3U6t/K
	 psWYF9nIxrKh4dbPvI73suWgbFOONHisdMCSQufr4Hvql1LhnXuR0zAmBQO5cWzC85
	 XjCKrPymhUUxApJW8deKUhr/EJU0qonb+xvzXkdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgFEVPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728548AbgFEVPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:15:17 -0400
Subject: Re: [GIT PULL] Bulk GPIO changes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591391717;
        bh=9VQN3uC2vV5ELJ6LIaLUAU//aK5hXgvOhUtIGb8Kx28=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rKw+J9wyDVSEIjs75Mcbd/IdCSNR7z6fVyorzVyU2vLo4Ek7cfZMMUJSR9PD5VKZT
         Ysph7ExgzZa52Sz4KPw7NKDFuRDGME8qcsXaBYlceHmOrxaaMZLA1NgIIWRTK8qVLj
         i/LI1RWvR+Jicqnz8hpDAnvUTSatXIpleMf1aCp4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdY=R5_g+Vrjtj9tZ=5gxh5qPWqm-yqtFB5GbKC75Yskxg@mail.gmail.com>
References: <CACRpkdY=R5_g+Vrjtj9tZ=5gxh5qPWqm-yqtFB5GbKC75Yskxg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdY=R5_g+Vrjtj9tZ=5gxh5qPWqm-yqtFB5GbKC75Yskxg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 tags/gpio-v5.8-1
X-PR-Tracked-Commit-Id: 74910e15ab25f95f162bc4d4a634d029186543ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f7e82379fc91102d82ed89822bd4242c83e40d5
Message-Id: <159139171705.26946.10369365814347507554.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Jun 2020 21:15:17 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Jun 2020 23:51:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git tags/gpio-v5.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f7e82379fc91102d82ed89822bd4242c83e40d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
