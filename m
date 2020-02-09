Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A607DC352A4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 20:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D01D21739
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 20:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581280831;
	bh=8/jg/cwuXCSE0sHDqCAtT54ow1FjbsH+4NJWV4mw+Bw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=T5PR36zzyBgFBp4mc6D90DtawE8jW9D9J2etTO709qzHoR5IUiyJwF5jWQuXH73RY
	 LcBoNHTvs+8p5eyQyTLNWg9i2olEXA2U8HXLCionOxol8jUz6IP3lJcXPoygBzR+JG
	 RZhPArw84wgE6pHHz6t59v0ZieIG/OmI1PX75Yrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgBIUka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 15:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:43602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbgBIUk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 15:40:29 -0500
Subject: Re: [GIT pull] interrupt fixes for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581280828;
        bh=8/jg/cwuXCSE0sHDqCAtT54ow1FjbsH+4NJWV4mw+Bw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qLu0q3/9NXDAQmP+C/7RrF5CPbHKEDAaQxCMsahRTTTkh8eQD1JINiQkvKfHyqH5i
         wcWOm1QlEPtZZbYP4upVJRJjK+lOLKUtDVB6miaveoWUIPPVMx97YhyThoU+tYkZNh
         oU7db+YaKea97Ew7jRwU4mmgZSV7N9bPmgMPIdwQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158125695732.26104.12129452415222798177.tglx@nanos.tec.linutronix.de>
References: <158125695731.26104.949647922067525745.tglx@nanos.tec.linutronix.de>
 <158125695732.26104.12129452415222798177.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158125695732.26104.12129452415222798177.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-2020-02-09
X-PR-Tracked-Commit-Id: 2f86e45a7f427d217f4b94603a9f43a14877e2cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f06bed87d7cdfd51793cbb0111799f39ba75cfa3
Message-Id: <158128082859.31187.525540796869166403.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Feb 2020 20:40:28 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 09 Feb 2020 14:02:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-02-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f06bed87d7cdfd51793cbb0111799f39ba75cfa3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
