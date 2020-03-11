Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721BEC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5972074E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583959512;
	bh=qioyWwvoLG8iV4hWLTyTPLcqaKZM3vYWLZtFmHydHMc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tONFnzs+96F/ou5IirHwV8wEWF0X64Qo15hNJsssHfOT9bFOMbaNL26W2PRZ56xme
	 iWUVKLuwp9r0uelLKnAswq4QRbZc8HepA8dgNq12jFnu5Q8kQfdGBU5UVPTHHWT2m7
	 2lLBbXt4yQztcI40a0Js6BcsCjzwEMGELBIApXp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgCKUpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729235AbgCKUpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 16:45:08 -0400
Subject: Re: [GIT PULL] MIPS fixes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583959509;
        bh=qioyWwvoLG8iV4hWLTyTPLcqaKZM3vYWLZtFmHydHMc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ufKNYpt3yVPB7fdOjRt13031yiAshwwH5RGBfSGfngwoTCMpJJd4loMEqyozW63OF
         riRfbqFOqxRInk6SHePiRA4uxoSKT1kJobt1uTNc67fsCc/8f8LUJfWt8ljK6E+/Te
         SyiOIVMNubofPpAuNyetGmS85HYqyD1xFTtBcD70=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200311101155.GA9476@alpha.franken.de>
References: <20200311101155.GA9476@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200311101155.GA9476@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
 tags/mips_fixes_5.6.1
X-PR-Tracked-Commit-Id: f7d5f5655ef7e5d2a128f6696ac35256e83b119b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7f26a0ce61eb51a4849bdf3268bedd251b6dbc6
Message-Id: <158395950828.14877.10221920522241270050.pr-tracker-bot@kernel.org>
Date:   Wed, 11 Mar 2020 20:45:08 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 11 Mar 2020 11:11:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_5.6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7f26a0ce61eb51a4849bdf3268bedd251b6dbc6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
