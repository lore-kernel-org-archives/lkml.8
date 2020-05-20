Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B31C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33AC4207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590006610;
	bh=Pdgeve/9LRehUhDrVXdRjNVJLuNXHZmV9BvB1nGEGM0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qK+PaHliuFyC2hr+AhuxSIewEAGZ/s9RBf6gqy6d8EHo93Jx3LKo4KKj//zzeG1oE
	 z3sc5Sg2Zwo5j3ZAoiTe1PTekrmHvi8htnev6BL3t+Kzk5CwZxQ8+wcVP/Rc6KzRcm
	 0i46c8J7sR9gcncVGbrVDukE6bdHA4LsC/qtRV6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgETUaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbgETUaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:30:03 -0400
Subject: Re: [GIT PULL] UML fixes for 5.7 final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590006603;
        bh=Pdgeve/9LRehUhDrVXdRjNVJLuNXHZmV9BvB1nGEGM0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OUOP8yCrhBZ6BmTcGEFUG1YRCTJ8r2+415qdvX/Eu+2QNHvn1CrwMtLGmo/grbglQ
         auY6Q2vLNWEb1iYPWuRWySaHoHxbcOPGZOCedvtByUfNogr6vqZYDVoDDcxIyuw3pB
         ixcIy9XK4zjyrHrQul3yaK13IuCrCbNY3CGTJaK8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1547930539.249342.1590004176796.JavaMail.zimbra@nod.at>
References: <1547930539.249342.1590004176796.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1547930539.249342.1590004176796.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
 tags/for-linus-5.7-rc6
X-PR-Tracked-Commit-Id: 2e27d33d22afa3d12746f854d6a4fad7ad7b86de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d303402c288340f9094fa0ba697600335a41bc3e
Message-Id: <159000660310.10849.13116492422203668761.pr-tracker-bot@kernel.org>
Date:   Wed, 20 May 2020 20:30:03 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 20 May 2020 21:49:36 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d303402c288340f9094fa0ba697600335a41bc3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
