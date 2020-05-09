Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663CDC47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E93121582
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589067006;
	bh=3m5vLMMt7xSTQVM1ToBPEDlQIEW02c2ZOV9SkMuqvoY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Rw7HVyBDkvWilS/5cwoje1tSNiYl40s1RjgKxVF29FhdOCypL7fUEDtioJqwWslwG
	 YP2tp6zjtTq9mvyKN6kOUbeayq+YgxDZADjIT2iXlp+R24GvFrL6jp72oRPr+4kDD0
	 f4N+KTzLVO2JK16icAHF2fKKoXCVpvCWUH3uJf9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgEIXaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgEIXaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:30:05 -0400
Subject: Re: [GIT PULL] RISC-V Fixes for 5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589067004;
        bh=3m5vLMMt7xSTQVM1ToBPEDlQIEW02c2ZOV9SkMuqvoY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CF45wfgqyH6zN0ImOw/jdsgSCkyi+8NPxUyPWCiz1SslEJrtTNmje8IS2No4Kj22f
         Qi8tuKxEsRXt7M7JlXBvL+6zc+8VRGe/1l9ieqaSE++9nqX/r2TQ90yG3IZdPVaj8I
         QLhZHiwalGYleqUKmu/abD65Gv2/y4WQkNZrpn7w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-81c83c19-6f5d-4ed1-a0bb-26accf4b7d3a@palmerdabbelt-glaptop1>
References: <mhng-81c83c19-6f5d-4ed1-a0bb-26accf4b7d3a@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-81c83c19-6f5d-4ed1-a0bb-26accf4b7d3a@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv-for-linus-5.7-rc5
X-PR-Tracked-Commit-Id: 73cb8e2a5863ccc5215660f5123db621bd57dff7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e28f3b13a41b8a7d36a73ddf4bb41972a9c1dd9
Message-Id: <158906700480.4509.666765554431792903.pr-tracker-bot@kernel.org>
Date:   Sat, 09 May 2020 23:30:04 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 08 May 2020 11:47:13 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e28f3b13a41b8a7d36a73ddf4bb41972a9c1dd9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
