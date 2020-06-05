Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB01DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC550207D0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591391734;
	bh=KsA5/eoO5bcA2oE6HJOuUDNy5txaV/ZnJBGEp3uGcK8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qx0K+BATufnvhCu4UbcBEdeJJ8/JDA26k2uXFJTc+qVVsTH2jovWQ2vYi8Kfs683D
	 Vb0WllLMrhB3vlOhOKKp0UGSyrj633V+iEl0aPgj73qCMbKVyBpaN8YUKEOHFUnbed
	 Z7pqqNn+4HCmkioMKdhrauSGMg6B+COW43S43q3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgFEVPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728533AbgFEVPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:15:16 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591391716;
        bh=KsA5/eoO5bcA2oE6HJOuUDNy5txaV/ZnJBGEp3uGcK8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eY43VEk0m8ZGH1PRELRqwlm9pfYgXissAD96oNb6HMaY97Hzs22xlaIvK2C11ZnRu
         ItO4oofKFTgVCWbemcmDvaKP3oxrNubE+bGjG/0lw9D6M5XwcxDAxPiXzYWgssWhnG
         ZXJkRIJlFhjDWZxHoq0/AHgPz/Y0cCv2o0Ju8iGE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200604195131.GA362249@ziepe.ca>
References: <20200604195131.GA362249@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200604195131.GA362249@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: fba97dc7fc76b2c9a909fa0b3786d30a9899f5cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 242b23319809e05170b3cc0d44d3b4bd202bb073
Message-Id: <159139171609.26946.18224052473915997990.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Jun 2020 21:15:16 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Jun 2020 16:51:31 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/242b23319809e05170b3cc0d44d3b4bd202bb073

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
