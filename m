Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95BCC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EEEB20707
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593273622;
	bh=vgGeqMJX4pazWmgXo79pEFvTNFsCBZcMP2uwkVjBk9Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=i8cTUTcvSe1IbhMU4heVdSYQHMIGGBbw8OfZeve0bpykbUiSCOg1qefIQLMfjBl0i
	 rDQaKkd6eBkRBDs+u5rZcAZFJcM5QgNeTX72zxXybWLVySRyNQLryO0/5DEEKweCW5
	 FGeAOwKV2rIZ9QwrtxXmstUAaFCQRzzGfeU5gdjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgF0QAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 12:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgF0QAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 12:00:13 -0400
Subject: Re: [GIT PULL] arm64 fixes for -rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593273612;
        bh=vgGeqMJX4pazWmgXo79pEFvTNFsCBZcMP2uwkVjBk9Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mMxMN3yfZ1PUzFlgB05I2WaUQx+Iu8KLObil0G8MKHvxMcDH0URktt0BruNSMSc6h
         Jvcyy9et4cY1KtTSS17eXz+6L3tIM+mwf8htfYXidJp4XkKn3Al4NbZGOeFOE8Tc9R
         62yjLRqAlY/elImxdBd/0JAqDp8XAPc5XWrwqN2E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200626132131.GA9750@willie-the-truck>
References: <20200626132131.GA9750@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200626132131.GA9750@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 108447fd0d1a34b0929cd26dc637c917a734ebab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8530684fd37c151bbcf6c101ea3d0d784e221d98
Message-Id: <159327361263.7015.5382660920716001107.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jun 2020 16:00:12 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Jun 2020 14:21:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8530684fd37c151bbcf6c101ea3d0d784e221d98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
