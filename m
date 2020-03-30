Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DA3C2D0F1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD191208FE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585600816;
	bh=BnapL7PNjuiGUk5ThjG3kkJukHnsfgG0HrcNQzz9ynU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fWjgSzSNDqugNjkKURCIGoBqG1xekDBP83OrSz3xrPrbQdU7ibeKHyC353LjwvDKS
	 chINA4T97nMlcg60Iv2d+rhxbR0WUeO75LgkmOkkWAQLl/20e0R5M7OUlaYAdE03PU
	 XqJJzaS2g89u5rM7efujv+lDyQPHdNErlC0u2RnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgC3UkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbgC3UkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:40:10 -0400
Subject: Re: [GIT PULL] hwmon updates for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585600810;
        bh=BnapL7PNjuiGUk5ThjG3kkJukHnsfgG0HrcNQzz9ynU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1wuswTZvlU5af8TaPO2wYpzYNzEIxCyX2kra6vC6I+AjYl6giHMG+2e4PlFxPL7kE
         VKb5KEMTS4QxtP4FW2o1aXWhWuvGl5C/SXhCYKyVMRITGouRR+uBVuWx4fgBTr8s58
         gpllzP6BgoPW3r7AO9gtCg+OWbJLBtaQI4biKSCo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330155124.243034-1-linux@roeck-us.net>
References: <20200330155124.243034-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330155124.243034-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.7
X-PR-Tracked-Commit-Id: 5b10a8194664a0d3b025f9b53de4476754ce8e41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47acac8cae28b36668bf89400c56b7fdebca3e75
Message-Id: <158560081009.3259.4182950844172818914.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 20:40:10 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 08:51:24 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47acac8cae28b36668bf89400c56b7fdebca3e75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
