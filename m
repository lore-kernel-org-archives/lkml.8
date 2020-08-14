Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BDFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 20:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9440220771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 20:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597437755;
	bh=ld1CD1D5bCWqOEzLyWc1OFNEOsxo4WZetS/hMlqUvNk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jkuYgX4vOsLTQDHZeSZryjNyjdWE8qgC1Fg4lmlGYC8cMrnR61ntp86vXLP94OeVP
	 KAIDyuE616yhTq+NDRbyHUQE/zhJWBvF652qYF7h7tWF7M0KfRj9TFOlppuKlQdVng
	 mcchCbFEYw5rTpSTtlX4pEs/B0uX8/1wksbIknDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgHNUme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:42:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgHNUmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 16:42:31 -0400
Subject: Re: [GIT PULL] xen: branch for v5.9-rc1b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597437751;
        bh=ld1CD1D5bCWqOEzLyWc1OFNEOsxo4WZetS/hMlqUvNk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=No5HZncuyM2OEwhwqc7/GW7HZ+0ksxI20rj0dqJ9o1fJztFrxGyyVZ12McMTIiSFk
         1ZN813nBjEBa/CBwW3VUJkukeXmbSAq/EqkLi7iD0xYVknky80+uPwnj/NinXH7FWC
         vNWoL/ua13Ld3hS3GQd/tiCoy3KFVhngO8adduaI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200814133939.21185-1-jgross@suse.com>
References: <20200814133939.21185-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200814133939.21185-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9-rc1b-tag
X-PR-Tracked-Commit-Id: 585c6ed738a5ed2a6fd7662fa1d82f25acfa85de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0520058d0578c2924b1571c16281f873cb4a3d2b
Message-Id: <159743775165.14792.6384919127435789166.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Aug 2020 20:42:31 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Aug 2020 15:39:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9-rc1b-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0520058d0578c2924b1571c16281f873cb4a3d2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
