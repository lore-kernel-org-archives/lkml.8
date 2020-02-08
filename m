Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D733EC2BA83
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 02:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A517721741
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 02:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581127519;
	bh=J6ZWZbSBwtDUFTHslHrT7XWXW7I4vix4YnnOAcVR1as=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hXXvnxhGNovS6kMnGOoGufCtj2Jx0MO9Uj58fgY6k4IUY79vSWFh8T8GQ5qkS6GC4
	 rgyVdwEOfSbsJ7Dd6MYC9YVX4Xf48UbZHH4Re/5EWshg1fkecR0CIhwxcpw3VrcuOR
	 QQAsrLNiUx5HguDKJMt0jRyWTGxQ9FuHuanCBg+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgBHCFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 21:05:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbgBHCFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 21:05:18 -0500
Subject: Re: [GIT PULL] GFS2 changes for the 5.6 merge window (2)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581127518;
        bh=J6ZWZbSBwtDUFTHslHrT7XWXW7I4vix4YnnOAcVR1as=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R3s0LC8KvJB4BKWY6D3upiZg9abn7TQu0WGHJBn4gjw3+3MalRSClfs3QNzcrsTy1
         7Xx2kgQ4LhW5PFTEcZSyf9acsY3AE2ne3mUR/lLPnNLb96HjJKfXecRDHGCyIo+HAD
         ScqiA8/e9t3M1D5pgU0HHE2BH3agKyFzvVrBWtiM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200207115039.48920-1-agruenba@redhat.com>
References: <20200207115039.48920-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200207115039.48920-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
 tags/gfs2-for-5.6-2
X-PR-Tracked-Commit-Id: 6e5e41e2dc4e4413296d5a4af54ac92d7cd52317
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 175787e011cec507d8e2a1dbf37beef418499bc0
Message-Id: <158112751799.31333.8449716542912433599.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Feb 2020 02:05:17 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  7 Feb 2020 12:50:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/175787e011cec507d8e2a1dbf37beef418499bc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
