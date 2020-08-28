Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7B5C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B9CA20897
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598644734;
	bh=p74W8ZZ9DCJfjTLqxpRxY4uYT4TEx1/MQFoGaihqzTg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GHU9nWDQHLerXwzCIw7ykmb+o232s+NRlXO+V136dx8gRxEtdPJTFfTFP3Ug7atje
	 cbqMqQzBW9646C75hk+2KYZvdx/cyL4/8uI2sPeKxzYhT/VwSxY9Y6tBsTSiNnchYu
	 R5QcfH6bVOgDzBJ4QS8CN9dDFii99+6GXZArnrqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgH1T6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgH1T6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:58:25 -0400
Subject: Re: [git pull] drm fixes for 5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598644705;
        bh=p74W8ZZ9DCJfjTLqxpRxY4uYT4TEx1/MQFoGaihqzTg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fUGHD13Kaxw6C4PYR8X4O+Cz/r1tZese8PwaPIG64t9HsuD4zkMtaqF6H9vn1vWXE
         GCPsHInmLhgrmPRWlkgdMzgNf4kpDZXh1cH9QB7v4LpDd2NaNdqiM+Mhmo9VhwEMSq
         9uCDdaHkSd6118FgLPzh2A4GNaNSjRF91TgSJnJQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tz1s-Mt7ba-82zMPP8hAmenxBj51QzRAq_=TkD0VLJRKw@mail.gmail.com>
References: <CAPM=9tz1s-Mt7ba-82zMPP8hAmenxBj51QzRAq_=TkD0VLJRKw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tz1s-Mt7ba-82zMPP8hAmenxBj51QzRAq_=TkD0VLJRKw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-08-28
X-PR-Tracked-Commit-Id: 2a3f9da32de4616f0104209194e9bd3dfae092c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ec06b5c0d259a8c7c4376b121b2f62dfbfe57ef
Message-Id: <159864470520.31636.5027759301107575227.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Aug 2020 19:58:25 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Aug 2020 12:35:20 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-08-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ec06b5c0d259a8c7c4376b121b2f62dfbfe57ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
