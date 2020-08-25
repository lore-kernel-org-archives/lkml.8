Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F970C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D2E2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598382995;
	bh=SZWJRi05rOY1sUbfWFfI75smVjftRmFLtpHNqqXUUII=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ubccRxggf2cx9PEVY05mY0Vt/9r+Acth2Oe8lF3WfquvJfqy79nB1QdyKknvO4FKX
	 dnlyyb3JXzVriDBj+MZy5SUsW4IR7bWiOQxR2QSn0vqLq2QjnLlE2SDXWTOX6JLNLI
	 FafgVaaa/+yTYukew3RSEGyqwU1g8IEoHLxMAtlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgHYTQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:16:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgHYTQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:16:22 -0400
Subject: Re: [GIT PULL] HID fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598382981;
        bh=SZWJRi05rOY1sUbfWFfI75smVjftRmFLtpHNqqXUUII=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hsO+YKMAS+/30qfTJ6jd9xhBqFJRgkaiiGAl3ZC7pc0K5xSJ3PCpzaf7bVeSTom6/
         5r4XfWT6HV12CktSUqncILVCPYbXUTbwUj2xxDcTj2apEExJg0qQMq7YJtaYWiMi4b
         cVAJhNutDZPqG+V0+np7yoCXfvOVHicQ5GymSSF8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2008251003480.27422@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2008251003480.27422@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2008251003480.27422@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 5b0545dc184442fa509a311b8c855370441ad5bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9aa527ae38ba0ee998ced376b040fc92b0a2c03
Message-Id: <159838298167.30843.11960269909407594984.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Aug 2020 19:16:21 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 25 Aug 2020 10:14:56 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9aa527ae38ba0ee998ced376b040fc92b0a2c03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
