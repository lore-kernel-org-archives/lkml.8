Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C8CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47782206E2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583533210;
	bh=bkVpgbIwJLXefuEO1nFV3zxd0O46UZ4/YW9d8Ska48g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=cstzxzXE0L6TexvYHBAPnJt+IW3xwsBedT+ufMPGh/r8NcdeaGkfXRgET1+SFHJvL
	 KoV9euRW77freWCvOFyq9GMUkBtGVA37o7atdNOChfsQTGym/wdkgBdWmozwcDD9Xl
	 Zu/g75kmgntyWLBnebrNJEqvVldWZOXY47+bjbws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgCFWUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:20:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCFWUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:20:07 -0500
Subject: Re: [GIT PULL] Devicetree fixes for v5.6, take 3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583533206;
        bh=bkVpgbIwJLXefuEO1nFV3zxd0O46UZ4/YW9d8Ska48g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XPKBuGer8BFO5tVoddpC4sunBfsnFt6MtgVGJujCZkNRLFeWoPPIgQ5ZDpyceUp54
         /ISyc4n519CNNBSZvVJDDaXWfTbbtTuo5OFWpg4lrOlHYbfG+WoAkKshh46F8Pgxdy
         ETRTKSviMGxwo5F4vK8JjfnkuUUizEwSwk7WsN9U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200306214007.GA23564@bogus>
References: <20200306214007.GA23564@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200306214007.GA23564@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.6-3
X-PR-Tracked-Commit-Id: d2334a91a3b01dce4f290b4536fcfa4b9e923a3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bdf1ea7ca8a9e6febdde32eec03e0a44f39a44ff
Message-Id: <158353320650.11032.15079243838323928327.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Mar 2020 22:20:06 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Mar 2020 15:40:07 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.6-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bdf1ea7ca8a9e6febdde32eec03e0a44f39a44ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
