Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE019C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F6F20760
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591646734;
	bh=qNznkMvTDeK9huF7Jpwu0P4DSnqTVtGEO2Gct3OTSUw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kgmDxwpbGEFLV0nUFaRkOHZdzxTANNx2/afAOs4nXq3Nq3YEgVMsVK9NlluS9cmRq
	 Q5ClRbXkNi4LE+pyoQ9IespmI7OEwWnZVIg4s6YmJDT/qKIBBSDnMKRRuqvwYARD3w
	 22qjzQ7zwBUmKpV2dpl3eUGtXCKePL1Fl4ixzMso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgFHUFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbgFHUFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:05:25 -0400
Subject: Re: [GIT PULL] rpmsg updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591646725;
        bh=qNznkMvTDeK9huF7Jpwu0P4DSnqTVtGEO2Gct3OTSUw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qeu9pqCqmmWZn3e9UMovBndbh9CWFFi1bqgMo1k0t/w1guXOb1TDVSdj+pS1TRBWb
         Kw8AiMNtGaKA7b3MRmmguU5ru06YgqBubfsZdZxkfyBRp3gpCBS1TLAJtvM+MxUw+6
         D151YnnzHSl6WSiELYGaVxTSFPh3g0GhkpSTFUn8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200608182856.2302518-1-bjorn.andersson@linaro.org>
References: <20200608182856.2302518-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200608182856.2302518-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git
 tags/rpmsg-v5.8
X-PR-Tracked-Commit-Id: 4f05fc33bebdc7d69259c412dd21d09751827dbd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d26a42a9614083413e778832a6efbdf0038c3bff
Message-Id: <159164672511.26583.12607767880488664875.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jun 2020 20:05:25 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Wang Wenhu <wenhu.wang@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  8 Jun 2020 11:28:56 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rpmsg-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d26a42a9614083413e778832a6efbdf0038c3bff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
