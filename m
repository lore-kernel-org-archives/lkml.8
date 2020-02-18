Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26537C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 05:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF79420836
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 05:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582004420;
	bh=97SUQ24phw+psmy6TmZZtzFUJl9LBoxcMVLoYt+B9J4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Izli1BY0OnQuM62b0/AEkrlTwKZ0CtxhoWwlJTOqmHq/MIkK8sWhChqOD6aQFmkMj
	 WD7za6ekqAcP2VMWEgYBjH7Th4NYTfebAiErRRtFmzcOXOY5Yp4uYv4sROIZy/S0Ak
	 zvoM6g+j3+dtAPFf/vrmuY04I27zkXbw1KInsxIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgBRFkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 00:40:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgBRFkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 00:40:18 -0500
Subject: Re: [GIT PULL] Btrfs fix for 5.6-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582004418;
        bh=97SUQ24phw+psmy6TmZZtzFUJl9LBoxcMVLoYt+B9J4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Jxurf7V69n3HGzrX8kB998tHCcoRjW5MdICDq6ctwEH3nP1XQJ38bC6M4WNdkYcAd
         J8HJoSl7HkxBXS0GBQKNqJV38T4WdBAomF42Gp3po/4i6M/O2T/PitfOrkVOv+R1D1
         0/xI/dWda852eSZZquom4L4XbtCS91ZLqZClTXF4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1581962653.git.dsterba@suse.com>
References: <cover.1581962653.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1581962653.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.6-rc1-tag
X-PR-Tracked-Commit-Id: 52e29e331070cd7d52a64cbf1b0958212a340e28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eaea2947063ac694cddff1787d43e7807490dbc7
Message-Id: <158200441799.24167.9075205058877968253.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Feb 2020 05:40:17 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 17 Feb 2020 19:43:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.6-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eaea2947063ac694cddff1787d43e7807490dbc7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
