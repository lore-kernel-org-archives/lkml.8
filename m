Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E0AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E30E2075A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591576525;
	bh=Gcjf1kSBi2f3C/9Vy4cUHB1kM4YpuIYtnpV61ilN05A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xkQG+aiuqqL2tMMTM04UBQAsHVVb2vHyybmklsbRgZT4QLmBsAo/tDfTdKXRN6wMO
	 0I13IdBybKEuk/2unXawZ/74N1lkK36chqtN0lbTVVqR3YGtHRWj1PLr4rkkMiSQGj
	 jaBFpeb3hp4GZo8YsaoochoIgPEr8Jxe4hgSHOp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgFHAfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 20:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbgFHAfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 20:35:23 -0400
Subject: Re: [GIT] Sparc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591576522;
        bh=Gcjf1kSBi2f3C/9Vy4cUHB1kM4YpuIYtnpV61ilN05A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JtLfCwmBcRGdPImr64l+WnZ8blpIZDPBh8B1/wRmnvzlBLDrXUrpFW6zmssJ2itYk
         MZWosk9vwitBhJyylq5BJ1AoWKR75DrR/yB08gxSS3ikacR5JzPEQUDzMl1+7r4U1a
         sfThppsYdE+R1wlINfrmP8qw9bH1+GiRicoLNzgM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200607.171618.569910731236239182.davem@davemloft.net>
References: <20200607.171618.569910731236239182.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200607.171618.569910731236239182.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next
 refs/heads/master
X-PR-Tracked-Commit-Id: 4f8ad73898171cea2dce9ecf5bd4337c9dfcddc1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52e0ad262cd76696e8cd8510944b0bfdc0c140a9
Message-Id: <159157652277.5945.183781111509302573.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jun 2020 00:35:22 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 07 Jun 2020 17:16:18 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52e0ad262cd76696e8cd8510944b0bfdc0c140a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
