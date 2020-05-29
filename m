Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16990C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E718C2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590786616;
	bh=wbDSQIu+fxpS+dXqUvdtTPyHNi2/iFqBv10jvDeqrcM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Rh2hX3tbVa+cvK+ggBe4aLhsTTRwpc9XJsPudt3aePxFajTpHcvIorAMTJz+mduUA
	 9OcyhMbmXk3TmohdPF71sy5oVddDPC+E8exc5BNmUOHlEdjKd24Sr4AFarQ0hXJ5Cr
	 m9C35E3sKqsVe0A0ppw+Z4miDQ2wAlVlFfXEK+S4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgE2VKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbgE2VKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:10:05 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.7-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590786605;
        bh=wbDSQIu+fxpS+dXqUvdtTPyHNi2/iFqBv10jvDeqrcM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wy8FOvsGTe+cUL3u8oIJpR36vnafcWUIu6Gah+6pOR8PWr4M6xzMKpgpo7t71oBV+
         nqg1YZpZq6QhKyZ95afzKu+H3p3FQZsxeSxL8GXgoP96YBvncHjQMAC0e5H1VCD5lD
         DCMAAFoIiR3hggpPW0d/o7wrxD6+mDOpvBKfEFHc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200529103230.13171-1-ulf.hansson@linaro.org>
References: <20200529103230.13171-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200529103230.13171-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.7-rc6
X-PR-Tracked-Commit-Id: 202500d21654874aa03243e91f96de153ec61860
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 411ea6790e736da763d02da7e704107ce9365451
Message-Id: <159078660518.32003.11524358665584005860.pr-tracker-bot@kernel.org>
Date:   Fri, 29 May 2020 21:10:05 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 May 2020 12:32:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/411ea6790e736da763d02da7e704107ce9365451

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
