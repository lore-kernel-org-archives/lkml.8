Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13573C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA03A20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580769333;
	bh=/4rid16jfCwgrNyPfrTnkrlU6xZyx5EXx7reLI1Pzc8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZMM0rPBDJLRfH2x5oZXGteQcmrwki4XGvjqlel0koagcS7pFWwFE8P4Rei9SDdSjK
	 4mPQpRNQE0OVawGezke0Yh6B7FmPP2hZvxb6BCjYNqw9aP7wF4L6aom+FicnW3kkrh
	 O9yc4wLwxqKQriGeJkWPGlP3F9Gi/Rbt4ikjL/cY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgBCWfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:35:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727419AbgBCWfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:35:18 -0500
Subject: Re: [GIT PULL] VFIO updates for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580769317;
        bh=/4rid16jfCwgrNyPfrTnkrlU6xZyx5EXx7reLI1Pzc8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aep98udM8LdvEJKO7LPYraQbg7v1XL8IOwt/JRnwWlj/0cylHbeDakbpqVGhCB+07
         CCb+CFD9Gy6IxNK4AU9j/JmU9eNHl0n8eeFZQbvH2/R69472+NHrcUit0HPt91ViBy
         BPDC/qxpvxOkWFu32qNlkOfbntqFGhQsPnZY1RyM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200203134037.2fda624f@w520.home>
References: <20200203134037.2fda624f@w520.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200203134037.2fda624f@w520.home>
X-PR-Tracked-Remote: git://github.com/awilliam/linux-vfio.git
 tags/vfio-v5.6-rc1
X-PR-Tracked-Commit-Id: 7b5372ba04ca1caabed1470d4ec23001cde2eb91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6d5f9dca42eab3526e2f73aa5b7df2a5fec2c9d
Message-Id: <158076931783.15745.4248247112744305708.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Feb 2020 22:35:17 +0000
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Feb 2020 13:40:37 -0700:

> git://github.com/awilliam/linux-vfio.git tags/vfio-v5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6d5f9dca42eab3526e2f73aa5b7df2a5fec2c9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
