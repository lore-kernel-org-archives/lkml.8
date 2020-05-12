Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB302CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A292312B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589309706;
	bh=o9R5f/2AmYKBTdwDgSz8+Yd+khsI/ycCqI0DPfgO/gM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1T6fL7VVj7Uk0+ZFBwciliHSwxMcI7KIxx42apgCQ9QHHWN7VVIdSv650tTm5A9YP
	 v6YeHXrX9bWhGDpnJbTV/I5KGfr1YinorR3VWoO76shKLRSdRIpwPILeS133VEae9q
	 Pd5KXlJexNWb7yfZxmhSXZiTIgJlh7GGCj94UvRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbgELSzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730899AbgELSzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:55:04 -0400
Subject: Re: [GIT PULL] GFS2 fixes for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589309704;
        bh=o9R5f/2AmYKBTdwDgSz8+Yd+khsI/ycCqI0DPfgO/gM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gCXudLttv+6gTgv9TF9g2U8C+LWPtNnftQkXzbqcshsbqi+IQ5EcnPM+QamZ04INB
         OxK1pxhMd0HIue0wjsQdjFdaojFhwvZsQD+XxddMuRkt3rmrqgC3GfzE8d0NKJyqUs
         iNRcFZG5SF5S2+NqrSRUH2L8QYFW81jcFZQfy+pY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200512145434.160164-1-agruenba@redhat.com>
References: <20200512145434.160164-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200512145434.160164-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
 tags/gfs2-v5.7-rc1.fixes
X-PR-Tracked-Commit-Id: b14c94908b1b884276a6608dea3d0b1b510338b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e719340f46bd9413590121b140714728862ffe05
Message-Id: <158930970419.9866.14834853183650860586.pr-tracker-bot@kernel.org>
Date:   Tue, 12 May 2020 18:55:04 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 May 2020 16:54:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.7-rc1.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e719340f46bd9413590121b140714728862ffe05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
