Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58956C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 22:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36B63207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591051209;
	bh=gTxqf9JYkRHCdaC7CA29uGi2NUJdUKzKDIuiUnlgB2U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jSnR13zdpMOBU5ks6s8SadiWlr5xob51j+B0A4j7lLply/Fndy9dSlha1jBUX4Tsq
	 78S7xH7nNMURP7tkPHoVH+bjeArEFNXkgIjLFfagZc6EqnSTihXeqYm7Q1mBUoShoH
	 14aNIuJ7l7DRHTLnEZUrE5lrDR8WD5V6lomSLqzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgFAWkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 18:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729143AbgFAWkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 18:40:05 -0400
Subject: Re: [GIT PULL] arm64 updates for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591051205;
        bh=gTxqf9JYkRHCdaC7CA29uGi2NUJdUKzKDIuiUnlgB2U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TFqUVvsgJEMCNNownIBcwNG/tK6dL6P85x2GfXuKbEsf1AeUZa8+Ru/CMTYIMsN76
         lJFNXBqRC7El+QtRXhyAYPjzLu3S7z9vpQjGgnuAVnC79sQOpM7QVveeAG7ksnyES7
         h+/MiiuZ8r8/tMfh8+FLVWZA/dZx522yMD+sP6kw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601171309.GA6390@willie-the-truck>
References: <20200601171309.GA6390@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601171309.GA6390@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-upstream
X-PR-Tracked-Commit-Id: 082af5ec5080b028f7d0846a6c27cbb87f288205
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 533b220f7be4e461a5222a223d169b42856741ef
Message-Id: <159105120522.7127.9129325449911942435.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 22:40:05 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        peterz@infradead.org, bp@alien8.de, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 18:13:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/533b220f7be4e461a5222a223d169b42856741ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
