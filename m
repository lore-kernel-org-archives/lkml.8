Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2A4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F4E20826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590094505;
	bh=7iGNOrc13huB/bF3AMhbWuoQe34FHKR2s4DsvfhVVgA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=UmdSi0MhTTfiMVuhx2PnG8FdcPJY+I7j+pQ51zswpgTDDavOjaF4GbI5AYy0A+EVp
	 8UxMouxDmCcyq2dWJrb0IMpan6QwOm7fT5gZ8ocEi6wNDARGi1L0vl+4XfSh4Jl3Zl
	 VEwn+Gmf/D+IXyO18jeGQaDp9rj9iFwVl2VTtsFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgEUUzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbgEUUzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:55:03 -0400
Subject: Re: [GIT PULL]: dmaengine fixes for v5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590094503;
        bh=7iGNOrc13huB/bF3AMhbWuoQe34FHKR2s4DsvfhVVgA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FxF0RSEVSzWcLDnC0mUonYVZ726tZQkyEyNXsA2n/LW0kghzbqpCe4IeMbp/8Zvsk
         lsPlNN9gM2pkVbBB9dv/RJ1p1DI3s8f610PYmRyUbDG5CNNQxtYh8K/ZZqprahB4Rp
         qsUUIxXtop96PtMRtlD8Ium+UA4JE6AaIQMCENJw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200521143521.GC374218@vkoul-mobl.Dlink>
References: <20200521143521.GC374218@vkoul-mobl.Dlink>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200521143521.GC374218@vkoul-mobl.Dlink>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-fix-5.7-rc7
X-PR-Tracked-Commit-Id: 3a5fd0dbd87853f8bd2ea275a5b3b41d6686e761
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cedd54f713368d32c902befc3714b91afdec1084
Message-Id: <159009450355.9071.17759578303074194234.pr-tracker-bot@kernel.org>
Date:   Thu, 21 May 2020 20:55:03 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 May 2020 20:05:21 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cedd54f713368d32c902befc3714b91afdec1084

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
