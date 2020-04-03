Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42C1C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7969721556
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585874425;
	bh=YaFclORjuPZW1dxJ3qN14gsQr29KJIcmOljdhCM2wvI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PMlRsdrzcUmfE6tWDNoNlDZafJdYpUQDHXrW4YBPmSLMNo7sa6SodE88DlX6T+5QU
	 7ridgzbjUBgYhV3bEcnyakJFyXsXv8aOW/P1RRF0KWIZ6eOLKL/s5RZRJdofoeK+U5
	 9wUy/kirk7nj8585fegxgCacFMvh0tW900y93Wac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390479AbgDCAkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 20:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390460AbgDCAkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 20:40:22 -0400
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.6+ merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585874422;
        bh=YaFclORjuPZW1dxJ3qN14gsQr29KJIcmOljdhCM2wvI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IFgwl1rGl16z3FsJynrTtPHKHZuthqw+Mvt2qOVHMiMG5iieuewi8z1R5GljORISZ
         V7CDMNsbkl8UDyD8ILpuT3RtLiZECGIOqpvkXG98XJK7HdbNV6ZBsEHMERLg1gJERr
         iaUqHyrno4ZIPvLRol5Th55XtUrv7GXt2bpjJoI4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1585843596.9534.17.camel@HansenPartnership.com>
References: <1585843596.9534.17.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1585843596.9534.17.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: ff275db92c935858454b721f0d960fff421634d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79f51b7b9c4719303f758ae8406c4e5997ed6aa3
Message-Id: <158587442215.31624.18315350369310388562.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Apr 2020 00:40:22 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 02 Apr 2020 09:06:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79f51b7b9c4719303f758ae8406c4e5997ed6aa3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
