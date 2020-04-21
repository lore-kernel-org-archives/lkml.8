Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129C1C55182
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8987206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587498022;
	bh=dhpbCkrLy7p5CAz05wbgfDX4RpRhkt6f9Kq1JAYI4vA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mQM0PvQk923eZyaY4psWJokgkEOW5mNuH8IazHdsyfGb0p/hsQl2DcNPc5Fya19dg
	 SEQ4znrzGyQR/RRbJEN5ZbVi3bF5xRRLzaxsvoLnQyg1oglHHJO92IhHTLw3MSpWAw
	 FpM6UqpcSffRQ6Cc47CMv7b/rSzE9OQjwEo3Jw8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgDUTkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgDUTkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:40:20 -0400
Subject: Re: [GIT PULL] clang-format for v5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587498020;
        bh=dhpbCkrLy7p5CAz05wbgfDX4RpRhkt6f9Kq1JAYI4vA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gVPo6iq26J/jcloFwBYzfOEb5ThvafgR2hKAKczhArhJZre3cuzBWNNHd50C5YP10
         5512huLVEOgMmN9FD0E0Q2R+osbeSUOkPJOQKbhmTlfeq/EoJgcqso7wQdQjaT82HU
         JBT7s20rTseEw84Cf4lPYmFqb2UCxS6GZJNFugys=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200420190916.GA11695@gmail.com>
References: <20200420190916.GA11695@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200420190916.GA11695@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/clang-format-for-linus-v5.7-rc3
X-PR-Tracked-Commit-Id: 5d65a0218fee471e2cd512a8139ec857183b4721
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20f16489093e90640a6a698d636f654a792806bd
Message-Id: <158749802033.25518.734411973050561323.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Apr 2020 19:40:20 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Rogers <irogers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Apr 2020 21:09:16 +0200:

> https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20f16489093e90640a6a698d636f654a792806bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
