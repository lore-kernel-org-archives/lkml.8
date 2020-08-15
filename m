Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ECDC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC2B20639
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529177;
	bh=dg40suD33AMMfclaLTXL5ubQPIsh39Ob4G9oMLihIbM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OrSXx1965l1oWECs7XUwnn5kxJiftNMr5nbZl3Ejn/P+wffdp53xtigBVaw2pThsC
	 BtGRtuBUbPj1V3eSb+fbyreqJzUhmN9BHbjhv8v/BYELbN0X+0i7Wmp8ue46ULvGb2
	 YBOjcgvrWO/mtj/pCsTuDu7ZdvDtsC3GDqHhniS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbgHOWGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729917AbgHOWF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:05:29 -0400
Subject: Re: [GIT PULL] Devicetree fixes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597504963;
        bh=dg40suD33AMMfclaLTXL5ubQPIsh39Ob4G9oMLihIbM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xC1rfOw+tbkY1oC+g2HW7j+gR158ZCLFuxn9C91fhyf4cCMkMxiJ6lXsdoLIjahqg
         sz1YY3S19tdnUM0q2WAXz34saKM+9/hH4x4U0tIouNE3KBDjYpT0lNo9wZEJSICZW7
         ERgJ/tB2MA57iz7GjSLommqG9typfM1nzpgc2srU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200814194000.GA2591103@bogus>
References: <20200814194000.GA2591103@bogus>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200814194000.GA2591103@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.9
X-PR-Tracked-Commit-Id: 5f0b06da5cde3f0a613308b89f0afea678559fdf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b07175dc41babfec057f494d22a750af755297d8
Message-Id: <159750496348.10263.11355887804950212073.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Aug 2020 15:22:43 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Aug 2020 13:40:00 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b07175dc41babfec057f494d22a750af755297d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
