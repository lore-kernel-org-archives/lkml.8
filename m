Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CECC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E38A620791
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597112899;
	bh=APYx2ieiO2c7ZFEH/QnpKdN0zBjOTyU/UUkVk41KsTE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2kggviNW3z6DbT+qe398tZpF33sZy0okxBTPsyh7877giNMVeMxrG1+LKeJWQAYSd
	 97d4ZkYIY1c00bgHA0xUioLUCjg0I/1TZMB5ErI/Rn/GmUe8svqjD+YoH4F/2s16GO
	 D/vh4fEwnqIoWJRrN6aWeqaFGLCIsvs9X/nDpZd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgHKC2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 22:28:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgHKC2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:28:15 -0400
Subject: Re: [GIT PULL] ktest: Updates for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597112895;
        bh=APYx2ieiO2c7ZFEH/QnpKdN0zBjOTyU/UUkVk41KsTE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=izQ2+hfNicFDiQECbTD/WwCuxmJfvoUTW2SjlIsPp1f0zeG1LHxBIlMxIbDuDcj/Q
         DRy9r9wA7F5uPm+ICLpye0SCxn9OOGL9VGNaJLn0fLEkJ27P7ju5XKvX4rqVhn6C8w
         ypcqEb1xBxjxyRwF1sV5S+zYFXQJIMZac9++si/o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200810214952.394ccc78@oasis.local.home>
References: <20200810214952.394ccc78@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200810214952.394ccc78@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v5.9
X-PR-Tracked-Commit-Id: ff131efff141fc679cccde28bc265f4c79cbe329
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed3854ff994b35cc11658d43d01a421bd5088d23
Message-Id: <159711289536.3363.15878002918604546056.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Aug 2020 02:28:15 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Warthog9 Hawley <warthog9@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Aug 2020 21:49:52 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed3854ff994b35cc11658d43d01a421bd5088d23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
