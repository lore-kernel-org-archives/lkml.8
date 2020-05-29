Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E983C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406A52054F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590786637;
	bh=orDOWC2BVpeZ4nZ6Yepnspx90aNENEtwYDlwxAFc9us=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=c2FiV21fXC32A8+UNhLvipTV74DF5M7lZR+p0tsf6k5aJMpM4p/12B7MhhL2SxCNb
	 fQhsbXuvyyyMI5+XMMIsxaP+rIrreJVKkzCWsmDurLe5tE3WTWOJB1OnS9N/ENtVvr
	 j1c2iHWXIddO+Fo33+OWnQQNadAyXggUXCiNydaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgE2VKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728342AbgE2VKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:10:05 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590786605;
        bh=orDOWC2BVpeZ4nZ6Yepnspx90aNENEtwYDlwxAFc9us=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1G9zYOn9BvbTtRc1RXqwLqawtE4/YDWPBCmgwompqHf+ceE4ApZGn4+3Tg1gtkH6p
         sYeK1JxT+sgKOGN9ZMnMnsTbFcat9Var2lnpWA3UekOU0q5VrknogdmmBWrhYJyEGS
         xrzJ8Hg31mmuyC7tA2+prXbuO8zX7PAVmpvaHIps=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200529141556.GA30959@ziepe.ca>
References: <20200529141556.GA30959@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200529141556.GA30959@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 1acba6a817852d4aa7916d5c4f2c82f702ee9224
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ff64d2537f5b445177c30a2fc7779a6f2107ed5
Message-Id: <159078660542.32003.15109552735930997169.pr-tracker-bot@kernel.org>
Date:   Fri, 29 May 2020 21:10:05 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 May 2020 11:15:56 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ff64d2537f5b445177c30a2fc7779a6f2107ed5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
