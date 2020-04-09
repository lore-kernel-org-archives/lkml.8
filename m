Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB23BC2BA1B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 04:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0E920757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 04:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586408137;
	bh=9Whta/9PHFzOg9U9UvavgWEtC9sqqrhNap+vynEs3oc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=w2x7W+EfLENIp1ezTwGPCGRl2wF8s52+2CPRpWTpotHnluGSZu4UufsRBXLEY/Jfj
	 OxW4ux9wh1TFZBlql8+dgOLO2xFBD1vkD84lmRFUX2wdOfiJC0TK9Spgu0ckEmDHUd
	 CI35CznsrbiQOg51vJwEMYl+kMxKpz+3tScKBNiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgDIEzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 00:55:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgDIEzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 00:55:32 -0400
Subject: Re: [GIT PULL] Ceph updates for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586408133;
        bh=9Whta/9PHFzOg9U9UvavgWEtC9sqqrhNap+vynEs3oc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N6CFuWDUYwr3KbBGBjuYoBVjL3qqkJ8tqlboeyBFOvZhJyKZNKluyuIb5BAyiKZQ+
         TIPYREjGpFJETVZnFm6NYqiZE1cVI/TB/IbQfpYuLRBV765ZiYK458ibXbdc5A2g/F
         jBIhj73lab+0t2hsXrrhjmtenm/jnXwe5ylrqrVA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200408183007.19305-1-idryomov@gmail.com>
References: <20200408183007.19305-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200408183007.19305-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.7-rc1
X-PR-Tracked-Commit-Id: ef9157259fb7bb3bc2c61df227e36f1b861a4753
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcc95f06403c956e3f50ca4a82db12b66a3078e0
Message-Id: <158640813310.3202.2935579625440754696.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Apr 2020 04:55:33 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  8 Apr 2020 20:30:07 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcc95f06403c956e3f50ca4a82db12b66a3078e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
