Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88111C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58979206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581716439;
	bh=okwt0Inyp/KkjrAxJF4gBoecqd/gpaKGqOsV/+45elA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=G3bdNtBJlqvwYO2HGqydgU1tFY0TMlFjipiixnDYB9Gbntw2NMJtCCDbwMe8fO/bH
	 rf8RPV17V55W+ffoK3qRmg/94P3PTM0+eRWNIo8r0Gb4rRnZ+p3ed76sTmiffk2gu7
	 c8NTp97ESP4kNhDBSQwywlReLSg8JB3Sa/DLmpYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389889AbgBNVki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:40:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:55092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387936AbgBNVk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:40:29 -0500
Subject: Re: [GIT PULL] sound fixes for 5.6-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581716429;
        bh=okwt0Inyp/KkjrAxJF4gBoecqd/gpaKGqOsV/+45elA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lzNMNe7BYLa5qVK33Gk1jhjPzd2I6RzPdHZAHnxfedHvu8T+l4Ku8vTcX/TNtjPeZ
         rXD1jaXXsuTn+T+eM6ZFxBlZQNrgnAc1ifb5rq7Xhk8S+QFP8FQ1141gvSd4kh6LnG
         VYj5Z3uvkxW4nhDgH52o8TY/vDlu/Cmof1nL+AHg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5heeuxjuy1.wl-tiwai@suse.de>
References: <s5heeuxjuy1.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5heeuxjuy1.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.6-rc2
X-PR-Tracked-Commit-Id: 0fbb027b44e79700da80e4b8bd1c1914d4796af6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81f3011cbf501fef3a954821dbc362084f6b686b
Message-Id: <158171642920.8400.16780870068643115910.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Feb 2020 21:40:29 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Feb 2020 11:59:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81f3011cbf501fef3a954821dbc362084f6b686b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
