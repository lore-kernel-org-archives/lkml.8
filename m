Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14769C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8169206E2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593810920;
	bh=8nOFr5WReM9/ZNRXfKtg3p8+S5tm54BJCGmZ+ZuDb4g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mg8UKh33zxSrOZOwV+TmuxuSfxagVUWxoRxqduXq2S8tjtWMQGY3+1dFuzDzYy9T1
	 ugW5fG2qjeWTUvr3Abw4ObsevV7HHO9WaZPln67RFjJpm37cwAlAxu2mkADXHdEgpj
	 DLwbtG+i+umN/b2PiueiRkOB65PRI7pbCE0OiYVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgGCVPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgGCVPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:15:08 -0400
Subject: Re: [git pull] drm fixes for 5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593810907;
        bh=8nOFr5WReM9/ZNRXfKtg3p8+S5tm54BJCGmZ+ZuDb4g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tVORYXl2guq75NmaZ5bxlsNzhb5gmyH0pou9gYHKn3Zvp+8BE3u4AWbU4iA8sU/aD
         dLyT9tpfuWLu+URJNvjsLwakdgmwtZiHm0693DJd1cKweejxalEUMFcgXwjc3KdcWL
         Ah4tQ7kYKCWCwRMFx2icyMPZUof0zxfOSj+HK8k8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx-1Z5fRAAENHe-qnpBPvaQfn24-84QR-vnivH5-qQDEg@mail.gmail.com>
References: <CAPM=9tx-1Z5fRAAENHe-qnpBPvaQfn24-84QR-vnivH5-qQDEg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tx-1Z5fRAAENHe-qnpBPvaQfn24-84QR-vnivH5-qQDEg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-07-03
X-PR-Tracked-Commit-Id: 1298a549e22abe36c82208406c7069280553c7dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d42871465291c3f117ea3c9fbce8d4a603c303b
Message-Id: <159381090765.9451.15520818943136259606.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jul 2020 21:15:07 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Jul 2020 11:46:34 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-07-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d42871465291c3f117ea3c9fbce8d4a603c303b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
