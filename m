Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727A8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 20:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CEA820776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 20:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592598327;
	bh=P2SsJqPjthAAmm3aJvqDFeEcXcH3hqQHTcjrBRY981s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Jgd2qBm1pOC4DxzoiXaVMgMvPJAeQwFOnVqW2DCKF7c2mguVnHAMY4PKEtygwPTuf
	 mvDfvtAYNl+Enp+lRZimmYKA92Jn+jte47OwIW3Ucz6rVWsq7n3Kdv+SJODz4b3Q/9
	 OD8JfiwbITstKhM2obtrhoa/droRAwhh1HFEXPB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388739AbgFSUZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 16:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgFSUZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 16:25:23 -0400
Subject: Re: [git pull] drm fixes for 5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592598323;
        bh=P2SsJqPjthAAmm3aJvqDFeEcXcH3hqQHTcjrBRY981s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=C0Kn/yvyoHTzuF9949MuGeqiazp9hLBpl8Cdtna9ZDCidtIBGsHJS27j8gV7Osz3j
         x1eoRit0xfS13Eis/SGaNNHvccGhfsJf+vqcim+vLfbeL+1FEjdwEs6tKoJ0A8BJaP
         EnhcQTFdLQp5nQTB2czwwcrT8dxsJIrPtLtUxKzI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzY6Md_x57APC-u0eWTztTmB1g-78XQk-dFS++7W1DtgQ@mail.gmail.com>
References: <CAPM=9tzY6Md_x57APC-u0eWTztTmB1g-78XQk-dFS++7W1DtgQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzY6Md_x57APC-u0eWTztTmB1g-78XQk-dFS++7W1DtgQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-06-19
X-PR-Tracked-Commit-Id: 8a7a3d1d0dcf2bb63dafe7275020420005e13e54
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62c91ead977a5d5023be3d791cbff8535f7d5433
Message-Id: <159259832312.1498.1663559978022920624.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Jun 2020 20:25:23 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Jun 2020 13:00:42 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-06-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62c91ead977a5d5023be3d791cbff8535f7d5433

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
