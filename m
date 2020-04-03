Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5146C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A726D20B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585947038;
	bh=nqSzCyjbIKQdgBpyZ/g6s47+6ROMV5bNk+xGz6zu8bw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vHC3Pykqu4WDSMjd/UZ7m95SkT+1J4ZQ7FqvdZFwhf1smaABLViUZh1xpvXvtwDpi
	 58AMpX5brbgU68eFILzYXevk+SOp+WgHP2mmL6MZZgeWOMioaCbVrXE/tAXdqvNJZx
	 P01AIPj4iUxovRMx1mqgUuWZ+eUBmfM5rkLKpHlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgDCUuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:50:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728816AbgDCUuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:50:19 -0400
Subject: Re: [GIT PULL] xen: branch for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585947019;
        bh=nqSzCyjbIKQdgBpyZ/g6s47+6ROMV5bNk+xGz6zu8bw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1ZO1mXz2CWdYrzMcObLvo7sBmkm8VEnzxgNMLH5w1u0LBOc/dryvxxpx2mxZnE2Iq
         +0NRCB28b7OTfdryymNAu4CR5+cBm5yoWlle+4BKEwsP37u3GHu8s5hwtGTE/xJVZQ
         ruF54mnpoeKfjvOtdmVDT0H3yuNutTxH5d1f//rg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200403155457.27562-1-jgross@suse.com>
References: <20200403155457.27562-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200403155457.27562-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.7-rc1-tag
X-PR-Tracked-Commit-Id: c3881eb58d56116c79ac4ee4f40fd15ead124c4b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cd3d4019ba3f45aa1a87e4e914e81d367b59937
Message-Id: <158594701954.4594.6283769979479835894.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Apr 2020 20:50:19 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  3 Apr 2020 17:54:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.7-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cd3d4019ba3f45aa1a87e4e914e81d367b59937

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
