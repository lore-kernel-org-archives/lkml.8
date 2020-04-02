Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B483C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1A12072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585793105;
	bh=9JjWTMQZTzxCAM732VmpHKueCSqSdGhwvAHvVXu14Ko=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bgdcPiKHUmoXVEQP3oU8HxACUHVJRqFBnZ3orft7Wy7WKrSvG1Fmcia8shI2NX+oU
	 WCAYp4p5QGmxQ5GAKRigsDD/9TTtJN43QFSiOSDDx1WhW5ShsF7Ow8lSDt2pH5c5dG
	 9WWYnNUDPlOx6RXj211eHA+MGCfiniMHLcKcjUNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733305AbgDBCFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 22:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbgDBCFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:05:04 -0400
Subject: Re: [GIT PULL] XArray for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585793103;
        bh=9JjWTMQZTzxCAM732VmpHKueCSqSdGhwvAHvVXu14Ko=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yBoLz3WSUxCRMOdaqvTr0pROExsRHFK3INr9lgdyqIdiO8+A+TTx7TUW5k6FmwRps
         hqENVN2F9nRJ66yQjHTemlXZ6J8jXP1Y573rRyC6kgdPfDgvEqNXnV+qRKeb0qIfar
         yV1nFId9nSzGSi0wQ7DkgIVvbzMLm2e/mIAx2icI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200331141749.GB21484@bombadil.infradead.org>
References: <20200331141749.GB21484@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200331141749.GB21484@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/linux-dax.git
 tags/xarray-5.7
X-PR-Tracked-Commit-Id: 7e934cf5ace1dceeb804f7493fa28bb697ed3c52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 193bc55b6d4e0a7b4ad0216ed9794252bee6436e
Message-Id: <158579310371.873.17070096012445384076.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Apr 2020 02:05:03 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Mar 2020 07:17:49 -0700:

> git://git.infradead.org/users/willy/linux-dax.git tags/xarray-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/193bc55b6d4e0a7b4ad0216ed9794252bee6436e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
