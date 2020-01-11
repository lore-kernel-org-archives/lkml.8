Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93C6C33CA7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 23:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FC72087F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 23:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578786605;
	bh=2HUMJJssHUU296MPTkQi4Y/r+PClSLkFwz9ElNmEE6o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1jAX/sYoFL95/uS2Ga44YgC4mqY75zNsIL4i1L33fMVnYqfP6ynUys+ETOdDm8yMf
	 yKdLQlONNuQVjX60UnUEztvhLYDHW2VPP4qtyAZlg+HiMmTy5i3K4oyibor+d/j79z
	 DlFUNFuts0+Et5G7a25KTLfzOhsgyNMqNY9sT7DA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbgAKXuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 18:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731718AbgAKXuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 18:50:04 -0500
Subject: Re: [GIT PULL] thread fixes v5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578786603;
        bh=2HUMJJssHUU296MPTkQi4Y/r+PClSLkFwz9ElNmEE6o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qx4s3y73vqnVMRYEVhq4XlSwxV/aZT6LtIoZcfHziLykMpU25mOri/3b1hxc8N2r+
         tRP9SoTCScizTRCEFXGY22Vqr5UVWlhTTD7yieJkGQiSG+BxukMP3udFUSTSF+deZx
         zgN+HNK+hk56oCFgxS4QY+7nfuPdMedGN6qJUo90=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200111182330.27309-1-christian.brauner@ubuntu.com>
References: <20200111182330.27309-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200111182330.27309-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/clone3-tls-v5.5-rc6
X-PR-Tracked-Commit-Id: 457677c70c7672a4586b0b8abc396cc1ecdd376d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 606e9ad20094f6d500166881d301f31a51bc8aa7
Message-Id: <157878660369.3074.18007303733434529451.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jan 2020 23:50:03 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Jan 2020 19:23:30 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/clone3-tls-v5.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/606e9ad20094f6d500166881d301f31a51bc8aa7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
