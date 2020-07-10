Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B49DC433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE4A2078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594400123;
	bh=mAA3/ZBpex/kNKkUh0yoZh5GkI0zJQevobe/c/a6Fa8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dQikaMf48FLxKBMfB9a9rcrCsS13igQOXZ/KkqIJSt989AAHJ9F49u6/VQY+2w1gn
	 GsI6z4tLSapIjtLPX3sEwjw7JB6M8u2MoyLmWw0wKb5cGXoIGSxqGcY851VPtCK4gr
	 L7H6gyr4vSVkqENqzVYn4Y4dxsXjalFZDWMndHh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgGJQzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728449AbgGJQzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:55:07 -0400
Subject: Re: [GIT PULL] dma-mapping fixes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594400107;
        bh=mAA3/ZBpex/kNKkUh0yoZh5GkI0zJQevobe/c/a6Fa8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wS3tWl/JsQrt6FEbjdidM/c9it1ewDCY00nkXtZ9UlcaeJVkDN4iv3ODGxOCFPFbG
         bgmZpklFNhpvFfhoh6P8blC8dUV1Y3HdWUU3kEzYp7rtUcBki3dUMdII/O3USUWIFp
         Yvlf07hoH/x0nqcLJ5KLhlNicOnPjP7X95WDflnk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200710154506.GA540305@infradead.org>
References: <20200710154506.GA540305@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200710154506.GA540305@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.8-5
X-PR-Tracked-Commit-Id: 68d237056e007c88031d80900cdba0945121a287
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bfde037425d91d1d615d30ec362f5f5c1ca0dd2
Message-Id: <159440010718.18761.15336646128679822312.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jul 2020 16:55:07 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jul 2020 17:45:06 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bfde037425d91d1d615d30ec362f5f5c1ca0dd2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
