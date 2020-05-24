Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B16EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 546652088E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590341405;
	bh=aedBL0ISfiVahDqONAd2mtulcxWdM7naFwSp3bIDIjg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mbfTrIgFR0yiDyoGo5hZeLNSY/WWHYh5wdd9hN6hrXIqZVXrumio4e+MXuUuFyJeF
	 qhQFZXCpBj8CMORkB7ozjajP/6T9LCbzUi776z9x6l1RW3IHGa+W7goXesbSzGElEc
	 MljCq/ClOo43FmSbsmRiNry2GMvFFjy3FF4YOOZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbgEXRaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 13:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387453AbgEXRaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 13:30:04 -0400
Subject: Re: [GIT pull] efi/urgent for v5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590341403;
        bh=aedBL0ISfiVahDqONAd2mtulcxWdM7naFwSp3bIDIjg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qgssqePJNmedtC3NDnJBv2pQ/OV/nDpx/svQ19XDU96RG/Ls3xB3USs1bbmDnawhM
         7OOhrX7POEfZTrlYcaEhO+685y8DUQBmWrE3KdPMXLUF/ic1BlPRz552JbZqnxmd+V
         ekUl7hqRD0SOgMXE0i3AEtHR5zEbk+XAvJxs720M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159033288117.21635.13199705716119914103.tglx@nanos.tec.linutronix.de>
References: <159033288117.21635.13199705716119914103.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159033288117.21635.13199705716119914103.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 efi-urgent-2020-05-24
X-PR-Tracked-Commit-Id: 9bb4cbf4862dfa139f73e12912129e5b76baea1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98790bbac4db1697212ce9462ec35ca09c4a2810
Message-Id: <159034140369.27315.7955376652102422351.pr-tracker-bot@kernel.org>
Date:   Sun, 24 May 2020 17:30:03 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 May 2020 15:08:01 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2020-05-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98790bbac4db1697212ce9462ec35ca09c4a2810

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
