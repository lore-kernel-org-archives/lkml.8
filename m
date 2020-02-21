Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FD9C35666
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F8E208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582319428;
	bh=P9heDIhwv2+wo6i8+/0iv17UoNqLsqod/MGBhTrR0WI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kd2tFDDbvI3q2bF+IRLk6m3y6hSZPihXIoaxjKMXe4tg5R9xCuvTBK7nWUxLCgeGs
	 UpdtCelv1MxNteCq5k0aBFqjEUHZ2tbH5LimjoGTxJiQ/dMiFuqWRuF8hO3KZujRaR
	 LAGMxkrJNVZjEcV5x5NmVIIvbToncQlUMrc9zPCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgBUVK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:10:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729683AbgBUVKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:10:22 -0500
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582319422;
        bh=P9heDIhwv2+wo6i8+/0iv17UoNqLsqod/MGBhTrR0WI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Rq/Gf+jT7ONoOugpoA6VCWPXItFjZ7GRT74jlnlKubBtMi5F0YRhG2tERgf7s84Yz
         cXv1dBFtqfeNPF62Q1pkcYoewnpNI/LS/tYMWjfzgh/bs0FRaoJ78izLxlU5aiA8Xr
         KaBn3mrjAlCOcWTtBGM1WB8z8GhnXuHMl4GVgDSc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200221114012.GA114392@kroah.com>
References: <20200221114012.GA114392@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200221114012.GA114392@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.6-rc3
X-PR-Tracked-Commit-Id: 74ba569a15a08b988bc059ad515980f51e85be79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb65619e97323b8d62dd4d7549b9b7fe8a774706
Message-Id: <158231942249.18249.15250078843801513593.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Feb 2020 21:10:22 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Feb 2020 12:40:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb65619e97323b8d62dd4d7549b9b7fe8a774706

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
