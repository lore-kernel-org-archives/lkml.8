Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C657CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 00:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A692120748
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 00:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593822606;
	bh=zSfHfxRQcXb0PkjQmb+R/Rb4tu74QjzH8FQS+vhFpLs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Y5D6krzG6WBHx6xb/irLqNhs+yKfheci8MZGllalrS48Y7SyiXHF9xmsmUE5ctgd0
	 Zy9+V1XTs6xD/2XAVLTK6X8u7EmTnuJMtHcPzkpNqgf0lSvgxrCVT7o/ssqIPE/Qu1
	 ecc/tS9EnuaIc8vwlyxezGJcMe/aey2ZyXeeACtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgGDAaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 20:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgGDAaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 20:30:05 -0400
Subject: Re: [GIT PULL] hwmon fixes for v5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593822604;
        bh=zSfHfxRQcXb0PkjQmb+R/Rb4tu74QjzH8FQS+vhFpLs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OtAyvjBam85vD3N6Ps/odDc8tsGAGZNZgB4wLOzaq1O++wSTxUDXYQqsZB/tvoxWC
         YO5zOxF9oeL1Y8Ux7wcrjszaAjC9ykIUe2bHClgDNllQqNwGwQ0aayWv9jqq4bfG+j
         NwG2x5tm/WojrMJnlFdOWbjJFA+Uslv6Tx02FY2I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200703220336.33100-1-linux@roeck-us.net>
References: <20200703220336.33100-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200703220336.33100-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.8-rc4
X-PR-Tracked-Commit-Id: 0d242479b3e6f7b5aebea3ef07b8a73c4f45b50c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f216714a6906d6d5d0654313d9f9a47613bb473
Message-Id: <159382260463.1071.14303822450964623488.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Jul 2020 00:30:04 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  3 Jul 2020 15:03:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f216714a6906d6d5d0654313d9f9a47613bb473

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
