Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF8FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 03:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8817D207D5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 03:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591327822;
	bh=YoKaxoQrK7Osc6T4J4lNYKJvT4VflmusOih32WK85n8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fLrL9EDb5G8zltWF8MJhbEMkwA6U7CebbedQNIeb50Hn4fRuPIDK1cxS0IoX74Pkl
	 waD+PsrEAOcpioi6Z0JILk433WDvvj8WeTubGGs0K16mxrgffPc+y50zPIJRqsreZg
	 wYtaGiwgSw68BEEEEalSokpLsV0WBlmgVVQH8/WI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgFEDaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 23:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbgFEDaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 23:30:18 -0400
Subject: Re: [GIT PULL] Devicetree updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591327817;
        bh=YoKaxoQrK7Osc6T4J4lNYKJvT4VflmusOih32WK85n8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qZwSVoH6WB3Csesg5APOpvk/SNdIIfU92Jel1f+gaQdGlGK+W7IMxRs4//QBsAyVW
         01arOnbzpY1VjeXx6jc3fkrxBlYbQxT1UErINKMe3wrxd21ZrRucJKD3qEURNva196
         aJFcn87894mEBgreyV9C3B4hCrfzWZMDnfxI7/OE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200604220459.GA4123489@bogus>
References: <20200604220459.GA4123489@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200604220459.GA4123489@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-for-5.8
X-PR-Tracked-Commit-Id: 8211d1e83aded34631aa87fa37f97d7bb712e925
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 571d54ed91c0fae174d933683c0c2e11c84843d9
Message-Id: <159132781765.11934.17450794719901004031.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Jun 2020 03:30:17 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Jun 2020 16:04:59 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/571d54ed91c0fae174d933683c0c2e11c84843d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
