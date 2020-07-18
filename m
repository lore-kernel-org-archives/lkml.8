Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9ACC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 18:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AAFE2080D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 18:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595096111;
	bh=qJ9DGh2MbDH+9LxJfZz7qg0S194bmszwbnjpsxmZ308=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kBMJBjDk77Tbo4osyhZ6PyzKGEDxPirA8SDWE55BiTrBeKXySsknJnbtvktpEk3my
	 Gu1Y+8I1OQSXEgeIlFQWH+C+l9kkcAVQtKT8Apd11QfZN0NrJW8YrIjMmHlW8NXztD
	 QMdOFkQT/zPDn6ZWBRNFOpF/U+aFgMLbE5oejxJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgGRSPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 14:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgGRSPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 14:15:05 -0400
Subject: Re: [GIT PULL] RISC-V Fixes for 5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595096105;
        bh=qJ9DGh2MbDH+9LxJfZz7qg0S194bmszwbnjpsxmZ308=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qZslVoSV29tZ41c+/ZHLQnBK0FLKKDAp4GdQ1QLgnJf3aqxVFI024pPtZy14fc2Lo
         KX6EqtZi3a4fVwv8imFfPexth4p2rJnnc+glB2bnmIXAQJjj6MyJhf+6zIr8hKpuCv
         FtnHflDVQ30SZQZouwq5DCHM+xPCKR+l9EQT9tKs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-8419056a-6b67-4a07-b5a2-6ca837bb9b9d@palmerdabbelt-glaptop1>
References: <mhng-8419056a-6b67-4a07-b5a2-6ca837bb9b9d@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-8419056a-6b67-4a07-b5a2-6ca837bb9b9d@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv-for-linus-5.8-rc6
X-PR-Tracked-Commit-Id: 38b7c2a3ffb1fce8358ddc6006cfe5c038ff9963
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cf7ccba29dcf39ab27630c383a3844078a6d5cd
Message-Id: <159509610526.11665.3440471012487224189.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jul 2020 18:15:05 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Jul 2020 10:35:48 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cf7ccba29dcf39ab27630c383a3844078a6d5cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
