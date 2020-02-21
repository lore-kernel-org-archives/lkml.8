Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB54C35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED69207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582319418;
	bh=tcqUTbXERzLhJ6IJiuGbUnJpSAGeR78e7ZABn9/QIyc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=No9zVdleJ7Jqs/BQFs7CbIyEF8I7qFsj0Ut9R2tBVjcZk/IMyBiHgAp5wqMtyoFTH
	 wfRPTlmNqdwJtjHcDYgAzCGLmmZP0flPcyeJajWs1H3Y8FO2xgsfWBezcEzkRDUqHE
	 xX/SzWz80g3Z21qXp+YPiqNB1v2ySRc1QQu6twsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgBUVKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:10:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgBUVKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:10:17 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582319416;
        bh=tcqUTbXERzLhJ6IJiuGbUnJpSAGeR78e7ZABn9/QIyc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XKc46LBq854BGlqaXgrJpdDVQGd4eSwJd8WbJJL+Dav/dE/GtBCoIa64RxhGH9Kh4
         1WVgN6v5RnYhsCsVEOV/CSQOTqofdkkR23KFmnnSBojet2FS6w2Px0KlYe1Yq0Ax/+
         795am2E/uLJYxSVtEqwteyfFtzYpxpfIN+RFGV7w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200220.165005.109882010805629679.davem@davemloft.net>
References: <20200220.165005.109882010805629679.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200220.165005.109882010805629679.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: 36a44bcdd8df092d76c11bc213e81c5817d4e302
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3dc55dba67231fc22352483f5ca737df96cdc1e6
Message-Id: <158231941648.18249.3932995613583047299.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Feb 2020 21:10:16 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Feb 2020 16:50:05 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3dc55dba67231fc22352483f5ca737df96cdc1e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
