Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF04DC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FF22467E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579116906;
	bh=x8zMsOZ3vRMinFyXUjMiuqkWXsImZr3asPp/IT/gEcM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QbDPNMocgb7EkgqMI9v9alBjl08rbQ9Qw8KxlEVmKHxPQSA5wPx93QeFQ+tSAwCsG
	 olw/aZrB3o4RKSUBk/529uTdx5Nb40omxnwbxYhcHUNkvNmb5Z4/9diNe5veW3pio+
	 kOkewzyWgcjH6xEf5ZMpddTW8vwiV67eCfS250aQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgAOTfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:35:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgAOTfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:35:03 -0500
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.5-3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579116903;
        bh=x8zMsOZ3vRMinFyXUjMiuqkWXsImZr3asPp/IT/gEcM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EOOxc3UXyr1Q+pfIxUJk7YnMBfgM9OLdZeLiP5Xbx35mE5oHWbTFZ+ggw1HJVdJsr
         DVJqLzWkjzbRRC5QH3qJojIh2lqT4e9veUvaRgi7QyCp1Ulb91kyL0OjF/REhVN8E4
         8Z80YalDU853YehCx7JDy2qSc/CMPQ+KknB6BX/w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200115105720.GA14489@smile.fi.intel.com>
References: <20200115105720.GA14489@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200115105720.GA14489@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.5-3
X-PR-Tracked-Commit-Id: f3efc406d67e6236b513c4302133b0c9be74fd99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51d69817519f5f00041a1a039277f0367d76c82c
Message-Id: <157911690329.18389.15362375081659105672.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Jan 2020 19:35:03 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 Jan 2020 12:57:20 +0200:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.5-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51d69817519f5f00041a1a039277f0367d76c82c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
