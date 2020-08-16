Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E980C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 01:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537A4207D3
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 01:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597542915;
	bh=DbC7qc6GK+RJwdq/aKeS5/2ik5cnH24BnA3EMdVAe2Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IdQ9mVq9ePy20lL26ZZUiIk8azLy7pKPLZVHrO4yWmaKygGRaQdiiw4gBPkZhDRJR
	 cacil/xH7WhiG+drbKEK/WC3rtZM30LNMUdJ66QMt4TTItWRFyAZlK8j9CrnIAzFEE
	 a7Z8D7bNLcRjzh2498zlfTaoLT0tbhUPopSjJfCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgHPBzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 21:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729675AbgHPBzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 21:55:11 -0400
Subject: Re: Re: [GIT PULL] edac for v5.9 (part 2)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597542911;
        bh=DbC7qc6GK+RJwdq/aKeS5/2ik5cnH24BnA3EMdVAe2Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Vl/LhXjIHyIAVo+tK0mQ0XOtoS43Wq/liscS40fXIEIJMNgWtKXyZkFD7WRjOGMUv
         X6numF9vByJiBd9MG1vPP/ueO3/VA+nAo+1nesPa3P2WgQGkngyjkgfD+pMGZP4Xtz
         AquEe+L97CfQi8pCOA1qMDhZb26V3ZKPC/nxO8Bg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200815172103.GA1628@agluck-desk2.amr.corp.intel.com>
References: <20200815003645.GA22594@agluck-desk2.amr.corp.intel.com>
 <CAHk-=wgFg+RNU3Aa7paCPCLpUiTHGN1PuC2AGZoRSOxD=trKnQ@mail.gmail.com> <20200815172103.GA1628@agluck-desk2.amr.corp.intel.com>
X-PR-Tracked-List-Id: <linux-edac.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200815172103.GA1628@agluck-desk2.amr.corp.intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_5.9_pt2
X-PR-Tracked-Commit-Id: 709ed1bcef12398ac1a35c149f3e582db04456c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ffdcde4ee9a20beda096dec664da89002610d7d
Message-Id: <159754291138.18953.15694164194537387692.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Aug 2020 01:55:11 +0000
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Aug 2020 10:21:03 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_5.9_pt2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ffdcde4ee9a20beda096dec664da89002610d7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
