Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7740FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 04:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537AF2072A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 04:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596170412;
	bh=zW3uIvbp2jGeCBbLWJPZ8htaHvyzIa3B5msiTGKNExc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mOXNK1jVD1GXkdnnRdZaZVJzZsX91MiEODlldVWqI4ctKJXMTh40WWuZVOOK7m7iq
	 q8rXxZmU6WEjCJFS652XRQLumkC3foAjiIUm6Dd/XhHEZ3Oyy9doGc2duby3X58Qfa
	 Iy+TyXWN3k1ZGuiukqcg2s3l37q48L7EvN1qHc+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgGaEkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 00:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgGaEkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 00:40:04 -0400
Subject: Re: [git pull] drm fixes for 5.8-rc8 (part 2)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596170403;
        bh=zW3uIvbp2jGeCBbLWJPZ8htaHvyzIa3B5msiTGKNExc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EDid6naRhp1XSSOexs0W+GdjNYaDZBmfxP6AClxeKOngf4FN0k45P8w3VaDMEqc4C
         FnnroWQiTlBwZxs9LqGcJFvwD2u7+8WeY6Rx5QTUrPmamKCQ9QPtjIFnkzKaGSNdqy
         Ut26nlCvkejpHxZ2Kg8hGoiPqeiOCZV/Ue/JKZ4M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twq8wVE888GW3cQ12Fw=FEwtD-1tXWgMcrrnjdk3NJZfg@mail.gmail.com>
References: <CAPM=9twq8wVE888GW3cQ12Fw=FEwtD-1tXWgMcrrnjdk3NJZfg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twq8wVE888GW3cQ12Fw=FEwtD-1tXWgMcrrnjdk3NJZfg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-07-31
X-PR-Tracked-Commit-Id: 887c909dd5d557c203a233ebbe238c18438a680a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8b9faec54ae4bc2fff68bcd0befa93ace8256ce
Message-Id: <159617040369.8551.2784979803005371450.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Jul 2020 04:40:03 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Jul 2020 13:44:54 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-07-31

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8b9faec54ae4bc2fff68bcd0befa93ace8256ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
