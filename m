Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AB8C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D8A82071A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593273625;
	bh=yeaCwpqSECTCFxMaYCulEAIX38enPKz/1j2BOtgNk0s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=w7uguu+8CxrvAg7gvSVuPv0yIfYTcYa0dbIwE/zySMdYlrFXOoNdA4LBNKGWEvQjN
	 qvFdNX3pTpYSpZKW2KR1f7lQk1uMd6nTA4XMZMytXwgd9LxUIMDA2IfffQdDKsVG/a
	 HK+cbC8z9G6GzopXlotGrRG3l58ZXsTJLBvAjMuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgF0QAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 12:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbgF0QAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 12:00:13 -0400
Subject: Re: [GIT PULL] RISC-V Fixes for 5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593273613;
        bh=yeaCwpqSECTCFxMaYCulEAIX38enPKz/1j2BOtgNk0s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eGbMP8fD/bOGh1n1UCVeFcMF1izSBdul1WEncVgCNAsAvgdPfIj9HUl+waYP5iTk2
         rF8TSfzXFImlRpkHNIMYGufY8xdAHVZYKVdQyoLY2Jatx/I/G0FFwm9Yp3Gv5UDphj
         qt5lpjPElVMkLmQDHxr6dXtZLuEr40MFtgVu0XrE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-f93a0d3b-0f13-4426-8f7a-77c153f1098b@palmerdabbelt-glaptop1>
References: <mhng-f93a0d3b-0f13-4426-8f7a-77c153f1098b@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-f93a0d3b-0f13-4426-8f7a-77c153f1098b@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv-for-linus-5.8-rc3
X-PR-Tracked-Commit-Id: e05d57dcb8c71492268ff46ba9bfe9a9cfb1f95d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b6ab1012cbcabf31db9c3a0c329d07dbcff4fd7
Message-Id: <159327361326.7015.2026111277110574291.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jun 2020 16:00:13 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Jun 2020 10:40:28 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b6ab1012cbcabf31db9c3a0c329d07dbcff4fd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
