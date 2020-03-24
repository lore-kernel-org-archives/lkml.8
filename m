Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239C7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C312076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585070110;
	bh=Ptf2h+wtQSYQ+KyO+iq5FjGWavjKdwW24pR9LTKnnMs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FX4ge0LnsOTSdegmTzmQh6ZfoYx+lww9qeZRMoDo6X6g4+DyhoLyyfcG3YxJ5B8sx
	 1Ovwusw0gM5KgnVHm84Oh2CPrlFPcFCBvP85P8iS2f3T/kMFmu9WUfrYofT/UvK6OG
	 MJLM4/mtWJ5XJuvsKyRI7q/M1sp+OV4YpPoV3zcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgCXRPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbgCXRPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:15:08 -0400
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585070108;
        bh=Ptf2h+wtQSYQ+KyO+iq5FjGWavjKdwW24pR9LTKnnMs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=f6Yq5ExFf4XC+wDmuGLD7WCdsxoHgFaNlyPgPc2ZXr2oY/9Hbv6xLH8vWTlCCZVTc
         7vt1OyDxI25OSSDBEngDAsTW2Goz3nqmyicpECPBQaJZ9SKWgMia/GMJ7RqX3xyteP
         IOuPFai593AAurjBCq+0QQBa9kbi7l0zPpa+9Cc4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200324091952.GA66321@gmail.com>
References: <20200324091952.GA66321@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200324091952.GA66321@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 564200ed8e71d91327d337e46bc778cee02da866
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76ccd234269bd05debdbc12c96eafe62dd9a6180
Message-Id: <158507010827.16590.2535992708509912561.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Mar 2020 17:15:08 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 Mar 2020 10:19:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76ccd234269bd05debdbc12c96eafe62dd9a6180

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
