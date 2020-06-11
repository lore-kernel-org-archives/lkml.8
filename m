Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A814C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52ED720853
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591919124;
	bh=4+yQLrkC9GRtpB2X2ZCSWiTLQi+ynS0ENtK5zT/19CI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QxNv9BE3rLdFNwQnJHIUzzYg9zMHM/M/R2rvCpACEPNWpg8ZEPX5XOrQO6/astoiK
	 1J8lxxscDtAn9oA3727/jpV/yNONrT3rH9N4A7sub0KjcCnAtl+PNgI2djvxTwNr5R
	 BrCAqkHf/jwpdLuEm5vCYoN91oyRkYKu0/t3A+Mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgFKXpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgFKXpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:45:22 -0400
Subject: Re: [GIT pull] x86/urgent for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591919122;
        bh=4+yQLrkC9GRtpB2X2ZCSWiTLQi+ynS0ENtK5zT/19CI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=t14Ftoj6bDPuYC9AiZhGNtT0TeQh2e9ovHkMvkJTjDuCaIWI2BCwpoSwdjkiYSNdx
         F1cxcfnBh9C4aCRCA2y92Jsrp+ecaITz34cmbLRxn4WSrMaislc0Gg6T/n5+v86eXT
         8qyovp4tyvz1trWJqM/uF9CVpJqAKvDiCObNfct0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159190118331.28418.15784482710329781943.tglx@nanos.tec.linutronix.de>
References: <159190118210.28418.16838792857524354792.tglx@nanos.tec.linutronix.de>
 <159190118331.28418.15784482710329781943.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159190118331.28418.15784482710329781943.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-2020-06-11
X-PR-Tracked-Commit-Id: 7778d8417b74aded842eeb372961cfc460417fa0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a45a65888393eda692fce0851c40d9f5ce4ef66
Message-Id: <159191912224.19194.18147504760330711000.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 23:45:22 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jun 2020 18:46:23 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-06-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a45a65888393eda692fce0851c40d9f5ce4ef66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
