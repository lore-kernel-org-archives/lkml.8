Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4FFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 23:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4069824686
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 23:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580512220;
	bh=nWNwif//+fYkxXQl+cK5p6lw6DUwuYVfOs+5Q5P4I10=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sA6oNoqNDPUdy2x/svGWu0Rw0A6GxpRlvsof9+XuA1vBnKuE5QwVNJMfIWpSNPC4z
	 lQU88A3ilcvh3VIseYjAtaIJOj7TLczWzkmLUuaB7Q425Vk73qWXB2PvTtiTDsgeP8
	 8gmvWr5I6azm3sQBKTuNvF+wiSCvIwWX29eqszbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgAaXKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 18:10:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:46464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbgAaXKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 18:10:18 -0500
Subject: Re: [GIT PULL] thermal fixes for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580512217;
        bh=nWNwif//+fYkxXQl+cK5p6lw6DUwuYVfOs+5Q5P4I10=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Acj+dgJWZrPY3lkrkQpLJxTw3OPw3PlaxlKgKbCmiyWBzffjce1dZr7DZ33WE4RYc
         CTwO2HouK04rDRsf5KypDd63+e4fFCRaA6dd7VbVr50RxtJzvGP9T/V8tzJ4mjsTU3
         YdXVTVCPKlqgMTGH6y5iICg1OsmchRdmf2uzmhbM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bd902239-1fb0-d85a-f3ec-1c8fc2b7adf9@linaro.org>
References: <bd902239-1fb0-d85a-f3ec-1c8fc2b7adf9@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bd902239-1fb0-d85a-f3ec-1c8fc2b7adf9@linaro.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
 tags/thermal-v5.6-rc1-2
X-PR-Tracked-Commit-Id: 8c173d5e044d7e7fc9f6070c0fc1c79c0f8256a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68b62e5d965a8cbcfa287ee7754cf06e9b3775ab
Message-Id: <158051221764.10603.6888514277984982800.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Jan 2020 23:10:17 +0000
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Jan 2020 11:46:07 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git tags/thermal-v5.6-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68b62e5d965a8cbcfa287ee7754cf06e9b3775ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
