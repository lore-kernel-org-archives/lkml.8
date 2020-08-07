Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B89EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5302D2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596822462;
	bh=XaF+TXRGYPcpEwVJNCXx1yR4LaoiYKIFq9gk49g5Vwc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=b5wTodpwUCycMzuceLmEp907sb0oGtMgijB3Oc36gk6X5i2K+XswOQWycMxwfwNZY
	 xxREoITOLlnDBxMUuLTGa4XtX9TSrgEOPJYVFRyZrnvY55GfUKHsqNFPilqJMiTSk3
	 d3FpVYnSsb3XXsNxx7lfWw43doFkwZq/yQj4U1Lo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgHGRrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:47:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgHGRrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:47:12 -0400
Subject: Re: [git pull] Christoph's init series
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596822431;
        bh=XaF+TXRGYPcpEwVJNCXx1yR4LaoiYKIFq9gk49g5Vwc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kEFR5TI9e7wy0xF3RuAS1t8iDL2J05CFzs+uUYLKcuchSDiJ6U5QxjTOdDupaneaa
         S4mirrPaniimR9hLfZP38RoqGQlvmGAS6Ml4yyLeF9KcncnEnaNsxkB3Mh4ZAvWtyA
         qTf1/+1vjjFg/oMv+lBSvXCHl1agqCr9K2iPkHEA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200805042144.GN1236603@ZenIV.linux.org.uk>
References: <20200805042144.GN1236603@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200805042144.GN1236603@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git hch.init_path
X-PR-Tracked-Commit-Id: f073531070d24bbb82cb2658952d949f4851024b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1ec517e18acc0aa9795ff92c15f0adabcb12db9
Message-Id: <159682243162.18750.5622265495411736387.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 17:47:11 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Aug 2020 05:21:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git hch.init_path

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1ec517e18acc0aa9795ff92c15f0adabcb12db9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
