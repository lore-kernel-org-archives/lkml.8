Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807D2C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C22206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589746519;
	bh=fCxCn12M87UFjDxVDV9rqXy2y/vhO87qv7lzuRVDnvs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=T4WGg8y0Icfc//s9pR0lFVamcwr8iDPVLJ8igNjynGF3YpxL1o27ZPDWzxLFh2W5G
	 dHhBlih4YF70UL3dq0vvShDAiUlhGI9XAk4Wpc0CSauGeineexFoRoTXzbSr0HMKLn
	 mWLdyWqwWezBSmY8p8AS+udaaQKtrekm6YgPYKwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgEQUPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 16:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgEQUPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 16:15:03 -0400
Subject: Re: [GIT pull] objtool/urgent for v5.7-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589746503;
        bh=fCxCn12M87UFjDxVDV9rqXy2y/vhO87qv7lzuRVDnvs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RYxAL7kIRj4V+KAgapIQ+L+9TVJQl835MFWZF9h5R5UXOQ4s1YCTJU9+J8mfnnel3
         Ei/Y8nme1wTzj2KvhpOrBsvxMO4YBw4fNsmyATWV8uftZ9vJqZQLsLx6/+fdeUS2Cr
         BJGsmIcO4zf7uivBAkdOmp9tTDQ1euotvlbC9xMs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158970986085.17297.6965424675815657314.tglx@nanos.tec.linutronix.de>
References: <158970986085.17297.6965424675815657314.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158970986085.17297.6965424675815657314.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 objtool-urgent-2020-05-17
X-PR-Tracked-Commit-Id: 71c95825289f585014fe9741b051d32a7a916680
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef0d5b9102c4614c45e04ede10d04e572a165ca8
Message-Id: <158974650344.31612.1606316090483168039.pr-tracker-bot@kernel.org>
Date:   Sun, 17 May 2020 20:15:03 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 May 2020 10:04:20 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2020-05-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef0d5b9102c4614c45e04ede10d04e572a165ca8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
