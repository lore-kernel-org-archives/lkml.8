Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1A4C35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 19:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DFA20702
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 19:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582400728;
	bh=Em+sT1SMzyjmdINk0tNXrb0+vPJpCDDA2MklK1/1JyA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ijm9r84wdnpIuVxo7RbQq5fcdt8BjsxBq2hQzldbxclga7Wuj0O6QDxd7O3wv43ig
	 TKWPHNm1kh6y1Jm/2PQlAfLTQ1wFUCqb64o/0N8J6ztzilflrjWGpyFGSxUHCQo6u3
	 duCXRMvLw14QRAPynj1qiMAm98wCJPd+K1Mdo4Bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgBVTpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 14:45:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbgBVTpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 14:45:17 -0500
Subject: Re: [GIT PULL] s390 updates for 5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582400716;
        bh=Em+sT1SMzyjmdINk0tNXrb0+vPJpCDDA2MklK1/1JyA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JJE9JQAO/N3sC1j4SRywDKO+gqvA10xr7RtdmBcquLcpnHCfQ2dtbstZFJZ3/UWf4
         W1fhNLlUogr6nd2upNssRRpKUrUy2crCJP4Ur5YMB4VMMEVLI84d9K+fisFAnelWjk
         /K6gjBlPEENTxQCtDpV7vkIPy/MOBwOYyqt/xNjU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01582376640-ext-7410@work.hours>
References: <your-ad-here.call-01582376640-ext-7410@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01582376640-ext-7410@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.6-4
X-PR-Tracked-Commit-Id: 2db01da8d25f0420c411e788a9e1ba39269ae37b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 591dd4c10146e541b9f7a461cb6b638ab313718d
Message-Id: <158240071680.14316.8252252024374039390.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Feb 2020 19:45:16 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 Feb 2020 14:04:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.6-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/591dd4c10146e541b9f7a461cb6b638ab313718d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
