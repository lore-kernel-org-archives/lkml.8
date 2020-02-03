Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0674C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BAE21741
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580769321;
	bh=ifrmQhAFhuHgRpNu279tBLv4i4KgcMX+9QVeET2SqvE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jHSS4H9nZPSWxxZHZRezI5m+/ZKa6oQ74VyEoo+N+L0HCv0mPenunStBL3t70Q7Fo
	 ZN2uwIZYytSMMyBBtBf21mhjqwX1xAx2UDtapL7WzYl64YAPXljdudmyKMpa5mCeL+
	 lKFtLA8LOiZnBOLdBWMYVVlc779m2NG36O7mZq3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgBCWfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:35:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbgBCWfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:35:17 -0500
Subject: Re: [GIT PULL] clk changes for the merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580769316;
        bh=ifrmQhAFhuHgRpNu279tBLv4i4KgcMX+9QVeET2SqvE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=agGKZJ67P7ShP/SCJy5C3aj/Bdx9TZrdWMXP/TlW0SPoeoVa8hdfbwL6mKkY2Ej/x
         MjqPdsv9z6M7lnhzRSeHlVjaL/eWL8xtnGtGxCXvX5WcyqANvUjthKRUbWerXQr2UJ
         2DP6qxEp6bUER3hd95fNH2vir+wbCkkMNtvMHz6s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200203193854.123503-1-sboyd@kernel.org>
References: <20200203193854.123503-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200203193854.123503-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-for-linus
X-PR-Tracked-Commit-Id: fc6a15c853085f04c30e08bbba7d49cb611f7773
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4a6365ae88d38528b4eec717326dab877b515ea
Message-Id: <158076931640.15745.7002053467514985709.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Feb 2020 22:35:16 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  3 Feb 2020 11:38:54 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4a6365ae88d38528b4eec717326dab877b515ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
