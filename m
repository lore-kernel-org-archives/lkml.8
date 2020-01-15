Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08625C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A432467A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579116903;
	bh=+yfsbG48l7QsGjYINIsslMeaJFNi/+69iSmfSQM9M44=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RWdzfp4VO9fnJuyawbN6OtVRnXEhTuVJpn+4PejfwKxU/JaMoNYf/03L9CPWiEWWV
	 GjfYmoRo8S1upTMwxPDM8xjJF6lxtzx2xYqvjaoAxc1W41cUf8tlUrZmPq782cy8lz
	 rGqolO3Tn+A408qG6DQwabU7fdHsVGbnGHWYRhb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgAOTfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:35:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:43072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgAOTfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:35:02 -0500
Subject: Re: [git pull] vfs fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579116902;
        bh=+yfsbG48l7QsGjYINIsslMeaJFNi/+69iSmfSQM9M44=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iOP70oseax6LwnMlWWHXz19WFtq+Kc2tbZByo+1dznlgyRR80dxW6maJP7MWXE1gt
         VHVmebYvLsq8ovIw9N/+A27cjIoCIzRyzkv2U2l1cMi9dAKL7NSWW8agPdwuAOMrm1
         7c6OTHFj1TuMWXW8X5T4ost5Q6H6oghMA0m76FcU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200115064107.GF8904@ZenIV.linux.org.uk>
References: <CAHk-=wgdsv1UA+QtgiJM8KQAG7N7_9iK_edchnzZYyj+nxmfLA@mail.gmail.com>
 <20200113195448.GT8904@ZenIV.linux.org.uk>
 <CAHk-=whn5qk-e-KnYr6HNe5hp45v+XyDbsA2+szXvK3gC06A2w@mail.gmail.com>
 <20200115064107.GF8904@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200115064107.GF8904@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 508c8772760d4ef9c1a044519b564710c3684fc5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84bf39461e61f69ebfbfecf39cfda71bf78a7fc1
Message-Id: <157911690202.18389.13450051811287135150.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Jan 2020 19:35:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 Jan 2020 06:41:07 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84bf39461e61f69ebfbfecf39cfda71bf78a7fc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
