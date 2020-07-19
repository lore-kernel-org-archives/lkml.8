Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61081C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 20:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D1A022CE3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595188806;
	bh=sDRG+fVR6j+7eboD4k0GBrVcJ8Hk3QdCEDsLb/zqQEg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=v+NLTKlnAvYp6dCl6DFNeuVQ6EwFLOYy7h2ZHJF5tdjJ/7enNwV7oSRJXlOitQBKo
	 h+VT7BCqhoxDh/N4rvhcyBg9RPCdTDrlCJtlHx/WI6bhmW1jURSFFVbZtXVG+6F73V
	 EcFkLBEr5EerItWcikmYPoe1OdOMt2qi7fXekNF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGSUAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 16:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgGSUAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 16:00:04 -0400
Subject: Re: [GIT PULL] dma-mapping fixes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595188804;
        bh=sDRG+fVR6j+7eboD4k0GBrVcJ8Hk3QdCEDsLb/zqQEg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eTaadjjG6soKoa0BnfgfFAm3WFaqBYmWBW9mhU1AIpQr8wWNLsQgxIeZLaQEJidaU
         gptWR1dtJo4JpUlh8qSuDczcKZ7a79Se3ynPaU0L8rP/zndJ6m890lEkccpZ8mtiea
         aEZ8CT5+ZrYcIditl2r/f19XLHA2+lHyT1TWZheQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200719073927.GA114439@infradead.org>
References: <20200719073927.GA114439@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200719073927.GA114439@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.8-6
X-PR-Tracked-Commit-Id: d9765e41d8e9ea2251bf73735a2895c8bad546fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c18fc6344568bdc131436be0345d82da512bfef
Message-Id: <159518880407.26827.13297417674901017597.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Jul 2020 20:00:04 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Jul 2020 09:39:27 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c18fc6344568bdc131436be0345d82da512bfef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
