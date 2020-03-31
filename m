Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E29AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6188B20678
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585698912;
	bh=6psK2CtWt0dqupXwoFRUT47uVOzUn+4hkMVHZqGay9k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oNb9l5NhsrkEkmuGl3b6Lq8VKweDdDPKZwEnSJAMY8jKupmt6BZfu8JRzGsrDcNHE
	 vDbePYp4rVJjLHVjmf2JVBFHhYnHzkQnn9gNFEWSfYpD58KRZug4jA6Dhp6gBj6tNm
	 Ryn6o8x8O18mCtMhzCQoTYjbChnsnh9j3Y9tvDqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbgCaXzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 19:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732024AbgCaXzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:55:11 -0400
Subject: Re: [GIT PULL] MMC updates for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585698910;
        bh=6psK2CtWt0dqupXwoFRUT47uVOzUn+4hkMVHZqGay9k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CGton2KwZGx8eWQhzh1OxTUeKu9fMj7f4Enkvh3rhxfq5CoAoQvC1Ex3xXOR1jKFi
         qjXFI1URdLu5v05f8Llak1yh25qWJZJNN+/D6HTMb4Nbt/MchLkK8+rHZdFJRlVqGG
         9+q2jOMEuQh8GhzYrSJiocz6S4fgHy4OHJXRAADk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330161649.15352-1-ulf.hansson@linaro.org>
References: <20200330161649.15352-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330161649.15352-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.7
X-PR-Tracked-Commit-Id: 92075d98abf0f42db1cb518150364f196d4ad217
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dfabb077d62552797ca0ae7756cb30d3e195ead5
Message-Id: <158569891047.16027.13020751083432936691.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 23:55:10 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 18:16:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dfabb077d62552797ca0ae7756cb30d3e195ead5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
