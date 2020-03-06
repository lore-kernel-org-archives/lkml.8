Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BCFC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D53122B48
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583499906;
	bh=84v6BZy0RWfqoW2l869ZZcrMZHtChI8eyri9daZ1tMU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mRPIH64NyXe0oaO8FXpViMlur8cKMuOueCZh7oYeeqxNL7ubYflhy+gCL4gD2jnoL
	 VLc4AFVjfAXpdcOhcEOI1HM03F9nPsiBn9UsAtJGAzKem4OFtuXJ6LLWzOS5HFRvQz
	 x9OeohKWYlYtkX20MJU9fJYAIlB9Rb7Ns+APrUbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCFNFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCFNFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:05:04 -0500
Subject: Re: [git pull] drm fixes for 5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583499904;
        bh=84v6BZy0RWfqoW2l869ZZcrMZHtChI8eyri9daZ1tMU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lM/615oopMhfDwhOkWQ3Y4JNTZJjbemHbPF7jbW0udOwIP/BpFze+Ea2Jn28eHYy3
         mUyad1TLW+eZOeqFvRaFEov1zG6lsFIv9QND7f0YjMRX8MfpPa/PlDTYSla3tTGnbd
         rpGDbF2u2Y6NCON1Jm/U3m7XeYk1zWLy+l0gZrQI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzi8ZaowmegAgeHSO3cLB5VRid9h=TMX=v+YcHEb5Cx_A@mail.gmail.com>
References: <CAPM=9tzi8ZaowmegAgeHSO3cLB5VRid9h=TMX=v+YcHEb5Cx_A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzi8ZaowmegAgeHSO3cLB5VRid9h=TMX=v+YcHEb5Cx_A@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-03-06
X-PR-Tracked-Commit-Id: 2ac4853e295bba53209917e14af701c45c99ce04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba0ae9ac46078c53adbb4485adbb3df779228287
Message-Id: <158349990430.8760.10214214684051769960.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Mar 2020 13:05:04 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Mar 2020 12:35:37 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-03-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba0ae9ac46078c53adbb4485adbb3df779228287

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
