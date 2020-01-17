Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8FFC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A688F21835
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579279508;
	bh=6O7zghZuLt7W8Xcao671vZl8MqdMrl4deoBl2aV3SPs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=NvfZzL5aaFgkVv1w3EXCWK7H28iBYpCeL/OBr0PaaiPqhXG/yFnvFyKNhXFcg+mfZ
	 9SBY43RKQGhUp/z6nHILFB8pP+gRQT9cBoPPpcYt6ZqM79RMMctNjci+7Q3cooZMlu
	 h4VKsVTH27U0fbuf1fGRegFi3EGXZWH/ZQVvsH4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgAQQpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:45:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgAQQpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:45:05 -0500
Subject: Re: [GIT PULL] sound fixes for 5.5-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579279505;
        bh=6O7zghZuLt7W8Xcao671vZl8MqdMrl4deoBl2aV3SPs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zazCPtaDqSLFThJDmsbu8O2Gd09nFeJCAkmA+rVU1yNNyyGNaJR9qoKldoCgZ0fxj
         tKC+MprG/lsyM71ULge0teeV0+fXPhow38+SI0MIjfJtjgpa1+usGWFn6y/47RISkb
         3YksxUfwW1ruaj7zP3mj9R2vfSrG0auXe+vCaWaw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hsgke4aqi.wl-tiwai@suse.de>
References: <s5hsgke4aqi.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hsgke4aqi.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.5-rc7
X-PR-Tracked-Commit-Id: e5dbdcb31285a975d623d2bf2c9e7b2940489008
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07d5ac6a12546fd23619ea60b211654efa55db86
Message-Id: <157927950524.32282.14888587193385133486.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jan 2020 16:45:05 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Jan 2020 11:51:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07d5ac6a12546fd23619ea60b211654efa55db86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
