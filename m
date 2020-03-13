Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44836C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 22:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3CA2074E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 22:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584138605;
	bh=6zRL0TF0RqgoGfTSHH8qfW6ipbZTJLyacgQE1pre3Cg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=L8TqdJR/FGAg67nT4WEnmDgAeztKuR0B+w6wwhAmv7RMbRg5za+g1naOPDhMdeg3B
	 Q+4RyWoffydRQqDO0C3xMhJilnytzVd/ym2tEX5fkUj1cQLlK0jpBjgqzQcWzTxsh3
	 F59JVA4+D8RpU2pbrE2wuo8lcxbj8wFbkyfxMC1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgCMWaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 18:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgCMWaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 18:30:03 -0400
Subject: Re: [GIT PULL] Please pull NFS Client fixes for 5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584138602;
        bh=6zRL0TF0RqgoGfTSHH8qfW6ipbZTJLyacgQE1pre3Cg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QeGvrYD0fm3tg5Zrv5okiclEzi5mhzkKif7jP9fxEuHhxGebnc6q3oQ5lZTWK8Ix3
         JDaPYVi+IYjZq0k9cEbXHTN7WFxt6vS/gC2VNtEUdS/yeV2raYN7wE34AWN8DlRNsS
         qllIz+NnRw4kgOWUy4M40uwUOzB9g7/kjvctuGuM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <301a18ca0151b97f54ff6f67b4d32afed696459b.camel@netapp.com>
References: <301a18ca0151b97f54ff6f67b4d32afed696459b.camel@netapp.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <301a18ca0151b97f54ff6f67b4d32afed696459b.camel@netapp.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git
 tags/nfs-for-5.6-3
X-PR-Tracked-Commit-Id: 55dee1bc0d72877b99805e42e0205087e98b9edd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0ea262a2347eac8522de5eef24ccd7a90dad7d4
Message-Id: <158413860286.20505.4405435485408845987.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Mar 2020 22:30:02 +0000
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Mar 2020 21:23:52 +0000:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.6-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0ea262a2347eac8522de5eef24ccd7a90dad7d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
