Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8775EC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 04:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A4622D03
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 04:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596861364;
	bh=JSlqEEwV4DmFTyp4K92+HtGYizd9uu9I/CMsKzGV1iw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EqCCqGLVJQaH13A69IQgcXLZZPjDXMLbA3hIPjMxQtW4vd5w6vvzlIMRjrUQ6Uz3k
	 UVQmB11GfSo7NvT7pPeW5ZB9xCbZDjcToZq5nZFll93Ae2TMTGHo1TqOtGomlGZnOY
	 trmqH6B8jzRTXPNC4ynY0MeNZK1fT76PsfwrMvQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgHHEgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 00:36:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgHHEf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 00:35:59 -0400
Subject: Re: [git pull] assorted vfs patches
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596861358;
        bh=JSlqEEwV4DmFTyp4K92+HtGYizd9uu9I/CMsKzGV1iw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TSoviotO0nhl2X43l9DHrPiZ9EmaCraJObYPD4YNfyv2Lo69Law013T9qRYmuADhM
         bTCOFfjJ5rqLwLgADINyOLlMTiY21zPTmN8H00TGZ+V5hO4UBpeRSb3hagtQY7+w+x
         TJCg+cnP6TT4oaf+WAvOSuJL/fFItzzJXJ2GJN1g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200807232627.GY1236603@ZenIV.linux.org.uk>
References: <20200807232627.GY1236603@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200807232627.GY1236603@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc
X-PR-Tracked-Commit-Id: 6414e9b09ffd197803f8e86ce2fafdaf1de4e8e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b79675e15a754ca51b9fc631e0961ccdd4ec3fc7
Message-Id: <159686135894.18048.18424492775467641070.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Aug 2020 04:35:58 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Aug 2020 00:26:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b79675e15a754ca51b9fc631e0961ccdd4ec3fc7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
