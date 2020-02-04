Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5733AC3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 08:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D88C217BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 08:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580803520;
	bh=bF7S5Qk5YtCZxYuh0RNSvKo2BsmU5gTJqXGn2yvrQ0Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sXwbsvaSFa/wWqhtg8pmAPXF+ORHG5IG69Pum2/M2Z2V5gQIA1Ws0OZS8n0AuvFVe
	 MefHULhpcXikhSK354Wo63WFDgVlfd+9rTqfeGdaHLV2/MueH2l6ca7q5oqDDyaQ+e
	 ODMHuYhJOBwTm9GQYalicw2CXhx8nTYqVPYfBBs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgBDIFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 03:05:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbgBDIFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 03:05:17 -0500
Subject: Re: [git pull] drm ttm/mm for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580803516;
        bh=bF7S5Qk5YtCZxYuh0RNSvKo2BsmU5gTJqXGn2yvrQ0Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Xe0zHDYuGx5Tz2QfuCL8MiRlC7Kj8kv7pfP88tJrjzUZp/HqicOfNDvLfab1dZ0bq
         ALhYS0vNkC46WWofO181DOxIfKBNViGzC8Xb0rdBxzqDWm+DYyeqPO5e5E4rMg7OKW
         6WFQR0L0QPP2r1x8bZiVS9U1xl6ruIucooBRmVmA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyPRUfbZZtVWWxs95aLkuaXkenwGU+QfR3N6NLRn+PsHg@mail.gmail.com>
References: <CAPM=9tyPRUfbZZtVWWxs95aLkuaXkenwGU+QfR3N6NLRn+PsHg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyPRUfbZZtVWWxs95aLkuaXkenwGU+QfR3N6NLRn+PsHg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2020-02-04
X-PR-Tracked-Commit-Id: b45f1b3b585e195a7daead16d914e164310b1df6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9717c1cea16e3eae81ca226f4c3670bb799b61ad
Message-Id: <158080351683.18289.3506574281830623003.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Feb 2020 08:05:16 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Feb 2020 09:26:45 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-02-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9717c1cea16e3eae81ca226f4c3670bb799b61ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
