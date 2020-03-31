Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CC6C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82416208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585691424;
	bh=rtGn8E8oQarlwtVz6cL8gDWeXdNhNHLxd4uP40i1cuA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=d1mK4rr9P7c6eLwoHYmkEjkrgw2pPMsaKpLY4X4HzLcu/IqLyTBU4RWUBYyeaQrZs
	 bgFuf4VZEq6ASfwuuvMYtvQY8xaFogoJC2M/GsZF9a3wOLKfoSYpALBG2Zwg0BGm7t
	 pW4gcvDtQ6MDEtv9c0B4yvasrPg3+iwbLhBoGGNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbgCaVuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731709AbgCaVuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:50:12 -0400
Subject: Re: [GIT PULL] CIFS/SMB3 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585691411;
        bh=rtGn8E8oQarlwtVz6cL8gDWeXdNhNHLxd4uP40i1cuA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DAxLx3GdwTC975ENNB3fwSmtJ5r4JHtiSm7AMSirViDE6mRvoVBPiDnQu6DfiKzl6
         q3i/qLbASnYUPthdfzrv8hzIgvqueMER0qh00vH1rUtX0kMQGYinflw+O/fHKH6pAh
         NA+TKbiu3EwC9Wxz8sZ7SQWd+qtddHYcdhQGY59c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mud02mFz6HKUZwfWnQ6ZwdRWPgrjeemXG1Zhvas7zjeQQ@mail.gmail.com>
References: <CAH2r5mud02mFz6HKUZwfWnQ6ZwdRWPgrjeemXG1Zhvas7zjeQQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mud02mFz6HKUZwfWnQ6ZwdRWPgrjeemXG1Zhvas7zjeQQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.7-rc-smb3-fixes-part1
X-PR-Tracked-Commit-Id: f460c502747305258ccc8a028adfa55e2c9d2435
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 645c248d6fc4350562766fefd8ba1d7defe4b5e7
Message-Id: <158569141191.7220.15368326172777529761.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 21:50:11 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Mar 2020 14:14:12 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.7-rc-smb3-fixes-part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/645c248d6fc4350562766fefd8ba1d7defe4b5e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
