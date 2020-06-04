Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16178C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D977D207F9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591231205;
	bh=mR/6t41xHDwuWo4akouNtVq9KIPhkz/TTN3BcZHyqM8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bTt31EWO6ra0G0Ri8fnJpSH02uua32rmPD2Vg3OzN21hjvmCWhoo5S4wg4ffqB1Jd
	 88KDeWDy+LOn2HTDgc9vETILrllvy+r/lSphKLnOil81rYIKT/Rl0EC4qFaUs16He+
	 +sgfGV9NoZB9kN2vyedBp2if5SKaqRpSOkIDuH8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgFDAkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 20:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgFDAkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 20:40:02 -0400
Subject: Re: [git pull] vfs.git work.splice
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591231202;
        bh=mR/6t41xHDwuWo4akouNtVq9KIPhkz/TTN3BcZHyqM8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Q5SpiSUXAiieN1UCrIJLSpl2943/eAuqJLvG9Hi8aYzzjlY9c+Pcv3qJMCOm0vAo+
         BTPY+ArL0bqitJvadby/RiWPLznt4z/bnLGTT2aOEvYwnGgAEUIeltrqQkk6SI3QRC
         DlSh5LPXuW7iE9Dq1XFIyr6DX0fbCisrWbZx6wbc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200603192615.GY23230@ZenIV.linux.org.uk>
References: <20200603192615.GY23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200603192615.GY23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.splice
X-PR-Tracked-Commit-Id: c928f642c29a5ffb02e16f2430b42b876dde69de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae03c53d005ef8a1e0253ad67b7b62103ea1fae6
Message-Id: <159123120205.4554.14301966296868802715.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 00:40:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Jun 2020 20:26:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.splice

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae03c53d005ef8a1e0253ad67b7b62103ea1fae6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
