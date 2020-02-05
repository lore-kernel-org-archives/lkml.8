Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B6DC352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9735222C2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580926824;
	bh=1OrTS4gc4rEk4g/Lnwx8DD/LALQQL4uGkE13NP2mrbI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YT6TFQ06SylsQLTxdBMMcNBnD+HQOea1H3BTXSC/WuQ0uvbcKtDopc2IzNWx8IJTf
	 hc0OmnlvdMDTH4Nm6KI5KGtx1bxl5vyUFksowGnqBs3sdKQ9StqnlvU3VSOc5LCs0v
	 svcUfkd3wJEeOzuvc58sV7kmWMhgk/Fu1r2MToGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgBESUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 13:20:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbgBESUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:20:20 -0500
Subject: Re: [GIT PULL] s390 patches for the 5.6 merge window #2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580926820;
        bh=1OrTS4gc4rEk4g/Lnwx8DD/LALQQL4uGkE13NP2mrbI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VxBaCqT7nqRI7QQu81p/AWmMu30glkIqOFbpNDb2pCCJ8ROA4ASTxgO266Nzxj4MA
         n3TEJq7d/Xyw1IJ1HAyIUyRu12yrZMHwvExH50xz0kulphK3+DK4Nxy1zC/s2QeZPE
         ZsJ9iR1YQrAHKdQt7rRKYLGPgPgokbYuN3AHv7rk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01580919095-ext-5211@work.hours>
References: <your-ad-here.call-01580919095-ext-5211@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01580919095-ext-5211@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
 tags/s390-5.6-2
X-PR-Tracked-Commit-Id: 55d0a513a0e202c68af2c8f4b1e923a345227bbb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cfb4b571e8b56b65d1a893bda5153647fda823b9
Message-Id: <158092682023.14135.2426258977315830878.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Feb 2020 18:20:20 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Feb 2020 17:11:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux tags/s390-5.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cfb4b571e8b56b65d1a893bda5153647fda823b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
