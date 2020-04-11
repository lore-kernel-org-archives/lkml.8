Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D917C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AE42082D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586568028;
	bh=iqJZVbs51UGDnqdGVU5/jtBGKszBWnavKyMrnA8OuoI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LTDyS1lZyfHqaQ8bjFtMBNF3LniS/MJhcr8SAMUdoEk3g26mrA2Nz+2LJ5/pjZkeG
	 4KPXekNxm3WjE7FsCfiiz1kGs2bsWtZKsk+3Z10oHYbNLIS+NSSchgEshBzOrYsfgG
	 QHmQhbOSCqSnCURgKmm82zoNPodR/OY4ZV/Xw+g0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgDKBU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:20:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgDKBU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 21:20:26 -0400
Subject: Re: [GIT PULL] xen: branch for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586568026;
        bh=iqJZVbs51UGDnqdGVU5/jtBGKszBWnavKyMrnA8OuoI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=na8C7w3eu94yAlZRV/XZDZ4vkGtwQTzLcgHTuiJpmuCdK015QDUFgXNp1IAOsNJO9
         YX9rgxTmvjl7kiPx2sS6nOYrmBKmuzzDCkJwm/P5G5bHU8/dEPN6TCFYNTinWpQxjr
         SBwR8ZgDKErH4YZfQHutm7Paf4oX0ZrV23/Q3jSA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200410062430.20949-1-jgross@suse.com>
References: <20200410062430.20949-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200410062430.20949-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.7-rc1b-tag
X-PR-Tracked-Commit-Id: d6f34f4c6b4a962eb7a86c923fea206f866a40be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6383b185a998861cadb2f95d97cfe29945b9c32
Message-Id: <158656802668.16442.9324878577683276685.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Apr 2020 01:20:26 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Apr 2020 08:24:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.7-rc1b-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6383b185a998861cadb2f95d97cfe29945b9c32

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
