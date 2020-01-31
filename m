Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4C8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 20:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7E4206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 20:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580501115;
	bh=KesAKAcsZ1VwpuMvCZ1E07I3z4KoXgI09eGHQ2msyRw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ALkS26W5+RlrPRvyYGpa75oHZOcFcUHdrAJ1NZMg0vRtHmQVnKUHpm/HQ9dFg7JA4
	 4Lefy3sbaIMWrQ1BSirp+JQK+KOr5gEWUTrFwnQad4+mM6j63Hv0R+4ofTHgQROFnp
	 RAkk1Nesdx6xtFfsTVTl04mNKsSVF8oAlWV4wEUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgAaUFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:05:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbgAaUFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 15:05:14 -0500
Subject: Re: [GIT PULL] Modules updates for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580501113;
        bh=KesAKAcsZ1VwpuMvCZ1E07I3z4KoXgI09eGHQ2msyRw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bMiccVZF+0lBAh5VNaBtPg7icbnlf7izN6rYlfTChBXnBBBLscLiwWYBj7j59E4MU
         xOzMBbP8IN1EBxUioD+m7grE8UEHz/35nZ4fPvJJBeJyAnMMEEOLtRqZjiei7tTzHh
         Et6cd1QUdQbvon2444Wwq7PR5Var0uHT93+HFxEw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200131172319.GA16783@linux-8ccs>
References: <20200131172319.GA16783@linux-8ccs>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200131172319.GA16783@linux-8ccs>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git
 tags/modules-for-v5.6
X-PR-Tracked-Commit-Id: 6080d608eeff7cb5090a2ddbaf723bfb0ff133fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddaefe8947b48b638f726cf89730ecc1000ebcc3
Message-Id: <158050111376.11349.17356570730316749692.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Jan 2020 20:05:13 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Jan 2020 18:23:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddaefe8947b48b638f726cf89730ecc1000ebcc3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
