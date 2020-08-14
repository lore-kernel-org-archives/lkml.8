Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC51C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 21:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5878820771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 21:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597441886;
	bh=GNfLN5y4xDxrqQFiwT3F93E5Y+qrQk4eaEHSr1wkqX4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Lq5UGw1xiwP93rainyMp6ghheanZ6ald0AmxdIRA+yU30TvrWiCg95vXnRgqE264t
	 ZvauVikFxkgdIGdjwnbHu24qWhFo0qOw9Q15fUWoJhkuMz/rdKDPb0v5XEeoPbgstE
	 +4Gy+WRcQAu00859FFU2AZnO+5GwpmUS6QoAtELE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgHNVvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 17:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbgHNVvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 17:51:20 -0400
Subject: Re: [GIT PULL] OpenRISC updates for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597441879;
        bh=GNfLN5y4xDxrqQFiwT3F93E5Y+qrQk4eaEHSr1wkqX4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jEkoXke6cA3BOYWtfWWPWnHIUcKhHDVU37RMugTd9sSt5yMWUO9Mmux3oy//tZbQb
         pICRmxjQHm44mFLWuD2iY52hc4ikrT9vJAcbM23O3ieoikZ/vfXNiuRM6PGqdWUwTO
         nLEx3ANnxpEwWw7usoaRmuE42j536m+MqtiXBViY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200814204759.GT80756@lianli.shorne-pla.net>
References: <20200814204759.GT80756@lianli.shorne-pla.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200814204759.GT80756@lianli.shorne-pla.net>
X-PR-Tracked-Remote: git://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 55b2662ec665cc8b592809a011fe807b05370ab8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1d74fbe50c46253de519e772c5c2f431b2b837d
Message-Id: <159744187988.11302.13663539950271854164.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Aug 2020 21:51:19 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Aug 2020 05:47:59 +0900:

> git://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1d74fbe50c46253de519e772c5c2f431b2b837d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
