Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0334C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 00:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4012465B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 00:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580258106;
	bh=xWWd5rEbjjjyeFf0u3NTd3WBfnVaXrDrvpwqkK0g5ng=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=REe5nRr1K0Kv+Oc/uL/OhAEkkYOOhwn565YpQNP0ekc7WNgYPzEz1X7OBX5gX6MGa
	 5hb//3E4a4io1Lto4SdPVxVyiF4pU5zWkuzK3TdX+GwapFB2i/Ji0Vn1buaRhN9hqo
	 4T0ufll2Kd9cAFYAxpUX8/6nRfGKFFweSjdoYY2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgA2AfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 19:35:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728350AbgA2AfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 19:35:05 -0500
Subject: Re: [GIT PULL] sound updates for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580258104;
        bh=xWWd5rEbjjjyeFf0u3NTd3WBfnVaXrDrvpwqkK0g5ng=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uxECoyM+OuE8dmRBnv/oZgNKekGt8JMuVgbGH8uDQOU5tlgWc40VsmlEzSAUVOA+Z
         dKlnQjgvqIa8evj9PoaVyoXCf4SeeHQsbFQjJ4+VAz+oJDuA4IA5CHOtFAY14TtcS5
         /0PL0kR608pQQo9P9dGVHmQlJx4DN/NgaxI5lveM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h5zgwouw8.wl-tiwai@suse.de>
References: <s5h5zgwouw8.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h5zgwouw8.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.6-rc1
X-PR-Tracked-Commit-Id: 90fb04f890bcb7384b4d4c216dc2640b0a870df3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb95aae6e67c4e319a24b3eea32032d4246a5335
Message-Id: <158025810480.31502.13174365546226279381.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 00:35:04 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Jan 2020 09:19:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb95aae6e67c4e319a24b3eea32032d4246a5335

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
