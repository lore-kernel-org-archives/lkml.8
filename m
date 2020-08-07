Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FBDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE3B22D6D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596832752;
	bh=1VHZSqAWlZLtu/BBdBjCrEt1VZ5FboQSI/Ler2EwEBk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JM8eTIw2KCIfizn2bYQbgBTBHEBdrKIBXzqsfbh3w42npZtvl5cCDHDMOO9J+Y44A
	 5l+rTT2XlpoQwk1M4Ye8b661y9MIMh2itsUonA73NwTEoR13k5aSF2HpECnoP4Twsh
	 mPJyxkTbukwBEbxRRPV4c010Deuj+CKV6Y5J5Ucw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHGUjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:39:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:32818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgHGUjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:39:08 -0400
Subject: Re: [GIT PULL] More power management updates for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596832747;
        bh=1VHZSqAWlZLtu/BBdBjCrEt1VZ5FboQSI/Ler2EwEBk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ooy3mpso73ZWmRYbIuqXplCgQrP5wLPJwVPv/3Tug9eM8LUSA5j7h/RhYtD1Am9CP
         5N5Rv9LKC7CfgIG8culjv0bVGDy1QnCsQZQ5pFRLbHt8lVW6Wkzn+tLeevtinH4L7W
         WearcLrRKK9OYuxCVbTOx+5dpQFt1LTdJHYwscpw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hQS_aVFJpqJ2uPxpomKpyb3iM0fVUTg5oP-5AG=qwGsA@mail.gmail.com>
References: <CAJZ5v0hQS_aVFJpqJ2uPxpomKpyb3iM0fVUTg5oP-5AG=qwGsA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hQS_aVFJpqJ2uPxpomKpyb3iM0fVUTg5oP-5AG=qwGsA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc1-2
X-PR-Tracked-Commit-Id: 0873ad923a05751a29a92229739ce2737c29d348
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6235eb189706bf38c82b5fa5f2db0d21bc1dcef
Message-Id: <159683274791.2860.16180338487662777631.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 20:39:07 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Aug 2020 20:06:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6235eb189706bf38c82b5fa5f2db0d21bc1dcef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
