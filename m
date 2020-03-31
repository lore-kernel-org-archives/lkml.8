Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA74FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 03:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E4420732
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 03:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585623628;
	bh=zOq98AYi17B3VePW2utp0lwqb7SIwioMph2CLSRPSWI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=V+6G/9bgEpa7EZVbKbDcNIbup128qlYBJzGCEbXFyK1nrD1W3Go1hmnbzhztPYC7+
	 drrLKNln8u2InDJFmifYO7uICqA4BBdg/3+zYHJ9eM0f1h3hRsaOcZZSFSaP5zOe/Q
	 +QFcudqenTYt/7bM3Wl3w2hgr9QbB7noqCHIH8xQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbgCaDAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 23:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729779AbgCaDAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 23:00:12 -0400
Subject: Re: [GIT pull] smp/core for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585623612;
        bh=zOq98AYi17B3VePW2utp0lwqb7SIwioMph2CLSRPSWI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jGe9p5gpV4HjAYUArmnLYmBk7u65DEsk+gc9V5go0qSMuac6Bfpqwr2pY9IYGzRxV
         pIremACE78K41iLCjtB2kaPh3tthsfLJX/zn9PJq5Urtn3Jq1RwBit4gEZvrVepanR
         j+ssptVcC19JJT9ptiJBN0LlWHdu0VJOwpovZfGg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158557963075.22376.606316234727225860.tglx@nanos.tec.linutronix.de>
References: <158557962955.22376.9136086165862170511.tglx@nanos.tec.linutronix.de>
 <158557963075.22376.606316234727225860.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158557963075.22376.606316234727225860.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2020-03-30
X-PR-Tracked-Commit-Id: e98eac6ff1b45e4e73f2e6031b37c256ccb5d36b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 992a1a3b45b5c0b6e69ecc2a3f32b0d02da28d58
Message-Id: <158562361233.8590.9065105577354631700.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 03:00:12 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 14:47:10 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2020-03-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/992a1a3b45b5c0b6e69ecc2a3f32b0d02da28d58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
