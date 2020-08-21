Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826F5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D81F20748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598030207;
	bh=Xi5uDqEgd+wyCMVTJ6agj4KL0IiNBxuM+S+CfdFnmQk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rHW/gc/8/0H3wYszJ5TWVDcUFkBPBQkW4bf1F5DVKgyGT5pGCg3EyUg3HYrAvX9NY
	 ks5Q/1V6pAaEaW+seIepK6JzzPTDT30RYFAF3+q8CRpRwXjJsScp6MB4HFt8d3N7ao
	 WO3vsezF2PNIa3YdDnH4nIX+F4FZ7bBaCPP6lUsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgHURQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:16:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbgHURQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:16:20 -0400
Subject: Re: [GIT PULL] sound fixes for 5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598030180;
        bh=Xi5uDqEgd+wyCMVTJ6agj4KL0IiNBxuM+S+CfdFnmQk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VF/ibpyYn14wTWHRn/a0FaQa+4PIp+H18mmUURROcIufqcnOR5sCPQzIEGtOOz6gm
         +P27PdAI5GdqE2KlqVCmycZb9oAKbyc0jaFJlL0ZqAr8A778uUWHO6d8cczaS9lOUP
         AgqPDaqdK0QSoXHNASVs4AuxjuQvfuslzQqVYkbA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hzh6ocpr1.wl-tiwai@suse.de>
References: <s5hzh6ocpr1.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hzh6ocpr1.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.9-rc2
X-PR-Tracked-Commit-Id: b90b925fd52c75ee7531df739d850a1f7c58ef06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f04f3ed621fd345ca1b01ec6e98c9b85d95851f
Message-Id: <159803018045.29562.10705885967473858922.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Aug 2020 17:16:20 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Aug 2020 11:28:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.9-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f04f3ed621fd345ca1b01ec6e98c9b85d95851f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
