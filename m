Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0799BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40B220786
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597181006;
	bh=sjZ/aEFvUXlyQShEB5RoOqRtoNhgwRY4rCEm/b9yDwE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=M1w3xubyAfKfTolleijAkcmQWML+FQ+FzdZT7uZBSoWwpPFB5ASnSR5aon0WLNDgD
	 eodx7Ly9ozERBc4uv/+hCtFv60Bk65E4dcuZiafUAIHv3lkvewRB217DqbQyhGSrYn
	 WkqaIb8wPddS7btiqFrirKp76fXBuEH5SfS53LYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHKVXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgHKVXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:23:25 -0400
Subject: Re: [GIT PULL] Backlight for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597181005;
        bh=sjZ/aEFvUXlyQShEB5RoOqRtoNhgwRY4rCEm/b9yDwE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y2Azh8nC9K2cf1xI6dSnLNh8LwAhcV765uiip45YY/Hz4Y+gSs2sp72+mjUV4343E
         mrgGZR0a8VZeGCooyTRr5NmXmU56NNJpH2pH6pCqeFFsI31xLadyjXP9f3lUXv0hye
         uSpVhju6M90jzSPwVAY7NlabScOhIrW7iogqznh8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200811075049.GH4411@dell>
References: <20200811075049.GH4411@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200811075049.GH4411@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.9
X-PR-Tracked-Commit-Id: 7eb99a39ef767644bbfd2b3f12f139d13e3ee8b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96f970feeb47003a8eba967f188bba4e75875c7a
Message-Id: <159718100509.533.11237093849636295841.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Aug 2020 21:23:25 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Aug 2020 08:50:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96f970feeb47003a8eba967f188bba4e75875c7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
