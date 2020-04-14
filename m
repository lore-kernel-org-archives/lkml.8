Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D13FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4535720575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586892345;
	bh=rxcX3bkiTxcRaV5uIf1VGYjtryE+LFQC/F5AUl8hJtU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QHXCAMg3jyV7gHppsqwrB5Xtq3QCen4EZJF6n4QuRCBWn6WnOfBPXZNg7KIHyw7LY
	 /NAtz94BYPbZpaXI1pq6a0OQqtwjjR0+svKcqVzusE5zEnBXgPZ0unpV5nusSWNBG6
	 jnJqH5gv7G7udOttsUC9PuezHc76J7sr0Zcp8gPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504666AbgDNTZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504637AbgDNTYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:24:20 -0400
Subject: Re: [GIT PULL] afs: Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586891103;
        bh=rxcX3bkiTxcRaV5uIf1VGYjtryE+LFQC/F5AUl8hJtU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XI+iFxHGSPhXA/9OrrwIZrvl/P2DJD/HXbStttid4I4GR425ULpTi4CfsNJI1sbHi
         QAnVkjMGiwLa7oxFhOdjEN2Foo0UjGV55A9Y4zx+Bls24yg+cmxafxD/1VniON6Mc4
         ORC+YNntjo/4ow7v7GyxPiPAXC2uV9xZV0QmkpTA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2940559.1586789415@warthog.procyon.org.uk>
References: <2940559.1586789415@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2940559.1586789415@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/afs-fixes-20200413
X-PR-Tracked-Commit-Id: 40fc81027f892284ce31f8b6de1e497f5b47e71f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4cd66682b2728734b2fc44f5f1e83a5c740b5cf
Message-Id: <158689110356.29674.8805335271309740535.pr-tracker-bot@kernel.org>
Date:   Tue, 14 Apr 2020 19:05:03 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 13 Apr 2020 15:50:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20200413

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4cd66682b2728734b2fc44f5f1e83a5c740b5cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
