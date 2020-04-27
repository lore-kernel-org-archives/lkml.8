Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09221C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E36572074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588020014;
	bh=B0hN0n8GkneH/qkwyKBzV1WTKTN0Pabt+Zh7tOPbKz0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=K+M1jufkBwTcZv+1V4XeQ5sSbwTk8bfnGhpB91QKx45f75wbHYjwOoQCw9maNKczc
	 +wxabpksAAcOASmNLffd+kDMe2peMMS6qFnNFRjSfYtVtMrDrxJvawFfPK/CnnKM8B
	 wKM5PxoOsjndL3OSJCkf/wuItW8PN/4hNH1PGj6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgD0UkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgD0UkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:40:13 -0400
Subject: Re: [GIT PULL] Hyper-V commits for 5.7-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588020013;
        bh=B0hN0n8GkneH/qkwyKBzV1WTKTN0Pabt+Zh7tOPbKz0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eynlAXd0FuUwfTKUDEMtjw0/xiSBWC94LmygKXxkzpCXRjyFVmKOjpm6kfGtZHqx1
         CxEmbNeMt23qYbKJXVbadVb4VlKwW7YCaOoWbbmwqeh77U90o5GKW8QeCMabWoRYPY
         oAwLI9C+loySJzDd+Qnzj6UHmyjAFcIt9z79SwGE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200427111945.6qdvgimt3nt3ja57@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
References: <20200427111945.6qdvgimt3nt3ja57@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200427111945.6qdvgimt3nt3ja57@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 tags/hyperv-fixes-signed
X-PR-Tracked-Commit-Id: f081bbb3fd03f949bcdc5aed95a827d7c65e0f30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 869997be0e3d4b994aa04bfdf3e534b9072e6a17
Message-Id: <158802001352.5189.16562695064067550738.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Apr 2020 20:40:13 +0000
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Apr 2020 11:19:45 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/869997be0e3d4b994aa04bfdf3e534b9072e6a17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
