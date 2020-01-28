Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757E5C32771
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3345E24684
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580175306;
	bh=QGne8XVkdzV6RKMFqEbWs4LjX/hLD7k79uLzc+SRPhI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sN0inepEZKFDfr73S12zUImKn/043AbXNSryaC6ih9py2fV71s9DiQSKOOfo9h3Iv
	 EjialXC9utLgjVus2hxr2vfMID6LAO9ccmdJG2cxJlJ+jplTnIsNpfD3wJtM8UVYc+
	 CJQKK3FfwsjJpYZKPJPFVziMocnaNvu3HEFGhOGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgA1BfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 20:35:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:54304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbgA1BfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:35:05 -0500
Subject: Re: [GIT pull] timers/urgent for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580175304;
        bh=QGne8XVkdzV6RKMFqEbWs4LjX/hLD7k79uLzc+SRPhI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=spuA45+RTaMi0aElcDicG2hv0XsbfKXZ1f2l3nGBJE1JmmR2mYOtIdhltDtL3WXRE
         pQ96y/oy/zj/KOGpzXqMNRt34v/55kJ5b0M50JFuxMuDjyh4+4VA+6wOruXbDECBqd
         XVd0R7LHcVTDuThxsB/9wyKS/6LBN5Jl403geCtM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158016896587.31887.9884737771559149853.tglx@nanos.tec.linutronix.de>
References: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de>
 <158016896587.31887.9884737771559149853.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158016896587.31887.9884737771559149853.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-2020-01-27
X-PR-Tracked-Commit-Id: 9f24c540f7f8eb3a981528da9a9a636a5bdf5987
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a56c41e5d766871231828046f477611d6ee7d2db
Message-Id: <158017530468.6677.15697489123493381920.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 01:35:04 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 23:49:25 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-01-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a56c41e5d766871231828046f477611d6ee7d2db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
