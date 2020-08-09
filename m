Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F70C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 19:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B87206CD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 19:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597002990;
	bh=wsahzl77t8ShF6FBZIn6NvzuzzArqJAIfcIHZ6AL2Vs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=W/LCJins1BXqMUvelvym3825StL3YxlnUgCOBkVB58Xg2cktQXJuXdcKwVqUFKuid
	 LmXFdIoAKpYM3CYt3d3gG2B2xhWWLNtzF2entTdOEZr1HxBW6+5VUmoj8u27oK93Ys
	 ybpfUh6YYWyCGvTvel3u9g4Y5W2s2XHnkrddJ6wc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgHIT4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 15:56:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgHIT43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 15:56:29 -0400
Subject: Re: [GIT PULL] pin control changes for the v5.9 kernel cycle
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597002988;
        bh=wsahzl77t8ShF6FBZIn6NvzuzzArqJAIfcIHZ6AL2Vs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=W0oNQpIMCY9ZkwZTHtU1X+M9ZpOIUCy9oUz5r66jlBq00/QP8TNUziPMHOKK2+VGP
         yyqAnQY10D5fCaqv3oACHFV+BmM0CFEtyqL2GRpaYKcNu7L/U6iQ7Y0qP9YmhLMTby
         XjQ3AdcxKJgpi7DS8xsdw0bQ3SSaJMK/UBg6ihyM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdZyVM32opVPtgPonC0Gqg7YVyCCXryvA66FQbQUELdHjg@mail.gmail.com>
References: <CACRpkdZyVM32opVPtgPonC0Gqg7YVyCCXryvA66FQbQUELdHjg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdZyVM32opVPtgPonC0Gqg7YVyCCXryvA66FQbQUELdHjg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.9-1
X-PR-Tracked-Commit-Id: 7ee193e2dda3f48b692fad46ab9df90e99e7b811
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9420f1ce01869409d78901c3e036b2c437cbc6b8
Message-Id: <159700298860.31137.15105538018690861481.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Aug 2020 19:56:28 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Aug 2020 15:05:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9420f1ce01869409d78901c3e036b2c437cbc6b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
