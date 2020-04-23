Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9624C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C201021582
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587660326;
	bh=YrMFeTdI3wX0lbT2CAoq1eX5P4/UmlD45Rj8jf9ucro=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=b3/Hq/FgDSbhPbsHDatWBRLY+QzFSsnus5TQ1c6tWNWEcRU9y+UeKTS6bKatt5ZCT
	 vJbZybemUamyn3x/H/AJUZEQVHY5whKp6ZZkz1xkJcC+g3DyMKycgIPB1Tcb4xWMn1
	 WcyDrcCpl3hQ0s760wZAN/0mBWrLNDM/vGq1JC7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgDWQpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbgDWQpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:45:19 -0400
Subject: Re: [GIT PULL] remoteproc fixes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587660318;
        bh=YrMFeTdI3wX0lbT2CAoq1eX5P4/UmlD45Rj8jf9ucro=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=V5AVlCs2Wcwpe7TWeRAq/aPA1m+HUvNz8roiSNKp+fpcqtiXYAN/jhwIRBQ052eHb
         rA8D3o2CFPbNEZbF0a9/0ZRV20bvwb91uqpcpaJJw9CPJHsO2AYth4q1mVagbTPlE6
         +bomwueb3Z33nu5C3V9x+yNVFovpQJDvolKoYwWA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200422230833.GA2112870@builder.lan>
References: <20200422230833.GA2112870@builder.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200422230833.GA2112870@builder.lan>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git
 tags/rproc-v5.7-fixes
X-PR-Tracked-Commit-Id: c2781e4d9bc6d925dfc1ff833dfdaf12b69679de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3cda77991eb75aa0066065b7f352a4349ca1a3bc
Message-Id: <158766031890.20212.5272714956436329155.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Apr 2020 16:45:18 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Elder <elder@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Apr 2020 16:08:33 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3cda77991eb75aa0066065b7f352a4349ca1a3bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
