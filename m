Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C30AC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1076D2253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579807806;
	bh=nnKfFFOtKn+z9h+7nGWyLYPUBDcBcY4YEokYGfYQxHU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rzWOwWJ2o6G4gBaCJxfon2881ELJRVwssC2DNBDwwbQK/2fAw2TRfEpBc7w4CHZdk
	 ZKVGvjD8vDj+QMMDgk6Bx0S3mxngNjJHTj1jcHNsW7NU4UHfzM42bhtj53e/XQn6Eg
	 6/A/nz+3k9mkYR9fLaI4hWyNRe0/cbUyzP9u+PA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAWTaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:39532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbgAWTaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:30:04 -0500
Subject: Re: [GIT PULL] PCI fixes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579807803;
        bh=nnKfFFOtKn+z9h+7nGWyLYPUBDcBcY4YEokYGfYQxHU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OBdwWlgn9JBP72UuSZ1fk9AfaW+W6thsuIf4paZg1uD2lCOIaG79AnZgGerBHm4bd
         sMnXmiBA8zkGQOaxrQoJSXkVPewiTXM9SxwyiC26SK13sD+FCQTT4gu0ZddHXxert3
         CBqLLwTInD1JgL88ZCVkGFeo/SrDoZN03qj3lVnA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200123143129.GA101517@google.com>
References: <20200123143129.GA101517@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200123143129.GA101517@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 pci-v5.5-fixes-2
X-PR-Tracked-Commit-Id: 5e89cd303e3a4505752952259b9f1ba036632544
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a572582b1a4d6c8418739abfdfa5d1796d148d35
Message-Id: <157980780375.24133.9920696009867814747.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Jan 2020 19:30:03 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Jan 2020 08:31:29 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v5.5-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a572582b1a4d6c8418739abfdfa5d1796d148d35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
