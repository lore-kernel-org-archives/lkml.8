Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C49C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1A920728
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583528109;
	bh=IZ1/T927PbeEaqoVmGzl3jJ+IHVoXzG+CJ5j6TJ9430=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=cB0KiRgTQxmuT6JzbMor1CK1zS8B1qrzPVkV9H/VBpnwrzs8942sG+m3lSfC/Cjb0
	 toOEKhXQluXgfTpG501WpNd+SlQ/bPse0KGcr86GCJfDf0kcsOH9bisVuvGkAxtiCr
	 5LoFIjKCzr3+DmpZBf+A8x8Pn+t4EyNYv3siIxJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCFUzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 15:55:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgCFUzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:55:06 -0500
Subject: Re: [GIT PULL] hwmon fixes for v5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583528106;
        bh=IZ1/T927PbeEaqoVmGzl3jJ+IHVoXzG+CJ5j6TJ9430=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EQitYo/pltDla89YnEZ/ljxGga4SZeg8Aj+c3Gik41ADAvyO2noyvdZ5jG3YfsSEQ
         1aRlMANnl3ryLsxyLyT8Kv67MXHJAFsxc5BrVpyk+I0NGRo0OUVpr3PwShGbhDL1w7
         PrrFfZrudmlQFyNhWYjHpelVe0mZqftdcN9PvxmY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200306161958.31030-1-linux@roeck-us.net>
References: <20200306161958.31030-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200306161958.31030-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.6-rc5
X-PR-Tracked-Commit-Id: 44f2f882909fedfc3a56e4b90026910456019743
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 08e39fcb92b039189006566a97aa9565fe20fb83
Message-Id: <158352810648.1815.9744078639413341687.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Mar 2020 20:55:06 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  6 Mar 2020 08:19:58 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/08e39fcb92b039189006566a97aa9565fe20fb83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
