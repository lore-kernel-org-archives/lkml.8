Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6484C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE1422522
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581112523;
	bh=eOg7uCNUfLa/+rx8dVAnlqV5Q9xH+G5SaYr0Z0vRbfY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CATAcX+gvBWm5Asnf7umB6aNtiFku8+mntXmHfahkRoZY0Eb92pVr2+3DQWtuX16u
	 arBAPR4fMnA+oy+adlCRzw1/qnaujxcdr2rdMeFztcV0EberSpp8MZUI6DolrxCi9S
	 YN/u6fFWCE8lwo+iVink72f/j4CktG2lkTJPCkII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgBGVzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 16:55:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbgBGVzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:55:18 -0500
Subject: Re: [git pull] drm fixes for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581112518;
        bh=eOg7uCNUfLa/+rx8dVAnlqV5Q9xH+G5SaYr0Z0vRbfY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZmKoPJzqR97Ld84+oP3V0vF7CuJbs8UeLbMf02Fl3kwBqsZTtnycw7OmpXk7fSdLj
         1HHfdDu0drAEEKzDxs2ppxH3Yj4Tzb51aP3X4pOsZrn3W9qSZwJDsPTKmZNjRmKjKr
         fJszRvn5qP6ji4VYHKc2IuMCrL7Jw+KATeDJhaUg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzWZoQ_t-v2p=m4LKFE+Mb9oofL406dLvaXOiappqcNhA@mail.gmail.com>
References: <CAPM=9tzWZoQ_t-v2p=m4LKFE+Mb9oofL406dLvaXOiappqcNhA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzWZoQ_t-v2p=m4LKFE+Mb9oofL406dLvaXOiappqcNhA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2020-02-07
X-PR-Tracked-Commit-Id: 9f880327160feb695de03caa29604883b0d00087
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c16b99d6c5a3f103ae45e33084055a2440d70544
Message-Id: <158111251847.9631.6641473871149555872.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Feb 2020 21:55:18 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Feb 2020 13:29:48 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-02-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c16b99d6c5a3f103ae45e33084055a2440d70544

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
