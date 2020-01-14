Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66872C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6792072B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579026306;
	bh=3dIXxEZ5TE6lzPhnFvYruQUU1Yp9xwpcyFtEXIjwllc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KGs5YlJ5tXgelkz1gf178uyLrakKVtwTu0twTGsljrmewA+WdB2BO2ZW8xkYQScYs
	 TnXw7d8OhbTHIf33p/DSZpIejKKNegM4rWCUrqaHgEmWjUOjjc1QWcIMm8Gz5jQhBc
	 nq6ZSeRJ0U2u+7kEVjFEm7SABhcsFnQVFs97IfQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgANSZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:25:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:36414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANSZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:25:03 -0500
Subject: Re: [GIT PULL] SCSI fixes for 5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579026302;
        bh=3dIXxEZ5TE6lzPhnFvYruQUU1Yp9xwpcyFtEXIjwllc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=P0EU9CF5WSWJIcqlUWcPeVfqDfam/0AtLQys1oyy1EYgVkvqp/QjJWTvKWdJdTkUz
         n/L7renMsGlSPjeQ7pqY2WFWGhlTVqvF1xo7GdknRKp9pC2ieCG01rnSeZtxVZ8ANB
         wijl02+1l/zFcfvh99ki0hirQ9Et6e4fdXqik0Ys=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1579018551.3390.13.camel@HansenPartnership.com>
References: <1579018551.3390.13.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1579018551.3390.13.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 529244bd1afc102ab164429d338d310d5d65e60d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c21ed4d9a636500e66642221d3880c3f9569964f
Message-Id: <157902630285.24051.1512701725885838577.pr-tracker-bot@kernel.org>
Date:   Tue, 14 Jan 2020 18:25:02 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 14 Jan 2020 08:15:51 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c21ed4d9a636500e66642221d3880c3f9569964f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
