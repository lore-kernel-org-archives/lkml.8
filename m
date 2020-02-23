Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3467C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 17:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB47920836
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582480218;
	bh=SflshuwIeGKsfRvAgspCjuFtPZtqq3/PoDLKco82kFI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=MXU+sA4qZXlmQCpUt4Xmo2TGX2lZpKZR5pE46NAkMu2G+DkV+0vPSS/47gBgMhvbR
	 rrfGWe+8l1scYc480hViubjp+dOW63//v8iDZn4tpY8pCoZOOApphUyixBPn6kfo8N
	 ociNwRr41tkrNg13L8DnHE+DUuew1lktXyDfgWTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgBWRuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 12:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbgBWRuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 12:50:13 -0500
Subject: Re: [GIT PULL] csky updates for 5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582480213;
        bh=SflshuwIeGKsfRvAgspCjuFtPZtqq3/PoDLKco82kFI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A+q+qAXNZfJBH2vwNlFI3gsGabtt0FuhvdY04n6XwiB/kYbIZmnhSlGI8a/ecXm8z
         8En6sFADiFgUQ37Rl8vq+B/avcvt8u5rxixo9XCzqcjPcQnNXwD78WqVWImhXFt4qb
         odh5zF1av1BVUAXJs/zdWJKxYT1ayLr7HG3hMdFM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200223162332.16495-1-guoren@kernel.org>
References: <20200223162332.16495-1-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200223162332.16495-1-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git
 tags/csky-for-linus-5.6-rc3
X-PR-Tracked-Commit-Id: 99db590b083fa2bc60adfcb5c839a62db4ef1d79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6188dff33fba320826e87e387ae6efffab0525d
Message-Id: <158248021325.10261.12221204167090455190.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Feb 2020 17:50:13 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Feb 2020 00:23:32 +0800:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6188dff33fba320826e87e387ae6efffab0525d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
