Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E759C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D0F218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580926959;
	bh=yuBrlgCSyNpGr7f0LkdGSKgVKnHVeUJjNZG0igVS9No=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=f41uA9voyJ4BbunO3LD1jPpGoSasT0c8uvOKGn6+2qzuom7n9lBslRcf42vomHevf
	 mDadq60i6MSxZByLyLxKM8BNiwE8kRO7FuJzTbDa8/hFQdYs2nJLH5Yfso9Ch2GIps
	 Xt+SpSxCRXy424nsIGoGsn/+7JcaITIE+NX1c8nA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgBESUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 13:20:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbgBESUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:20:16 -0500
Subject: Re: [GIT PULL] xen: branch for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580926816;
        bh=yuBrlgCSyNpGr7f0LkdGSKgVKnHVeUJjNZG0igVS9No=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nzH9OKtg7Wr17/acZ5zPdO4nd6vpEVmHl1rP1B4nTRnmGk+3bHyRZHpfwPTDKvdiK
         C0eETZgCkjnldURs8faFa2ds7o8EUogzUfLFo3eJD2nK8GvXgm9GMbhXM2fW8AU3q/
         NzjDLSUr4RhhXOOFV4Qe/APvd10GeR8x0xZvRoq0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200205141135.31595-1-jgross@suse.com>
References: <20200205141135.31595-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200205141135.31595-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.6-rc1-tag
X-PR-Tracked-Commit-Id: 8557bbe5156e5fba022d5a5220004b1e016227ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d271ab29230b1d0ceb426f374c221c4eb2c91c64
Message-Id: <158092681621.14135.14219430235179173763.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Feb 2020 18:20:16 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  5 Feb 2020 15:11:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.6-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d271ab29230b1d0ceb426f374c221c4eb2c91c64

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
