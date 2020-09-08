Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBDEC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86DC20757
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599596141;
	bh=pzpmfcP0WfpSeeqBxDIuxb7oi6sZpztmQu4jSUpE2DQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zmOdtutdhEm1Q/IL92XN+fmj+ycvD715Fstm4CGnbJcpSItSUP+x5+4MbE6u49018
	 iLHpBgAx7q2nOMZvYPIIPqkO0fiY8169Hy1je2IICBfbVMBGrmflpb+qQ/33HJurW0
	 Co1Ca+tmv+sckUAzite3FZ63EmtvhVOCDiG25SUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbgIHUPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730256AbgIHUPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 16:15:11 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599596109;
        bh=pzpmfcP0WfpSeeqBxDIuxb7oi6sZpztmQu4jSUpE2DQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vDXiV84VqxhpFQERoPntlTd8jJ03idntbLRy7RqtN9mzVYQgE34ZguzSrf1ZvglMH
         vPrD0n593H8gOBNpJjIBB17xAzVj8JSpPARB4Ug0uYqKmYK7u7MoTvFw1QkJhMzqGf
         DJXDkdapFKvctuimhxpnb/6xthGepyYf5jgSGjl0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1599578324.10803.12.camel@HansenPartnership.com>
References: <1599578324.10803.12.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <1599578324.10803.12.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: b614d55b970d08bcac5b0bc15a5526181b3e4459
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6dc7e06826bd7bbb654b7a730db99e7020abbf6
Message-Id: <159959610973.11661.4957951772872875984.pr-tracker-bot@kernel.org>
Date:   Tue, 08 Sep 2020 20:15:09 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 08 Sep 2020 08:18:44 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6dc7e06826bd7bbb654b7a730db99e7020abbf6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
