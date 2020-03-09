Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E32C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F2724655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583797213;
	bh=DaPeSR+evs/0yveH1K6pt04ScdqLgbL9vAH8gGbvhkU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0MHgBHMs51xX7JpOqq4Mp2rzPO0IxvBhDBRW0X38DbgQbStIh0ygG6ryb88airJ3i
	 cP+mHLH1iNnVXlESStdCfYE16M1njdDzku/w8ahfgFmcjVsOEPQfDNuUddyPixhlTr
	 ayD89T2C8Rsq5pTTmWx+WIzxMZvqgWqZjw9AXLzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgCIXkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 19:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbgCIXkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 19:40:07 -0400
Subject: Re: [GIT PULL] ktest: Updates and fixes for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583797207;
        bh=DaPeSR+evs/0yveH1K6pt04ScdqLgbL9vAH8gGbvhkU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TYKkNbEwXX0YFOFewRzvQUNV2AahDou+xhjNlnrBq1Rc8+BMoXR83i8i2aNpc7ICV
         D8loTdLSAXbYWYub3d/8fb8WWjU8ruwZoAKJfs3VtZx+VG6MjAyrr8plTiDYGvGf0m
         rXv1MFb2BgI+aZ1f6o4A2mfH1LQ8Uzs0uIQqvC6c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200309162726.71fe6060@gandalf.local.home>
References: <20200309162726.71fe6060@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200309162726.71fe6060@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
 ktest-v5.6
X-PR-Tracked-Commit-Id: 1091c8fce8aa9c5abe1a73acab4bcaf58a729005
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30bb5572ce7a8710fa9ea720b6ecb382791c9800
Message-Id: <158379720745.7202.8635621257082930121.pr-tracker-bot@kernel.org>
Date:   Mon, 09 Mar 2020 23:40:07 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 9 Mar 2020 16:27:26 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30bb5572ce7a8710fa9ea720b6ecb382791c9800

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
