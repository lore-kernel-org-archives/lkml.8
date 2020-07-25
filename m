Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52C9C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 22:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92661206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595716209;
	bh=LFOvGiJjz/Kyape8E60iNhD60q6fnSJQdDREInEYExM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lvlyygguiG7qHZmkr95Oiu8zQRmRMsgyJfMCG1kTFzY0Nx0aO6Djmf74PounRVEhD
	 WeoXeSpdOC0CA4BDjgB9tWyDx5Mu0MgOixFetOrD79bV3CrxCCk/e1eJML5SQ2gf7E
	 cSsJUm9AJcrSKbxl0Pegk5vytBwAbhdF+Y1QXTSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgGYWaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 18:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728064AbgGYWaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 18:30:05 -0400
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595716205;
        bh=LFOvGiJjz/Kyape8E60iNhD60q6fnSJQdDREInEYExM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CWimMZHS65Hr+AMXmp1OJmoNwPhdRJznNyTUsKw+tAlkoMBykVxZBz3eIlBil0lX0
         4rfKhqIoLBxFTKx8qioG0o4mCk6Fkm4b1diA9xKJtAt/FX3t+x7Jj4MJr70TpY2WQm
         QILR9KYRuxfZWRNebw6NzMfjPYbjPPtjpF0flaXY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200725114637.GA943758@gmail.com>
References: <20200725114637.GA943758@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200725114637.GA943758@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-2020-07-25
X-PR-Tracked-Commit-Id: d181d2da0141371bbc360eaea78719203e165e1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbe0d451bcea569fc0ed3455511a90646c8a9c81
Message-Id: <159571620551.7388.7515783635549986371.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Jul 2020 22:30:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Jul 2020 13:46:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-07-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbe0d451bcea569fc0ed3455511a90646c8a9c81

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
