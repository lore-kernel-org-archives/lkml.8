Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8767C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B425B21927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582656912;
	bh=5TE2/XcIDrM1ynnHbz3LDakd34ty94tFlreoyNAhvOs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QxUWRIUF5r33S4PSzt1nuWA+VabvFwWu5Z3E5ljxcenJO4VjiXhBuXvA35GlBi/0D
	 6ZyFE7wR9Rg6aX3lhbm9oUo1mvLBXVcJ3ZV/sPa3rl/xHf7CSzdvhkILxSvTbDcJzC
	 P4SZhQadKWJfZzCKnVprHZacJxs/hTjGSm88Cv7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbgBYSzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:55:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgBYSzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:55:09 -0500
Subject: Re: [GIT PULL] RISC-V Fixes for 5.6-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582656909;
        bh=5TE2/XcIDrM1ynnHbz3LDakd34ty94tFlreoyNAhvOs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oslJEC+Vq62ItqEX1IMEEn3ltSMkgn59tAuDuJrmNHAbSMMUUZ057T8FPzEu7FEHd
         LK5+q1YR2aGSwK0ahFe94HIXRLsI57GAX46DN6xObMjjyW97oXLMKMPLhjHATTTCSs
         KbbkWnCMoG7eSm9uF7iQIoyJFH2I2sARzqxmhOV4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-464e74b9-125c-42e3-9384-60c871d22cfd@palmerdabbelt-glaptop1>
References: <mhng-464e74b9-125c-42e3-9384-60c871d22cfd@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-464e74b9-125c-42e3-9384-60c871d22cfd@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv-for-linux-5.6-rc4
X-PR-Tracked-Commit-Id: 8458ca147c204e7db124e8baa8fede219006e80d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5f86891185c408b2241ba9a82ae8622d8386aff
Message-Id: <158265690948.32229.44686078603210503.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Feb 2020 18:55:09 +0000
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 25 Feb 2020 09:37:31 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linux-5.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5f86891185c408b2241ba9a82ae8622d8386aff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
