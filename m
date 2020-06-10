Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DF8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D4E020760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591826727;
	bh=MBO3sTv7I04mLe+2LEWIK4ZB6nYptWo11BRIJ8Ii+W8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JoJ6W0eZLdbNfv9715gplxLCgwi5KpZZ8Iwv76GGe6danTWSuYPzChXaSNVBsJFqL
	 68vBwlMyxTWhtinen8z1kkyXkK9mg7gYuJkwU4dRV40u+4LCTU+2S4lBM852WUGUrr
	 z6+9fuTf8gQEczElc2euKZaMSNAcybAqaM4OS3jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgFJWF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgFJWFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:05:23 -0400
Subject: Re: [GIT PULL] proc fixes for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591826723;
        bh=MBO3sTv7I04mLe+2LEWIK4ZB6nYptWo11BRIJ8Ii+W8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KYWBRWOe53M1jIYdbFoIHiKyDn37OqN7uXFYFaw/PuQCn2dCUumTEFTYcUwVpG1Dv
         PV34IGKuY7a1kf6RbBCqG9whCiYp8M1pE/0EoBZJRg2hQF8CnKXvNaYLo3sP/4LZsD
         VYPhwUiycMflOCwPxbcgViTK4/exmCmNSI1BgpM8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87zh9atx0x.fsf@x220.int.ebiederm.org>
References: <875zc8kxyg.fsf@x220.int.ebiederm.org>
 <87zh9atx0x.fsf@x220.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87zh9atx0x.fsf@x220.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 proc-linus
X-PR-Tracked-Commit-Id: 058f2e4da79b23afb56ce3d03d907d6cdd36f2b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79ca035d2d941839f55f3b8b69f8e81c66946ed8
Message-Id: <159182672349.28998.15675618292711945180.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Jun 2020 22:05:23 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Jun 2020 16:45:50 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git proc-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79ca035d2d941839f55f3b8b69f8e81c66946ed8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
