Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23332C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F239F208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590700211;
	bh=T2+HwCQHSKE7JhR9JpyK4J6DSPlOl8xIs60MqGEHHUQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=upeXbkToC0aGC+gI5Wv3ZuWcsu4NgUmQVl77HA/MwH3BJnZk7pCs4i4D4FkWSbAhp
	 SbWBkdgZXAgZCub6aMXPEYlAwlwCjIce1HZWYntDJOahK424uj2VqauzfvBjXvMlH7
	 3BJLMHvmDSPptUhXYiqnLD3lrXq2xei+BI7Jz89I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407571AbgE1VKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 17:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407447AbgE1VKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:10:03 -0400
Subject: Re: [GIT PULL] csky updates for v5.7-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590700202;
        bh=T2+HwCQHSKE7JhR9JpyK4J6DSPlOl8xIs60MqGEHHUQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=In4loItZM0q6evR7Sy5WlU4nUkfyP/3sgYBR9fhXiRLJ6yEFw+c8me/lSEsExP+JR
         Tv9sgaR9iWrWcwi6cVcwWxXB/Y7P8KOza/Lm4ihbILzoNcrmA2daNy71Qtn7IGAlc/
         G1XbsdknFR6JaDwjOYOUTMGP4qPVXNa2oiOMjGLs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1590627572-10100-1-git-send-email-guoren@kernel.org>
References: <1590627572-10100-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1590627572-10100-1-git-send-email-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git
 tags/csky-for-linus-5.7-rc8
X-PR-Tracked-Commit-Id: f36e0aab6f1f78d770ce859df3f07a9c5763ce5f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b5f25909bb8a94a0c1d1c6e9530f8fc261d1b5d
Message-Id: <159070020283.6784.9180466553239444193.pr-tracker-bot@kernel.org>
Date:   Thu, 28 May 2020 21:10:02 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 May 2020 08:59:32 +0800:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.7-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b5f25909bb8a94a0c1d1c6e9530f8fc261d1b5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
