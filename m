Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9B8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A72206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591040120;
	bh=1t1QVkm6X5w9z2THN4j4Vz9f2RfmzNv+B53krBVl5Bg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ym+sAc1GcXKC49I+wy4ajUuzpQ0jyulnX3x8CGoTGSpAr5MhLVi/rKoVjQd13i2u1
	 abJu65j/x5CGSgAa9Xqg862j+f8xHJSCqD7SPQ0nDxDr6HHj9+94VnHawe2OFtpbeT
	 iBSMj0JnDqsQqUWKvCzJDqO8Uo6XMaWkujibPvlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbgFATfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729600AbgFATfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:35:12 -0400
Subject: Re: [GIT PULL] SPI updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591040111;
        bh=1t1QVkm6X5w9z2THN4j4Vz9f2RfmzNv+B53krBVl5Bg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bm2dsx8/k9RQgymQz9bXes52B1Lt9P2x6TCUmJIQQp6jLRGgG2284sPc+NemKaSPs
         GkhXIMDy4wTnlEaunFIC1pU+fR4vsCRTED6/gsqz+Kt0LnXd5JTzoL/8rJm5SFOtdp
         AceyXbAntOX0BqEKSOJplURtm2kn03H8q576BIGg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601115456.GA45647@sirena.org.uk>
References: <20200601115456.GA45647@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601115456.GA45647@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.8
X-PR-Tracked-Commit-Id: fb02b9eb4e335f8965badd1e6ee24fdc284cb395
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a36de5ebac2bea1d30e9ad103b4f841a2c4bb61b
Message-Id: <159104011175.18844.10485380840144223288.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 19:35:11 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 12:54:56 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a36de5ebac2bea1d30e9ad103b4f841a2c4bb61b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
