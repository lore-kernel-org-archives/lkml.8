Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F77C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18BE620734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591727730;
	bh=qhY+jtDr7eGsdtq/KDAUivjzemoTiVK0XkiET1MON44=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FAJ4QIJz1Hg3RG+QakQFwXbXVg+z0NFLwlJhvsY7llgfyoyZbESbu/c4EAcK1k1LQ
	 zGx7+K+wGW7XgfG21xTVcfiqOJsdw4SFarGCUR2nUQY31faglXVW7WGDYUZhFREsDB
	 8arL9wtTzw0d5PXo2E3fXd1swZO57TxAG/BOkKIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbgFISf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728589AbgFISfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:35:24 -0400
Subject: Re: [GIT PULL] f2fs for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591727724;
        bh=qhY+jtDr7eGsdtq/KDAUivjzemoTiVK0XkiET1MON44=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dpV8+DRzDqLXNKYku543i6f97gTekyIwRdhghnG1DsfVYLkCHo3NgnG0KcHyLZ6YW
         SMYQ1riEEmwD1yFbmx9jtWYqTdU1G69lmbGSj6cdqv2Vr2Iqw3KeEoZAuC07EhIjts
         VtEN+fwFtMZvfClNOsASynONb54VTgcyPuVUeMEY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200609145544.GA171717@google.com>
References: <20200609145544.GA171717@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200609145544.GA171717@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-5.8
X-PR-Tracked-Commit-Id: b7b911d59dacb47511a1e604bbfa901beb108305
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42612e7763315cf5d43c4422781e75f9ee57597a
Message-Id: <159172772393.12427.4644781740736919074.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jun 2020 18:35:23 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Jun 2020 07:55:44 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42612e7763315cf5d43c4422781e75f9ee57597a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
