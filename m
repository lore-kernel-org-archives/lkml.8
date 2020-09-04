Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C07C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596F520C09
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599252564;
	bh=SIfc1uNYsl6tBrXLIpUfABHahFvQ+9wFZu+gj8HKn+A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jJMmChnGZgCRIbyfklB5ytLqnZgVzP4xgTS9Q+xmFLcha4ywsusiCOBm+BJ/yhzZB
	 Vruo1ozIJWiJ42YuHS4+TgDioBBldUAlW/hdfqUcz/fhtWZUNqOFy5gJRQX1DEUbEV
	 ZTZWOSVEvdWDlroO/VAT/Ua9701EQbkNR3zW+anc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgIDUtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:32784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbgIDUtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:49:12 -0400
Subject: Re: [GIT PULL] MIPS fixes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599252551;
        bh=SIfc1uNYsl6tBrXLIpUfABHahFvQ+9wFZu+gj8HKn+A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=q03qR5SU16D5E4B2Lvw5l/+rci49Jv3rlBgsP/Yqs+YIp+5X0VMzYkv+LkLCU+jv5
         AVDwjamFWB8r440ySSoK14FtCKZAKir1sUh6JO9WTLG2aV8w1CtU4EOCTKF8ObJG0w
         DcWG3EtWrPL6NB1Rcih94WCXNeS9UmEW0VRym1Zk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200904123223.GA18627@alpha.franken.de>
References: <20200904123223.GA18627@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-mips.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200904123223.GA18627@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_fixes_5.9_1
X-PR-Tracked-Commit-Id: baf5cb30fbd1c22f6aa03c081794c2ee0f5be4da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16bf121b2ddebd4421bd73098eaae1500dd40389
Message-Id: <159925255166.25529.15903512805615647378.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Sep 2020 20:49:11 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Sep 2020 14:32:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_fixes_5.9_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16bf121b2ddebd4421bd73098eaae1500dd40389

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
