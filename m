Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA69C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 20:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BCCB2176B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 20:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595188814;
	bh=z0MebcLUhj8LKL49hXTHgNO2DLhWr+gagq7GwiMHxG8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kK/WL5nQ67AJVT6icV4NvJURfO2dUStL36bWimyRIP+reRDxdpnu02rqpK2skJuJL
	 R9llBVZNyqY41Pzpcyn1re3wuEB8Uyvp6XmOwFjZecFww3Qf9EAnFloAWpoOPnrlaK
	 otfU8punFHDdvihSC+YKIbH804vkaXC6Kekv7MDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGSUAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 16:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgGSUAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 16:00:06 -0400
Subject: Re: [GIT pull] irq/urgent for v5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595188806;
        bh=z0MebcLUhj8LKL49hXTHgNO2DLhWr+gagq7GwiMHxG8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c5NQ0e9d74SOn2HeDtiZQH/B1K//DlygO48lCLRsO/S9gqoBzhMmvpRyHRTsUdmer
         YBG1DvElnwMcERmtFbHnls2dSikcmn6FfuyKidRzAbtwXuL8i21B3uS5C7XIyTaxGw
         SUDfoT56X0+gKgTchKkeN16TqNeYsV5y9Y7FFTpo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159516469014.4147.6471285397574034610.tglx@nanos.tec.linutronix.de>
References: <159516469014.4147.6471285397574034610.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159516469014.4147.6471285397574034610.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-2020-07-19
X-PR-Tracked-Commit-Id: baedb87d1b53532f81b4bd0387f83b05d4f7eb9a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9413cd7792dc03608ec9b1f1f5c74fc54e714ed3
Message-Id: <159518880619.26827.10602938812031253845.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Jul 2020 20:00:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Jul 2020 13:18:10 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-07-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9413cd7792dc03608ec9b1f1f5c74fc54e714ed3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
