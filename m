Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8ADC2D0F0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB1D20643
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585698919;
	bh=UY4X6QF5Bfy3V1pVtJ/M4nE/WgRyjfPeRFCXPafV/cA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Q27A+w+7A65M1qCcRJJzYX69peOUutzhcWHXIhs0y8wSlWWB9LUuNcAdCe/HxAXd7
	 5lsoWC9yBKF2/r9mtyB8L3Texjzv6Vpa3yu/gOJ/XtQ9t24g67gnE9QdPWSf3OtbNO
	 T4msNk51m0ZHWPDekpcAnm0GhCBxHYrGpDURcSgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbgCaXzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 19:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732068AbgCaXzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:55:14 -0400
Subject: Re: [GIT PULL] NTB bug fixes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585698913;
        bh=UY4X6QF5Bfy3V1pVtJ/M4nE/WgRyjfPeRFCXPafV/cA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gkAJAf7g3cRGzXE4rIoRGz9cfaQcU8hkGYPKVktdECG5QSyMgQM1ZpZ2kRnMejOUT
         hQy5gIT2I8cjqynyIPIePcznnEoNwHWOnirifCJkoa0R4jCoqespk+sTmje4KLWXm5
         ZIsE8lt9Ij6t6zNvd7Z3eObif3g9qxDleNtmeAtA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200331152721.GA1719@athena.kudzu.us>
References: <20200331152721.GA1719@athena.kudzu.us>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200331152721.GA1719@athena.kudzu.us>
X-PR-Tracked-Remote: git://github.com/jonmason/ntb tags/ntb-5.7
X-PR-Tracked-Commit-Id: b350f0a3eb264962caefeb892af56c1b727ee03f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56a451b780676bc1cdac011735fe2869fa2e9abf
Message-Id: <158569891371.16027.14099209625031293428.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 23:55:13 +0000
To:     Jon Mason <jdmason@kudzu.us>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Mar 2020 11:27:21 -0400:

> git://github.com/jonmason/ntb tags/ntb-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56a451b780676bc1cdac011735fe2869fa2e9abf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
