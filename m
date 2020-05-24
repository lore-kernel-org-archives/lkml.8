Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18650C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 00:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD0C120735
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 00:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590279604;
	bh=2wbNW0bwyjO+vUh7ssuCFbgTNBBdBTYCdA88Amnu9eo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=s/ekLzptfX/GowsQ4Jh0jhw43DlbQZts1y12wrUdfx/3Th4kOJtDSsPkTLVzYrd4Q
	 sj+QGrh8ip8JT2QFL9S7XfsT4Pn3S5AbWCfh5mp72j23fZbUz+J082IZkBxeBvasFT
	 p+ZglEfS4i8S1HQVOcX5wXv23MTl3mwG6SUv9olE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbgEXAUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 20:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388094AbgEXAUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 20:20:03 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590279603;
        bh=2wbNW0bwyjO+vUh7ssuCFbgTNBBdBTYCdA88Amnu9eo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=u03oMAW/U+PuvdmYsrsKID7adMbsAr2hY6ADPnhYCntKzn+hw37SI449wumznJGx2
         gBpgO+w2L+asfwWJvENf6uoO2Agkq7bIV7uPEIUqYMbWaJIBgJBPJ6mBT63gvttTrv
         DVUGrDq/lx/dccNWrQf3w4Sa2NdH3urYsECKSMzE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200523.170654.66302705884131064.davem@davemloft.net>
References: <20200523.170654.66302705884131064.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200523.170654.66302705884131064.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: 539d39ad0c61b35f69565a037d7586deaf6d6166
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: caffb99b6929f41a69edbb5aef3a359bf45f3315
Message-Id: <159027960327.1872.1044358515428595667.pr-tracker-bot@kernel.org>
Date:   Sun, 24 May 2020 00:20:03 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 May 2020 17:06:54 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/caffb99b6929f41a69edbb5aef3a359bf45f3315

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
