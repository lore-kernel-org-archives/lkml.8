Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF63CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D117B207D3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589746512;
	bh=D9VWro2YKBZnYUUXAmM6NCvOWmY4Q+wzO0aHKhwhFkw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ayWEELrYNIl/HZr3THQDATsaKG9NpArHD3c/uOWWFprZh89O563c21lkoduFU4frv
	 8lTxcaQWO6Y2kfutFa3BHWS6uOAoXwnVZdt37dH3sUToBVt8YKPxq5fUvXI6R3zRHP
	 PWgWe/hnODyjgAM3zZHiM1SwGcz+p828EPlmTEv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgEQUPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 16:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbgEQUPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 16:15:04 -0400
Subject: Re: [GIT PULL] clk fixes for v5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589746504;
        bh=D9VWro2YKBZnYUUXAmM6NCvOWmY4Q+wzO0aHKhwhFkw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FW8Cb3ZCDnSr/O65PmW9cze6KEATMtJ7WSPnTbH6jWzbHpjsLrpKwrJMJc4dlEmv9
         r+cLwvcUa+u7sX1nMgXscXeJQ3j1kxs9NRBCcQAoyEEglLjRscz5DvZnTuOET5Zob6
         sSMYY9XSCMJoX1VRrBeoxWSm84Sh7NUMXI4nSaW8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200517174834.126920-1-sboyd@kernel.org>
References: <20200517174834.126920-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200517174834.126920-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 852049594b9af58fa2972103699fd58a7ac165c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b1f2cbdb6d3062c468d3f9b579501f0f7ce330b
Message-Id: <158974650408.31612.8511040806300170549.pr-tracker-bot@kernel.org>
Date:   Sun, 17 May 2020 20:15:04 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 May 2020 10:48:34 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b1f2cbdb6d3062c468d3f9b579501f0f7ce330b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
