Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A41C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5584E24687
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580153106;
	bh=7DFYdclrfs8T8hz/KSdLIycCPrSQZi+dHkRQ/z312wU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CvEbViaIjXq/km2PclH0S7e5hWVuH6tbdX9dTvkq5fZpF8fDfe/jLvXJvUHGcx17J
	 mU/blhUOmpmL/32GVt+hUengcmoCmj0uuGiEFMqvXXhSfLOmDRqXf3mHQ07kfYhYhp
	 p6xsPHAK7ymGAovEda4S2iDsxnhgi6tO1rUsU2EU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgA0TZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:25:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgA0TZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 14:25:04 -0500
Subject: Re: [GIT PULL] SPI updates for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580153104;
        bh=7DFYdclrfs8T8hz/KSdLIycCPrSQZi+dHkRQ/z312wU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YPSsqlhAuUV6ke1Ld2lU479c/wQJ7D6nC/3ZgPI3wY73ZNvORVtUEJiweYJumXR/f
         xmLzFiMxC7C+VmUOo9S8kIkiWWkr8uU+k4zo71BxrD1dWEDK+haB5k0ZuyMyRNrvRe
         9+5uTHIWFaBcLL94tSoVn7v+2v7oHcE0odMjkb+4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200127170454.GC3763@sirena.org.uk>
References: <20200127170454.GC3763@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200127170454.GC3763@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.6
X-PR-Tracked-Commit-Id: 754a36a58c29718bf5e28b8789b17bffbb60e8a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e1ab4ba4747afad3e44a77dded1bab4cb77049e
Message-Id: <158015310421.9462.12849884534711052397.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 19:25:04 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 17:04:54 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e1ab4ba4747afad3e44a77dded1bab4cb77049e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
