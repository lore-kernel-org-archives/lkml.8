Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378F7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 20:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D7C20776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 20:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592598331;
	bh=uepZdKa5cp484Qg/f3jhM0AzuR6lednDku2df0Txgj8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SIGBBgZ/mQs+o/EMoXFxFbZHhiWvLDNdn86fr/YDhTL54GKLDk/2u/JfSJ/4jS1hZ
	 eCAykrMa3hJKVvxSlQ6LeTYN12Im+PPRJ/YBT8kv05yfmfstRgtO0qKBfvwGJqFj5D
	 JUTRFI640G1j8Rb6rBWqCeJk1+pDL4kHGqFFpDIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389210AbgFSUZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 16:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388746AbgFSUZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 16:25:25 -0400
Subject: Re: [GIT PULL] libata fixes for 5.8-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592598324;
        bh=uepZdKa5cp484Qg/f3jhM0AzuR6lednDku2df0Txgj8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c+6Xj/BvuJvsKYRryxZKGCKTZd0KZwqfmDl6CrQ0Tgog/f2pe0oO4RT/SfCMLrTN/
         cIpaP++n8sbnO6jITCco9KlF5sNLrtY2REYNsfLaKRM51bGT39JqOVDWxwzylBW6D2
         7YL6nY81VbV1QVbVg4M7Ro3voiqcsoo3KTof8WWw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c7fcf452-15af-4085-528a-7bc52110e21c@kernel.dk>
References: <c7fcf452-15af-4085-528a-7bc52110e21c@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c7fcf452-15af-4085-528a-7bc52110e21c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/libata-5.8-2020-06-19
X-PR-Tracked-Commit-Id: b5292111de9bb70cba3489075970889765302136
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 592be758f196ed4610e326fc3f33dadd80aa7c6b
Message-Id: <159259832486.1498.2069153986501086158.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Jun 2020 20:25:24 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Jun 2020 08:51:56 -0600:

> git://git.kernel.dk/linux-block.git tags/libata-5.8-2020-06-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/592be758f196ed4610e326fc3f33dadd80aa7c6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
