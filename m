Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104AEC35E15
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC2024691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582832409;
	bh=idAxPa86Gz+QeTk13W4mDJFkQ9s3BnevHefPgThc3C8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=UA39Rvk3NLIiHLF+bxl8802gd3SfL96sXHgjr5UEdBYyaYISywt89OARpMiLPJc+L
	 mfOFUlbyUu110j8Uid4pdB3ge6ex7Y3VCnuwu93JhHzHggmuRPn33Jw9p3bARIUqqb
	 84CIwlxOCHjMVucmKvrxmaBqDoPBhMAzNzBtfwF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbgB0TkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:40:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729953AbgB0TkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:40:08 -0500
Subject: Re: [GIT PULL] Audit fixes for v5.6 (#1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582832408;
        bh=idAxPa86Gz+QeTk13W4mDJFkQ9s3BnevHefPgThc3C8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OxB2uHlfullJOVIfpajYuk54QJ3ExT27sOKB8DIO5QiCRMnEznz9kGl37WRWUuXXX
         5c7njMUhl6EL4qBTl9VQ87HQ6I0DQrPAtaHbWUXWvyCxItV0o5m8RuqBOolbBqd+k0
         1XVHqOgUbYXQ8RVpxI0n/UGomoVUrlpXzf2lNieI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhSL2M4QBP-_z9U-MMNUAT9G_pnJxrPcNtQs03yi7epYxQ@mail.gmail.com>
References: <CAHC9VhSL2M4QBP-_z9U-MMNUAT9G_pnJxrPcNtQs03yi7epYxQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhSL2M4QBP-_z9U-MMNUAT9G_pnJxrPcNtQs03yi7epYxQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
 tags/audit-pr-20200226
X-PR-Tracked-Commit-Id: 756125289285f6e55a03861bf4b6257aa3d19a93
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed5fa5591866f95be1fe75cd267cf9df2c0390f5
Message-Id: <158283240799.25748.3429930730028694695.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Feb 2020 19:40:07 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Feb 2020 20:50:44 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20200226

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed5fa5591866f95be1fe75cd267cf9df2c0390f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
