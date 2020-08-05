Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C296C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D75622CB3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596603914;
	bh=oefSIkeXgVAS41/cN1uO3ZwcTyaVPhroU76h1xcGD1I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uSVHgt+5ODaKvLgGtVcCj80YGOJJBEWuoIJZgULGUfhPnbVWz4x+esyXaHFpieXuG
	 PILb3Jg7NBJtAb/yhNxl9Dg5iTZjuNo/uorVWqGagl/88R/7EVdr+us6R9c25h46Tm
	 0bJ3dI+Lc6U8CSp2ZjuCkqb/4xKcrAYOs5zYYgGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgHEFFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 01:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgHEFFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 01:05:09 -0400
Subject: Re: [GIT pull] x86/entry for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596603909;
        bh=oefSIkeXgVAS41/cN1uO3ZwcTyaVPhroU76h1xcGD1I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hjozIQ9ZS4KdVHhGJ84mCNHzkfDPTxKV1iNRM2PC+A2iOMgTZKBEEUn4+K+g/4voK
         2YsJF+fFQoDEzGW1boJGNvbEtK87LyEH1AiFQ3p7vmrb3hlnu1V1GI/v3cQ+QJm82I
         NQLZ3Ra32yWnu74n40rM4zimL4/sdQVCT2z8TRFc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159652931703.11821.10293235307345307460.tglx@nanos.tec.linutronix.de>
References: <159652931338.11821.6870342948950391828.tglx@nanos.tec.linutronix.de>
 <159652931703.11821.10293235307345307460.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159652931703.11821.10293235307345307460.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-entry-2020-08-04
X-PR-Tracked-Commit-Id: adb334d17858d8b679a41f7f2cd230e5c6accc0a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 125cfa0d4d143416ae217c26a72003baae93233d
Message-Id: <159660390960.15119.6898239226508160918.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 05:05:09 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 04 Aug 2020 08:21:57 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2020-08-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/125cfa0d4d143416ae217c26a72003baae93233d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
