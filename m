Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE43C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 18:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691A320706
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 18:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598207966;
	bh=cSRIocoNGg/xAOPkHH6pMcAXpUqZK5gdg4SzJSzKwbY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BJ2VIH99vdnUmTroK71MJsPzWzDHDqYFRoOBHaWm8hjPWtuIldM9mr0StkPg4D6o9
	 HczS5hRVIMLX3bUg9mZ3ksrYbLGxCUlHPKvPWClVCCqgX4NEvw7WQWwc1vF0Pc3Lix
	 oUBJW/jLe69VK0mZVGD5Z0PahMQK+BdNp9GMIlBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgHWSjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 14:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgHWSjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 14:39:23 -0400
Subject: Re: [GIT pull] x86/urgent for v5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598207962;
        bh=cSRIocoNGg/xAOPkHH6pMcAXpUqZK5gdg4SzJSzKwbY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=O97r/2BYpETRI5FhH8GnzLQTFoGOJdc3irBJai2iCaEos4M8ilb2e2AKQXrZAc6xX
         HSeyVqfRgHK1VKtmvJM3iekhEO1DY2AXXVozav3T41FVfwpYTGMm6fYXURSsk2w5Wr
         YE9lnu6ID1jy8JN7lwuy5sawtuyzOdyqFDDeftzY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159817113762.5783.6214320432160748743.tglx@nanos>
References: <159817113401.5783.14776307451257171431.tglx@nanos> <159817113762.5783.6214320432160748743.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159817113762.5783.6214320432160748743.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-08-23
X-PR-Tracked-Commit-Id: 6a3ea3e68b8a8a26c4aaac03432ed92269c9a14e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 550c2129d93d5eb198835ac83c05ef672e8c491c
Message-Id: <159820796273.12134.6641441425761379085.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Aug 2020 18:39:22 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Aug 2020 08:25:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-08-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/550c2129d93d5eb198835ac83c05ef672e8c491c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
