Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E422C2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A0E2077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585780534;
	bh=VZV3D+gMpVWU+yvRGORxE0gOzY23IMBcs54jrGXfU2k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vly8s7HRfOoUBl+F1kzhl+K2BchUnnpAZX4vZqXSRFHKrTcWAVLFmzd1X7HTbKUfa
	 hQ8Ljr5AhbxAPUSY+Bln4TeG53+LTW+trv6Vn1D/2A89ExcriZgxSukmI1NRZzz90M
	 D8j4Kwz/eBAoE+xIw6u4W0+S1v0uqRrA9ZsfAKvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733306AbgDAWfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:35:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733235AbgDAWfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:35:19 -0400
Subject: Re: [GIT PULL] trivial tree revival
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585780519;
        bh=VZV3D+gMpVWU+yvRGORxE0gOzY23IMBcs54jrGXfU2k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AKvpd+WRR8iEomU1VriQPRFKEt4zleT88Ia9A9S/2tj3PwU2e2wQ2b8lmR4BQGc0F
         B2YQenW2nOhj4D5xfJhLRDm7XiWUbCfXxkbudK+q/OrYEzxkxaZLrYh8yDlW8wyBCz
         lrfsBncfTtNUaDQU1PawMzr87+7N0QDTIe65GNeU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2004011221220.19500@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2004011221220.19500@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2004011221220.19500@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git for-linus
X-PR-Tracked-Commit-Id: fad7c9020948eab2bc4661eade4e1ef357279590
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69c1fd97266bcdcfdba1e3ea57773c80e0551e1a
Message-Id: <158578051939.24680.13386569440976844087.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Apr 2020 22:35:19 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Apr 2020 14:11:12 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69c1fd97266bcdcfdba1e3ea57773c80e0551e1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
