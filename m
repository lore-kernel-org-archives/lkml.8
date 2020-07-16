Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13B7C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B9A20775
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594868705;
	bh=y+xTj8vCUp7ZPxPNeTUclSzLv4VwPgxHMV0iB8/ctB8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Y6BEGWzgkETH5LmIKFuFRYjnLADUmpXouGyY7KXd963tdYhR0pldZV8VJ+CjqRHBb
	 p5oBXb+A8sWOnEZHbSwNJQpkFJac1cIHJ8zSRHZZ1k8Gh688Br2Uf8vAs+9YGrAL/G
	 xHBocjtVuD8IFw2GfCoG72y8wWGOGEQ/ZgAL5sPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgGPDFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 23:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgGPDFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:05:03 -0400
Subject: Re: [GIT PULL] clk fixes for v5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594868703;
        bh=y+xTj8vCUp7ZPxPNeTUclSzLv4VwPgxHMV0iB8/ctB8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cxJKxBddXfwjDIwakIHvXiXTNBWMS2X5RSgCCNdvAAhuHHMoWsq1a+KYr5vvrrwgc
         XNZFvbGxi8IYs0UQoE75AfXTK30QzLZVKsGEahRd80A99pksDb2cnrwRnWSiNNqMXo
         yQgG2M4EmPR+algVoMkye1JkR9s/IEjTtBLVNTtk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200716012221.2640243-1-sboyd@kernel.org>
References: <20200716012221.2640243-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200716012221.2640243-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 1e7468bd9d30a21e059af477106dc5588ae52dff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8456690ba8eb18ea4714e68554e242a04f65cff
Message-Id: <159486870344.19183.9720520100761121739.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Jul 2020 03:05:03 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 Jul 2020 18:22:21 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8456690ba8eb18ea4714e68554e242a04f65cff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
