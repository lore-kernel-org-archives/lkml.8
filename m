Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481D5C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 20:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 232182076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 20:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598732237;
	bh=u0KaLes9XSWWVINqvo18NfTe+oQVn8AvU5s9XQnvG24=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hHORgEnvIgy3ixMH3QAStjTZgpB+mndnGFoCmVMXIR1VQXUh1HfSaLIL3NuTaXkEo
	 2QyR6A2gEXXfvHW/1c0Ds5xEe1lgfxXGJQ9/yVVqcIkOLVbmeIxN95g1D6lz9yEcmW
	 GRZuUriOuFWkHgKhii1U8cUPShL5SLfT9LpohRlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgH2URQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 16:17:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbgH2URK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 16:17:10 -0400
Subject: Re: [GIT PULL] xen: branch for v5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598732229;
        bh=u0KaLes9XSWWVINqvo18NfTe+oQVn8AvU5s9XQnvG24=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JiYYZUznA8dWuEVInkc9jrXo9q2A0sUdIDmQJYD8UptJtvxbTL4u5E47unqUHpXkN
         nLadsQCJS1unImdEtzhkZFO4kz+9nI2OedKQWOyFT5Hmlz2J8Qh5YDwxZ04K9XSHJN
         qCEfxQhZzK0eAYL9ul8gEndGOUZk+SC7itvknkhM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200829100405.23826-1-jgross@suse.com>
References: <20200829100405.23826-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20200829100405.23826-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9-rc3-tag
X-PR-Tracked-Commit-Id: 9d3004bf7ba32c89873bb8422671d52b4bb52ce1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8b5563abe02c5e9abdd6a74043c651a9ec31e9e
Message-Id: <159873222908.9079.13679605240472486612.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Aug 2020 20:17:09 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Aug 2020 12:04:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8b5563abe02c5e9abdd6a74043c651a9ec31e9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
