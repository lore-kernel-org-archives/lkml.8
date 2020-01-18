Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE131C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83BC0246AB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579381507;
	bh=l1xlkXDHT/XwYUUVK0AaTMO5L5F7zn6ynufEoz0zZz0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uQxj9g+hak38oAXfoiY5L84n67FBkNCbyns2RKhQKnTENL6Futz1IZwbszEA6yx0y
	 gGEKd57mFK0Rs7WttgHkmyBfRsy+9kkJySZD1FGSK8a6LI4n5jomG83VIr6kYf4HkI
	 ZSzLJ2A3mlngt+zEoviXQ1QVHOqisrIsxHlk1upg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgARVFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 16:05:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbgARVFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:05:04 -0500
Subject: Re: [GIT PULL] rseq fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579381503;
        bh=l1xlkXDHT/XwYUUVK0AaTMO5L5F7zn6ynufEoz0zZz0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vC/QDVvVO9dVFcQj5OyqeAYKnocEnmw7UYQ0mXw0SsR7VFGXtNIM/BH4kapBo/3Sv
         /Mn+FpEcAPRHyoz3zEEm/hynlOYGDF22KBh/lvq49V6BvDeovuzWcuLO86vAEYBExP
         ZTDOtqIJ2S/7qetfgcWVEwZqiiaQHYDFVFI9rn1A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200118171116.GA7596@gmail.com>
References: <20200118171116.GA7596@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200118171116.GA7596@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-urgent-for-linus
X-PR-Tracked-Commit-Id: 463f550fb47bede3a5d7d5177f363a6c3b45d50b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba0f47220384ff160c9df93dedbbef26d7b67f7b
Message-Id: <157938150386.20598.12029002408910626490.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jan 2020 21:05:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Jan 2020 18:11:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba0f47220384ff160c9df93dedbbef26d7b67f7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
