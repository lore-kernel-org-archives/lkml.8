Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57C6C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 19:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921ED206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 19:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598903316;
	bh=6SO0WhFv8d3dges8UxuzZfesxBf668c22bemLqTAnBY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yBHEUApYND1tMosU1z+gOGuzLQ2vv1R1+n8AnrzlUG7oK3n98TSlaF5ARlN+gbXP/
	 W6/BEFS42gxsIJg2VY18wFg2H99STUqIS3+TTIEMCIq+IuugcUXAUZg23+kUAXxKA1
	 igX2AazHQm8wxVB82YMpUcdWFl7CQZtfgnv47wbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgHaTsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 15:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbgHaTse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 15:48:34 -0400
Subject: Re: [GIT PULL] Documentation fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598903314;
        bh=6SO0WhFv8d3dges8UxuzZfesxBf668c22bemLqTAnBY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lwHGMWyAUbKUWabNApjm+X7vLPWYD49BiFpvvRcvPKMcA5uq8GzWipHI8u/au49hS
         7Ok9eZ5S9TlQQhWVphNY6YDo7F0kgE3LqdkJ+KcNfxLUHgrC5MPk8PYwLgMc+qZJBN
         z5PYs8tOTuVUkQaU5SZ8egB1DkmGZcrBfbPqTuzQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200831131014.34bd1367@lwn.net>
References: <20200831131014.34bd1367@lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200831131014.34bd1367@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.9-3
X-PR-Tracked-Commit-Id: 92001bc0365a144783f8f3108be94e74baf61011
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b51594df17d0ce80b9f9f35394a1f42d7ac94472
Message-Id: <159890331409.18220.3177817506467642099.pr-tracker-bot@kernel.org>
Date:   Mon, 31 Aug 2020 19:48:34 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 31 Aug 2020 13:10:14 -0600:

> git://git.lwn.net/linux.git tags/docs-5.9-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b51594df17d0ce80b9f9f35394a1f42d7ac94472

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
