Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61C9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 01:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CDE222CAE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 01:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596590710;
	bh=pTx8QAijhdXMCnbVwCpe/ylLEA9pCZAzdKTJXOc+gIo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vxvRxyLMK8/xALb/hDk+7DzMn4g6oyoHTTKkU9SqwE7ONqt1QdbI+Qia0UajI0MJs
	 yYgiRGzYvUiKdHFYUoxvwnjmgQ3worNpxnw/DvTc01m7IxEOEXE9my2RKOlYwUBevd
	 +L6yctJFYvo0Bv4e+oBfdbT3sjakEWiva7ImwYzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgHEBZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgHEBZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 21:25:09 -0400
Subject: Re: [GIT pull] timers/core for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596590708;
        bh=pTx8QAijhdXMCnbVwCpe/ylLEA9pCZAzdKTJXOc+gIo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=L+EveNZRj1QmwpejbDtmRyttuqaJPO46JucQJjvECFZ78UDzch4Nnpg0pNdnmOPmp
         6IIP9frmTOOSsBrz+2pZ9cfWYvOK+7UbgP40qtXePdMRtNPev3OnSJHBWWAzlAFzEX
         TSvcmycQHhf0Evgk0AxR0qpqaSGCAt0ZlYbLgV34=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159652931581.11821.16979537775204894252.tglx@nanos.tec.linutronix.de>
References: <159652931338.11821.6870342948950391828.tglx@nanos.tec.linutronix.de>
 <159652931581.11821.16979537775204894252.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159652931581.11821.16979537775204894252.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-core-2020-08-04
X-PR-Tracked-Commit-Id: 31cd0e119d50cf27ebe214d1a8f7ca36692f13a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 442489c219235991de86d0277b5d859ede6d8792
Message-Id: <159659070876.20322.2603491838272621854.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 01:25:08 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 04 Aug 2020 08:21:55 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2020-08-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/442489c219235991de86d0277b5d859ede6d8792

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
