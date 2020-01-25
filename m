Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563F3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 22:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A01C2075E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 22:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579990517;
	bh=GhNPpuFFe63ryKwLhxOo1y8u9Yc2z2Zv/GinOZSQoC4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FX4ZLlyBWdc+qDQJS9HiKvp8C5pgYtlN7J54/hN6cl/Skr8MOnLFTLcGULf5ASct0
	 DGwoxwpQ7tXt9E+RfCTx8kerFMyqmXb+5N6lDfLJcW1U9fU7Ue/aB6UkIWgVdof47P
	 ZDyxefPaAgXZWiQnifpXJq1/eZba7l/vXhgpZx34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgAYWPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 17:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgAYWPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 17:15:04 -0500
Subject: Re: [GIT PULL] ARM: SoC fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579990503;
        bh=GhNPpuFFe63ryKwLhxOo1y8u9Yc2z2Zv/GinOZSQoC4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mDsCgbC/L2/8TlDAQiaUFlHcBSDsun5vjO44ImovLS4nRPVmQbPdqZy7VrQmZWqW7
         Ugur0hyhS5r4wAB5nRB+AHq48+3Bv58GIu8DHJFJQ1dpFlsAg/aK3FAzlXf7WDyB+q
         z2IKx7KtICEUylRvfVIaiTfJnU5Fkc2l616fcxKw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200125213702.tkh5afxz6ao5rsw2@localhost>
References: <20200125213702.tkh5afxz6ao5rsw2@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200125213702.tkh5afxz6ao5rsw2@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 6716cb162deb9d474095a57d7a515edc13926ea7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f041eadad7504b1364274494548b9716b2ed59ac
Message-Id: <157999050390.5823.11026600653641064716.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Jan 2020 22:15:03 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, olof@lixom.net, arm@kernel.org,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Jan 2020 13:37:02 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f041eadad7504b1364274494548b9716b2ed59ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
