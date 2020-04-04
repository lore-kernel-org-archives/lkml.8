Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B8BC2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 19:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EBD20735
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 19:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586028023;
	bh=rV8KssR0St+GoknFBtwtJMOFpMVA49djJuAhS71d65s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CY6FCsH+dNAgIForGHToxNfdK9nVGtbwUIDOoG1DvwKogF9t6glqgKWsxPM6U2Cmz
	 NNP/YtoXmq41ooXFTp4ZldSu8bpWSrX+Kx5EnF5ju0sEbVuqZa7tbLxxWO7NdDVmTS
	 zon5C6jhhLwBYb6bvqkZ8VEpXhmP7t7v5gaOTd9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDDTUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 15:20:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgDDTUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 15:20:21 -0400
Subject: Re: [git pull] drm ttm hugepages feature pull for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586028021;
        bh=rV8KssR0St+GoknFBtwtJMOFpMVA49djJuAhS71d65s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pg0sTwVaDKrqZGpDFgIxIn0wi3bozAjnJvIUPxZyUdFHReRdNgELx4wsVie4U3I3r
         +lXKx6GqbYSXlLTM4PXOdL7DHpu+qKrJOmkZ4JkchvVh6/d4lyuR0++02sZTQ8WG/M
         VPrOmXN9P4amQzhzsx92jzefB+8/rNOdAQo8k3No=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tz_FMuxj+RH3VqzVyN2yQC9xy8vePAz14HPKtVfEXs2iA@mail.gmail.com>
References: <CAPM=9tz_FMuxj+RH3VqzVyN2yQC9xy8vePAz14HPKtVfEXs2iA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tz_FMuxj+RH3VqzVyN2yQC9xy8vePAz14HPKtVfEXs2iA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2020-04-03-1
X-PR-Tracked-Commit-Id: 0e7e6198af28c1573267aba1be33dd0b7fb35691
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea9448b254e253e4d95afaab071b341d86c11795
Message-Id: <158602802105.32303.6851263343004440989.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Apr 2020 19:20:21 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Apr 2020 09:35:43 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-04-03-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea9448b254e253e4d95afaab071b341d86c11795

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
