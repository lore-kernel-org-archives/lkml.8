Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1ABC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE8E221F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587075331;
	bh=XpIMQIWcueISAg4dETpJJ6SrYPt+w6B/MF4ltSLjw6M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Suaxa9CXNN5QAW1A3lHKxvD5O6LLRcwgK5tdyaY0xDZaK1BdtfSdb24UjVEeGbmxb
	 Ki8QZhmxZ2tlUV4WMfepO+JG2zQEAxPXAZbDD2eHNqhexRDW/R6ceX71Kt3KCikSEu
	 gIlUa/AZC//NMzlvcJ6WQkoMqtANCbxb2AKSaBHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgDPWPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729350AbgDPWPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:15:24 -0400
Subject: Re: [GIT PULL] chrome-platform fixes for v5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587075323;
        bh=XpIMQIWcueISAg4dETpJJ6SrYPt+w6B/MF4ltSLjw6M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RuXJfsdl/UC/GrJgGhkr4moi25PlubdEYenQiOYM3WTTF2mdbs8+uxEB0de7IE3GO
         5FFcFptk/Z6Bu4cwb2+Wrlkoz8qbdYyPC8wWlSEvYSrR8Y9ujVFyrlF+2L/Mb3k3/L
         xWDttIFvhRKtspNxr7rjByiERBPKqMxb7Lxr8h1M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200416214035.GA1586@google.com>
References: <20200416214035.GA1586@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200416214035.GA1586@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 tags/tag-chrome-platform-fixes-for-v5.7-rc2
X-PR-Tracked-Commit-Id: 538b8471fee89eaf18f6bfbbc0576473f952b83e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2fcd80144b93ff90836a44f2054b4d82133d3a85
Message-Id: <158707532371.2733.17062166003215775460.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Apr 2020 22:15:23 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, bleung@kernel.org,
        bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Apr 2020 14:40:35 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-fixes-for-v5.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2fcd80144b93ff90836a44f2054b4d82133d3a85

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
