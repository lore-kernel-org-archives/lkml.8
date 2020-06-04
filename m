Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491BBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 04:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21768207D8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 04:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591245312;
	bh=44FsW3Cn0DQEJfxTXBTo09Yt3FZ81uHJk9xUmAJNvRM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=XKaCooetx6YW8fm6mYdEPzBUrV5aIpDBKnlgAJ4886LG89qiOyyMCyo+zX6yHOSNT
	 +8BnHUkNl+rqPTEOoFnW9aSoSYtUdPV97b3qkauFOdkpj1IObfze5o4kwOug3bRiDt
	 wOTSQg/CGP6ssmpCMvd07vltghsnD8U37Eb6Si3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgFDEfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 00:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbgFDEfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 00:35:08 -0400
Subject: Re: [GIT PULL for v5.8-rc1] media updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591245307;
        bh=44FsW3Cn0DQEJfxTXBTo09Yt3FZ81uHJk9xUmAJNvRM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xwibzC3zrjv85FXWJXL8bHV7vgxrZqYCYjyW1VkBi9ElUjvUmCO0cgHfLIF73c34l
         YPxUEwQH1JQJUjAj8/HU7Lu8F0CMbhQnAYlBsay/qQsfQT71QEF0mfNcAL3QpD3up1
         s3BOb3R2JGdDzh+LpMZ4hOrfJLGudQKWm6fsTz8A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200603100559.2718efba@coco.lan>
References: <20200603100559.2718efba@coco.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200603100559.2718efba@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
 tags/media/v5.8-1
X-PR-Tracked-Commit-Id: 938b29db3aa9c293c7c1366b16e55e308f1a1ddd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a98f670e41a99f53acb1fb33cee9c6abbb2e6f23
Message-Id: <159124530776.14766.18409735678633037618.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 04:35:07 +0000
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Jun 2020 10:05:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a98f670e41a99f53acb1fb33cee9c6abbb2e6f23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
