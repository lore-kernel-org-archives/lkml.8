Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B99AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42F6214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580407221;
	bh=oRBcw3Bz1XwI0m/XlBKvicUPB3oj6eDbFc2/bvfBXo4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OTngd40h44aW49fNxBUenk9RDS9/dbnsxpNHAq1QbQTEkRcrNaV8BOdH3H17kf64K
	 5b9OhDiQBFM0dYRvSrrF7Ed5yJGBbsktIFJCzEzqrgr0WHUHpo6DazZTyQhddN7eh+
	 rayuVmqp0ESA4j8YA8NjJ1rA4Di/d13inGnPgn/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbgA3SAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:00:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbgA3SAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:00:18 -0500
Subject: Re: [git pull] drm for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580407217;
        bh=oRBcw3Bz1XwI0m/XlBKvicUPB3oj6eDbFc2/bvfBXo4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N6hMS5nsLAQPXo1lPKlleFCVeWMOPkQk0G6KI0ToQggYKQbPV+3iwIQAsvX2U/HYM
         gBWIMosddKJg7wh1k7KE4K6IEv1/zX+tRJ4TNqlNr9jK8sS1+F8XYycXsQjFdwAmrn
         uD3elQwXWme/70bGRyD6qm21lkgjndZb0FF3FQ5M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twBvYvUoijdzAi2=FGLys0pfaK+PZw-uq2kyxqZipeujA@mail.gmail.com>
References: <CAPM=9twBvYvUoijdzAi2=FGLys0pfaK+PZw-uq2kyxqZipeujA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twBvYvUoijdzAi2=FGLys0pfaK+PZw-uq2kyxqZipeujA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2020-01-30
X-PR-Tracked-Commit-Id: d47c7f06268082bc0082a15297a07c0da59b0fc4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f68e3655aae6d49d6ba05dd263f99f33c2567af
Message-Id: <158040721766.2766.10487533836164754740.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 18:00:17 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Jan 2020 15:58:11 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-01-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f68e3655aae6d49d6ba05dd263f99f33c2567af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
