Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F075BC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 18:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A01206DA
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 18:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586630127;
	bh=YY84iTaL9IJkn7PKcECSJ/W1nm5od2vLwy38+BbaUPM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Wobh7C04a+P5BO+qXO+Y24hx1AyqWb3mj0JETCikAnX6b326ej0W2Vp9CKMhPIY/e
	 eU4aIr3C1trzPGcQDaGVcQYymFLRfazd4+No11XXsmunSwA/yTs2OlgGUJLowdxB4J
	 CrD1QSxg7wG0U6wWPM7E4WoCo1zWpuVn5WqYuPm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgDKSfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 14:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgDKSfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 14:35:25 -0400
Subject: Re: [GIT PULL] more Kbuild updates for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586630125;
        bh=YY84iTaL9IJkn7PKcECSJ/W1nm5od2vLwy38+BbaUPM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o0X6s8ORof3WheVe1//ELjVW9XzE7JkfmblicxBDCXCPzz7rTlH8Yh+XYt6901AIK
         +ooHHHaEcu5tMilmBqsjz0lJ6EUF5A1uEmdOYkEox9VthD3kGBd1p0Mm6g4i+ufjM3
         +AsHPYEIzrT2P+dzpjgWmKDgrztQnJKTOR0QtjG0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNART4rVUYsaqQKM4u1DVxTtDDs51kyY9JFKCOuHe1FLV-Q@mail.gmail.com>
References: <CAK7LNART4rVUYsaqQKM4u1DVxTtDDs51kyY9JFKCOuHe1FLV-Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNART4rVUYsaqQKM4u1DVxTtDDs51kyY9JFKCOuHe1FLV-Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 kbuild-v5.7-2
X-PR-Tracked-Commit-Id: 00d76a0c19436c88ffcafa1e816f0c0c9af082a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b753101a4ac0b906064a72feec43f5b80a1fe2e5
Message-Id: <158663012561.22476.9821887008115108019.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Apr 2020 18:35:25 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Apr 2020 12:24:34 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kbuild-v5.7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b753101a4ac0b906064a72feec43f5b80a1fe2e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
