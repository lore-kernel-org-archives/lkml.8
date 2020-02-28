Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259CBC3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB79E2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582851009;
	bh=qVDH0oTYSSaAhTwApWiGQfGpunzVUaAViEyLZbMoFA8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Kb728knITMSlx2DjnWDT/9DzLZVkRIZtWjx566WvukD/+8Rcpx+hXDx5NK2/IOMfu
	 HfkLQVkYflCjHkgrTj4Mw+ndZku/cAP2N7CHy1qJUpE6AvBkj1lavVfYVdgKM8h7Ai
	 398GTlQhLz56svxurJjdLrHJe6A8HK0pp/WZxxXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbgB1AuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:50:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbgB1AuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:50:07 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582851007;
        bh=qVDH0oTYSSaAhTwApWiGQfGpunzVUaAViEyLZbMoFA8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EA90lQvuFqia5wIMqdYaDuMETYBEL9Em8sugl/xRTr0b27xiMR63nw+O+MHZqZv4b
         tCkGrG4cUszOge1M4Uz2wT4CQ7jgeRjiW7dyzd/b+1ZanT5dHHtHdkmHT3lJAAzVYj
         uYiAtVaVioEQ6lXvppkIF2RiI5wl0aYnjPVX/p7k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200227.141220.1878875210756855090.davem@davemloft.net>
References: <20200227.141220.1878875210756855090.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200227.141220.1878875210756855090.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: 3ee339eb28959629db33aaa2b8cde4c63c6289eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7058b837899fc978c9f8a033fa29ab07360a85c8
Message-Id: <158285100699.4310.8834147667462962687.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Feb 2020 00:50:06 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Feb 2020 14:12:20 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7058b837899fc978c9f8a033fa29ab07360a85c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
