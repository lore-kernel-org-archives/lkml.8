Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15447C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 19:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB0BD20772
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 19:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591470930;
	bh=cxND22Ha225UmQPRUJGsqR+a5+bQ/+hNOBaOgUBq/5M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=frgw+oPolFM/55kgCtJhIYyaW8f3eWYEm1IMfPgPKzDTiIpGf1098P4NQMFSgbBxp
	 91ZvsFdeOW0Sk7pMI9TpW/R6OwRxKqBJkRAryK/0YL/tMPc682JmFgelKwO+dJMZfe
	 7Fgv20GjplW3C/qCGUQATIUFhOSv2rINip2r0F/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgFFTP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 15:15:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbgFFTPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 15:15:19 -0400
Subject: Re: [GIT PULL] dma-mapping updates for 5.8, part 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591470919;
        bh=cxND22Ha225UmQPRUJGsqR+a5+bQ/+hNOBaOgUBq/5M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XpXyHUuc3ybHIiBvz4LadHvOaXLAwzXG+A48sObXyfUdfq0vJMq4E/a9roD4OxE9j
         5WhFtpnjIK6SBHO+z1PMzN1vhNMmmsD26X971+QVVvOiihkmvYFYEfpB3ollwO97Ru
         ioUG7LLNz1MM7rDk2CYwGk4mzkoBDMII/a/ZLKx4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200606160932.GB3482728@infradead.org>
References: <20200606160932.GB3482728@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200606160932.GB3482728@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.8-2
X-PR-Tracked-Commit-Id: 48530d9fab0d3bf08827f9167be54acf66d4d457
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f2dc3d335457d9c815be9f4fd3dc8eff92fcef7
Message-Id: <159147091934.3313.12740023106632055664.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Jun 2020 19:15:19 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Jun 2020 18:09:32 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f2dc3d335457d9c815be9f4fd3dc8eff92fcef7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
