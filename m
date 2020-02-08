Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CECCC35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 22:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E927621775
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 22:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581201338;
	bh=neKyHKrGunTqJTZQdxgqNZjkAWqW03U4ISYPB1yGWBg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AOT7VrwlkzL0A4irpvxPyBiVwbGWxHgiWB9uidfWnWF8ejPqsbcNCIhar60vv5Qlc
	 JWyTuC42bHPPVR7H8DL/N5iIFuQouqOMQYR89ibdtloj/7aI2E97N+RCxnJnYNzvFp
	 MYUtkmPK0yT+dX3zi4JccRoqK0ip3iXOopyaK6vY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgBHWfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 17:35:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:57108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbgBHWfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 17:35:31 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.6-2 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581201330;
        bh=neKyHKrGunTqJTZQdxgqNZjkAWqW03U4ISYPB1yGWBg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oiTP4ZArqitDZaXbPaHfqc9cH1QtUekaHzsclAjtkFjnMN8euiqiyITYVG2RRoEwY
         vDEAvvzI0iwLpf3yQcE1YmbCuWK+bahhO0NFbOVM7NTrnS2CtfSfV8VailtCPuYlEa
         9ExMmVCKJSTC/j2h1nUIdACQJ4zx/lpelBzgEniI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ftfl1bs4.fsf@mpe.ellerman.id.au>
References: <87ftfl1bs4.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ftfl1bs4.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.6-2
X-PR-Tracked-Commit-Id: d4bf905307a1c90a27714ff7a9fd29b0a2ceed98
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4f309ca411887cd61ea389c7abfb70c2eb1e532
Message-Id: <158120133064.28764.11145107652695294453.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Feb 2020 22:35:30 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@c-s.fr, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 08 Feb 2020 23:52:43 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4f309ca411887cd61ea389c7abfb70c2eb1e532

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
