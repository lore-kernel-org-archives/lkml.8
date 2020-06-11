Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC014C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B769420838
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591905025;
	bh=v9dNkrpA4SFtGcw/Gc6HzQjUtd4V1ARG1lRzTQD7ehw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oeL/hVyXKcA5a/AkVdeJt3WrlFHR9JCrmXuxjT+Fi6PSc2swB2956jiVAhZsYa/gL
	 L8RuPgT4gB/ZBBj1I3cDXapDRL65SwS84r/dfD21vJrScWFxUpFpcMnwOrBpnf/Teh
	 OHnh+OMsz8ErRJamDGu0I//REmOBDQCFce8DXSsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgFKTuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgFKTuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:50:23 -0400
Subject: Re: [git pull] drm i915 fixes for rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591905023;
        bh=v9dNkrpA4SFtGcw/Gc6HzQjUtd4V1ARG1lRzTQD7ehw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YU+fUiX8jsBQHLqmIiVylpFRvCklZwO5MQ26jF+yZny35dYb76HJpgsn5NhpBiZ3i
         x3lHhDmckekUTvL6tpaW9equWwCQwZyorG4x+0uaQlU54WsPy4xJMRtfyzIiVRgBpq
         RypZ4gRwFjng68y6LUknAIyKZ6ElHZTueD2Sm5zE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tySU_oXYv+FF5D3GkkyngdxWfkb_6KDK6nA0uBx6EB=qw@mail.gmail.com>
References: <CAPM=9tySU_oXYv+FF5D3GkkyngdxWfkb_6KDK6nA0uBx6EB=qw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tySU_oXYv+FF5D3GkkyngdxWfkb_6KDK6nA0uBx6EB=qw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2020-06-11
X-PR-Tracked-Commit-Id: addb1e23bf72c47a3e2eb7cdad6dc8cdffa91384
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66057dd1d1cf2149e0f5fdaee58d6ea69bc98048
Message-Id: <159190502341.20905.5113407927895881475.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 19:50:23 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jun 2020 13:56:23 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-06-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66057dd1d1cf2149e0f5fdaee58d6ea69bc98048

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
