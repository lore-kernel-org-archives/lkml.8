Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2DCC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B42120735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584465010;
	bh=bQ9j+1npsGP99V+F8AyxF960sN4PxW88RmLWe1QEUpc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=O/A3AU1CnuHDg3L5xNDzNjMsCETxAmreUnPcMsxnykJBdbRgo4NEgFt+a+ctbmdBp
	 daFPQKlgIbfXawsVeFw2m80t+NGfudmsnMbcMfhr9BzodWPBKmzKZliffUj0QBAxrW
	 RkzOpGpqNR/TJbwH7oFfi4YXGKsLjfoOytQgXPNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCQRKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgCQRKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:10:08 -0400
Subject: Re: [GIT PULL] HID fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584465008;
        bh=bQ9j+1npsGP99V+F8AyxF960sN4PxW88RmLWe1QEUpc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y4Fa6gg89FvbvQCZrmgm7FelpvrEELMH2BjqjoA25w1DwTmMCpU9XKBa7CL830aJI
         s8Se4Ax+u7jsJqZjRv+HMHRhsNOByKNlD4lkuvKM4tBhH1Zg613DFJTLWMb6DTHEqK
         LNb6Y8OUdsUXtuJbpZjLT0kNNbaD6G4OUlfLNpgY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2003171439360.19500@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2003171439360.19500@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2003171439360.19500@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 819d578d51d0ce73f06e35d69395ef55cd683a74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac309e7744bee222df6de0122facaf2d9706fa70
Message-Id: <158446500820.27956.3144421128587109776.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Mar 2020 17:10:08 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Mar 2020 14:41:37 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac309e7744bee222df6de0122facaf2d9706fa70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
