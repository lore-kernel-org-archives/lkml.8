Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C303C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 17:35:23 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E281920708
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 17:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsgK5G6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E281920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgDLRfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 13:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgDLRfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 13:35:06 -0400
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A35C00860E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 10:25:28 -0700 (PDT)
Subject: Re: [GIT pull] sched/urgent for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586712328;
        bh=Uma686ZUjWyMwGOvGj7a8j7II6eIqCNfA/snAaiDSpk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CsgK5G6oQcMwl4NSMD/CYba7Fp+m/tNzwX9IJxxL3EIl5a6oC3oEABhY9tj70ddMh
         /ulNGKG8SAd7gJTGBDlMti1+c7bA3iVVqvnN8iVEc8lc3et4XrQ++MkgRWZcL5YIvB
         /2ZBqmnjubBqUTHjjkZ1lWlMk+60Z7xE9a1qkH1U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158670112018.20085.16323984475817000231.tglx@nanos.tec.linutronix.de>
References: <158670111777.20085.1305752188791047060.tglx@nanos.tec.linutronix.de>
 <158670112018.20085.16323984475817000231.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158670112018.20085.16323984475817000231.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-2020-04-12
X-PR-Tracked-Commit-Id: 96e74ebf8d594496f3dda5f8e26af6b4e161e4e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 590680d139b9a3aec46ae17553235f4522d23bd4
Message-Id: <158671232824.12917.7552806818825155642.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Apr 2020 17:25:28 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Apr 2020 14:18:40 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-04-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/590680d139b9a3aec46ae17553235f4522d23bd4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
