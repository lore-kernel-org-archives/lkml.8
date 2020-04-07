Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA059C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855EF20748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586289325;
	bh=DdsK/OKUpp/DaTXIu5GzJY7e9eBhbCVSF043546D5Jc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fKoXXBS8y5hQhb/Nyjaf8+jmCwm2SYoIxCsbj8qXh2rOKQ4HAQwUS8rwDJKeiIG+f
	 KzTFQHkmE383nvAUjFAoqL00elymhZ8ErBjMySpnLO2lKl1wK2TXKYg9rBwxSbJn3+
	 cCdHqnPardneSUPGBCpFxaT6yR1w7N6MALwfgAFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgDGTzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgDGTzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:55:24 -0400
Subject: Re: [GIT] IDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586289323;
        bh=DdsK/OKUpp/DaTXIu5GzJY7e9eBhbCVSF043546D5Jc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QFMkmJtu5t4cCh3icLqLPGo4nvNznt1PZARJekiFCC4/ZXNZUNTlS4Lb4sSpDIp+p
         fpNaKm/jBhDUmnb0NB1xHMaXUDu1Yr0g8haXUQIgMX542rX+1Du1dZOdp1lplpIN3U
         OZ4Wl82p7LBb8I90mcJDpI4ZGAZkt3aYZ91fR2NM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200406.112410.1593839462932058.davem@davemloft.net>
References: <20200406.112410.1593839462932058.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200406.112410.1593839462932058.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git refs/heads/master
X-PR-Tracked-Commit-Id: 78a515f9faf3af43cf9c4f61254dd1c5b3cb2d0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 498ff42d557df021632d50cbd3f438c2e09d9743
Message-Id: <158628932356.3792.13123860548701530577.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Apr 2020 19:55:23 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 06 Apr 2020 11:24:10 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/498ff42d557df021632d50cbd3f438c2e09d9743

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
