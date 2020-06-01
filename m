Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE18CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88522073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591048581;
	bh=K9yenokbYhv63GS4BDV59zwMmo2yB9Y7nyEVEmeXV6U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=N+eNQu6PhZoOwnRQkSL9kJNSI/eOd95C9ZJQJnuWBGHKP4QOAUQUTFpxZIE0R9wnY
	 TFGvGZI80x+TzyWnT//RY8+jc7qCBlXmhwOiKEo4HI5cwiET+3Q+Ztw5Ud6+fZ6Pue
	 GLne0Nab+Uiu4fPOu9Tl4a2A0KXFOeDsa5IHNZ+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgFAV4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:56:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728795AbgFAVzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:55:06 -0400
Subject: Re: [GIT PULL] EFI changes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591048506;
        bh=K9yenokbYhv63GS4BDV59zwMmo2yB9Y7nyEVEmeXV6U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N1wl83NhGKkAfDva+2oH9T4Dy1e+pvvFtJcb2T9tpK50Bgj7Je/8uvCLEaMCqdzCD
         /AuBJ0UMUBTeMac9m+TF8W81onyQR33HOskwK3EK/JtgCORw375C8AVgRRdEE6fe+M
         oHgOkGwDWXLYSCOQi43+HZ4sYUiICNHfBlBdvWv8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601132443.GA796373@gmail.com>
References: <20200601132443.GA796373@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601132443.GA796373@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-2020-06-01
X-PR-Tracked-Commit-Id: e9524fb97ab5b41b85e1d3408f8e513433798f3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58ff3b7604a461a766a84348e620834dce9834a9
Message-Id: <159104850645.21074.1730688295706521597.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 21:55:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 15:24:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58ff3b7604a461a766a84348e620834dce9834a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
