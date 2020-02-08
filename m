Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA94C35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 21:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C90227BF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 21:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581198906;
	bh=LseHlsaXaz7bcbDDPBGg3KlxfXyiTq+0/MaIf3lQt8c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=a0x/3RiLTAC1MEzr8+F2lMMVKj5P7Vx+2SDIaZU0VT2WafNoAh9bDQYqxuliavJpA
	 PP9b+ysy+Lgczmey2T44xO/YLZiIRgaYIoQqbxx27iLVvVH59aWlLeMWSnPr3tcGVx
	 nMZxWccnosMWmzNaO3EFMuqT5ExRxjtxkw15XWwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgBHVzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 16:55:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbgBHVzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 16:55:04 -0500
Subject: Re: [GIT PULL] compat-ioctl fix for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581198904;
        bh=LseHlsaXaz7bcbDDPBGg3KlxfXyiTq+0/MaIf3lQt8c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hBp1BU8HokLPHpl/HK1VJDBNxgRUj0LZLuFLlZUkdcUyVr187k8NUYINFljwacTjh
         PKs6Ac4oYpQro/jkaEwhUBhayRfECQ4qtoMfAA6/FQJrzFN0nQAFLeQ1CW27GIK/5p
         DNWGkWonfnr3QHuPTMbx6ujQw95FdzoUPN84y4ow=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a1fm0_JKd5NVCSgT7HCHoR7TuVyTmxCQ9wjMGhnkDKmgA@mail.gmail.com>
References: <CAK8P3a1fm0_JKd5NVCSgT7HCHoR7TuVyTmxCQ9wjMGhnkDKmgA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a1fm0_JKd5NVCSgT7HCHoR7TuVyTmxCQ9wjMGhnkDKmgA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
 tags/compat-ioctl-fix
X-PR-Tracked-Commit-Id: 0a061743af93f472687b8c69b0d539d1f12f3fd2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b85080c106b1290eaebf100ee97babef833047d8
Message-Id: <158119890406.25917.1976245505762051851.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Feb 2020 21:55:04 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        youling257 <youling257@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Feb 2020 22:34:46 +0100:

> git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git tags/compat-ioctl-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b85080c106b1290eaebf100ee97babef833047d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
