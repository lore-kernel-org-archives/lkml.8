Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28A8C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 20:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C1C206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 20:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583612707;
	bh=LqZikUIGjrG49YBGy3wYSV0PklxJB5J09FO9REe4fZM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RZ/4kyXej8QHaImOiXnmVETMwMwarkdcPIDokonKH2yf4z9pNjMTkDjVpJv+v5hhx
	 PCBRLLXo8WLOMrm3gW9sZyMzxqx0vMlVh1DTAXlbnaKmVfunkm9yrmaKYw3ES6m3E2
	 dwtHhWk7KzJadTqQTTLGEpG2myYn5b6VcSvcwfqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgCGUZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 15:25:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgCGUZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 15:25:05 -0500
Subject: Re: [GIT PULL] io_uring fixes for 5.6-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583612704;
        bh=LqZikUIGjrG49YBGy3wYSV0PklxJB5J09FO9REe4fZM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pTYVIOKrcklVcbJrqYpx0BCvWD5U/4d5UKmYPIThhZO7e8yZHKDNtZaehADDDEFkc
         xVuDb3qVYEhaF1tuovvBWqjjX4Y2e7KbzsUQpe4FGvhh+pGPJKfI1t+TXMkmk+whc4
         ug02imbUgdfJGxcPWXeVrvPF9sApcfNsHf2Q3eF0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b8c32cfe-9bf8-ee8c-a91b-565583a44a8c@kernel.dk>
References: <b8c32cfe-9bf8-ee8c-a91b-565583a44a8c@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b8c32cfe-9bf8-ee8c-a91b-565583a44a8c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/io_uring-5.6-2020-03-07
X-PR-Tracked-Commit-Id: f0e20b8943509d81200cef5e30af2adfddba0f5c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c20037652700024cffeb6b0f74306ce9b391248f
Message-Id: <158361270490.17903.10576399726265115993.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Mar 2020 20:25:04 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 7 Mar 2020 12:16:34 -0700:

> git://git.kernel.dk/linux-block.git tags/io_uring-5.6-2020-03-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c20037652700024cffeb6b0f74306ce9b391248f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
