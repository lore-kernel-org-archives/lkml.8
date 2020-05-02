Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3132C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7EBB21775
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588380010;
	bh=uWVeHEUWTorW7k7eWgGvrUyQdGDDO4lDzZww5SnaWQo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=e7KFtXVIJGFdA8Mohr+vHl71RR4awIWIchh5g93pvDnEGOnUvIrY5NHLe3ksY57V+
	 TDBiGDB7EDkNgF6A05IPmhja/NIv9gBr9O2b8x03VFig6x0u+om037T/x0DILKxQV0
	 uD2JOoRVmGOP+FuOKR9MU1VChUAn00R4d+4muCsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgEBAkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 20:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbgEBAkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 20:40:07 -0400
Subject: Re: [GIT PULL] io_uring fixes for 5.7-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588380007;
        bh=uWVeHEUWTorW7k7eWgGvrUyQdGDDO4lDzZww5SnaWQo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WxOYUCJBL35ggyxi+5VoF9FfXPnrIp/7EJugHspgML1Dwwkq3vmkw2kUCBIDODZml
         tzBCkFH8BQ3Zhdx7NvwU+Tja2qj2LMWV99VojoXKXqIJDlIpuytViDxriydSRemsKw
         xNLkZG2L0DFq7698ZW83EsV0CJCkxPoiBdxEPigQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8bd7dea4-76f7-cb50-7658-3a3d50539edf@kernel.dk>
References: <8bd7dea4-76f7-cb50-7658-3a3d50539edf@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8bd7dea4-76f7-cb50-7658-3a3d50539edf@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/io_uring-5.7-2020-05-01
X-PR-Tracked-Commit-Id: 2fb3e82284fca40afbde5351907f0a5b3be717f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf0185308c41a307a4e7b37b6690d30735fa16a6
Message-Id: <158838000752.10067.12250828016379101099.pr-tracker-bot@kernel.org>
Date:   Sat, 02 May 2020 00:40:07 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 May 2020 16:52:38 -0600:

> git://git.kernel.dk/linux-block.git tags/io_uring-5.7-2020-05-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf0185308c41a307a4e7b37b6690d30735fa16a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
