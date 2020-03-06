Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0D5C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E94D206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583534706;
	bh=yX6aPpHu7Ib0+yyhoAJCyIMSrKCwvDxeGj4jBZ4m5co=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jigtYolBnGnsdJ9NoVl6HYFzeCG2/8cbrDsaoukqvrIt9Dl85aFu9svi0YIn/McxT
	 pFdEgWaTShyXz0pRgmY3i+2v650g+lfRZoDFoIboTo6uTXDYM1VXNbh2QvO3LWQGVI
	 /hdn929kGDhg0X7JTkJXiUcon0+hgEBc5yvH0W+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCFWpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgCFWpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:45:05 -0500
Subject: Re: [GIT PULL] RISC-V Fixes for 5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583534704;
        bh=yX6aPpHu7Ib0+yyhoAJCyIMSrKCwvDxeGj4jBZ4m5co=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A/NfKyIDaH1GvuqGly+CRxQNg9P5Z6PSoqp1xsPHogX7kkyQ84vl0iJOLam7XaDB2
         o0ZPjR0ZiLHXzikX+iQuxuYS74uxl825Ygs4VSKTaYmwcYSN4rSxsTGV9yb8lY70D2
         BeIY/35XeyPi5MizzBv9L58rKqCb0F77iIS8t+V8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-ceb3e2ad-8656-4228-b1c3-b90731c84c5f@palmerdabbelt-glaptop1>
References: <mhng-ceb3e2ad-8656-4228-b1c3-b90731c84c5f@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-ceb3e2ad-8656-4228-b1c3-b90731c84c5f@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv-for-linus-5.6-rc5
X-PR-Tracked-Commit-Id: af33d2433b03d63ed31fcfda842f46676a5e1afc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e6582ef32f6cbd55b9c752727847b0ee6710e78
Message-Id: <158353470481.2424.9286208999466559244.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Mar 2020 22:45:04 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 06 Mar 2020 14:24:17 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e6582ef32f6cbd55b9c752727847b0ee6710e78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
