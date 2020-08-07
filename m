Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CDBC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 975352224D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596832758;
	bh=zt7fkGc1cidAD+XaN4ND2FyOweqK3+ejxb5/pTuuqFY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qxz5fUs8gxbHqM4knBaMkNbNasBG3pu8EKblx9b3AYJBPVqFQ7csGkGKbJWVOiPdl
	 YhLxzBBUrMUbuaGdZ8mcu42zRIO4DbtUakSjOyQErR3cFFDgGlgQORJb1nVWr7ZLyx
	 f00RY/Fs96s45kD+f4d6U+3gOpCwa8jzb+xUm5Go=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgHGUjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:32918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgHGUjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:39:12 -0400
Subject: Re: [GIT PULL for v5.9-rc1] media updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596832752;
        bh=zt7fkGc1cidAD+XaN4ND2FyOweqK3+ejxb5/pTuuqFY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QeHM6rC0Arh7ztM5kX6BkKBHhnXtEg7ZL46mIdUKAydw0tXDXpv/iDVsirW3zF9f9
         nclLteHVlbOPdVxZMRGnbojqawp8uVYk0hv024bpQqUpPMkP/SgS+SVMvGOeEpbrDY
         AtduM0oZm2s6+aaa7SGw+c9rOwoKASVsN9CIrQwU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200807104258.59618b4c@coco.lan>
References: <20200807104258.59618b4c@coco.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200807104258.59618b4c@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.9-1
X-PR-Tracked-Commit-Id: f45882cfb152f5d3a421fd58f177f227e44843b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa73e212318a3277ae1f304febbc617c75d4d2db
Message-Id: <159683275214.2860.17663140824736768157.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 20:39:12 +0000
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

The pull request you sent on Fri, 7 Aug 2020 10:42:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa73e212318a3277ae1f304febbc617c75d4d2db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
