Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8947FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614FA20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597262331;
	bh=iEXmtOuLXVlpUs4nJl5bKlU1K/kVL0eMtVAJhVfJfUs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VdA/Ra71XZpZMGymsWyG+1i18YKGN6nbOwGl7+8In3iW71B12wquJeaZWuDTfvher
	 eTdAx5jMBGQMsy+UYZ/10s0McrBwD8cyPeLk7Z38O23C356cFUdlaOpxk19CtvPDOB
	 rdS195wsatViUXYt/UPZU6cI/woG90/y3s12S9Pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHLT6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbgHLT6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:58:31 -0400
Subject: Re: [git pull] drm fixes for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597262310;
        bh=iEXmtOuLXVlpUs4nJl5bKlU1K/kVL0eMtVAJhVfJfUs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=z1jgqAqoq0r8FfWBCn1U/iduGeMhjVbr3RrG4PwBJ9AAsCxY296QHB99uhj4kI5TW
         BpRJv/z19D3ei/gPwVpDMlZm2tLrO1XFPs778wsZMNFZ5lPLIaNlvlasM6V3237KdE
         G1eyJEgcfhu/5lyOCUFosxEdZin//Vi8Rr+z7l2A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyXhxOGiH9yRsQf5bQ22bib1m_wmJBaVDFxFkEh4Y+dtQ@mail.gmail.com>
References: <CAPM=9tyXhxOGiH9yRsQf5bQ22bib1m_wmJBaVDFxFkEh4Y+dtQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyXhxOGiH9yRsQf5bQ22bib1m_wmJBaVDFxFkEh4Y+dtQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-08-12
X-PR-Tracked-Commit-Id: 62975d27d647a40c58d3b96c29b911fc4f33c310
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea6ec774372740b024a6c27caac0d0af8960ea15
Message-Id: <159726231090.30367.18007245410426476262.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Aug 2020 19:58:30 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Aug 2020 14:53:17 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-08-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea6ec774372740b024a6c27caac0d0af8960ea15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
