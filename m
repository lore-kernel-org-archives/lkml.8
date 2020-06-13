Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC69CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 18:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98ABB2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 18:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592071235;
	bh=GXkstgz+713p7k1LwCYneHSBu16HFmMxzbL+XZp6ydk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vwrotdi0PIArmk4HdX0BX6Gc1uGwoiQDiSNJBEc2vUzqHO79giRV6AEBAXQyxNTbi
	 8Iyf0GYtKdwqSmc/RIrYFXPOBx6wsVtqWlSy3JTwGILizBquF9gfRLmkf/8PAyJNLr
	 hdW1gM9hOYl/EhzUyk/SOkt/hKf+A7TzrEXoWcV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgFMSAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 14:00:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgFMSAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 14:00:30 -0400
Subject: Re: [PULL] alpha.git
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592071230;
        bh=GXkstgz+713p7k1LwCYneHSBu16HFmMxzbL+XZp6ydk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vgEhdKwiG1FGEL9I55WTLe/loM9AoAxJtZkNtCGeT/pCJc1itHfGgC5sxS2CgVIKW
         jl05fxr63U56+bJmNgmDGZ+x8dA6EdyNbfHNj+yzqyq5GFZrUsbI98bOuNGIkl9NWe
         IB38v04Fd58TD18Sc4oAMihZK80JK/MzZ9oEa/p8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200613005719.GA344350@p50-ethernet.mattst88.com>
References: <20200613005719.GA344350@p50-ethernet.mattst88.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200613005719.GA344350@p50-ethernet.mattst88.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git for-linus
X-PR-Tracked-Commit-Id: 777747f634ba765085373f851e9c48dccb12ad52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66125d934b39889372b8d75e4c192818656efb80
Message-Id: <159207123032.28894.5102920193974518200.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jun 2020 18:00:30 +0000
To:     Matt Turner <mattst88@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>, Xu Wang <vulab@iscas.ac.cn>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Jason Yan <yanaijie@huawei.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Enrico Weigelt <info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jun 2020 17:57:19 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66125d934b39889372b8d75e4c192818656efb80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
