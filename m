Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2607C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19C0208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585691414;
	bh=vwS2WyuE8y0mjPNrYzxpKkhHhYf8AtDFYMmOyIH/StI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AkiMh7YfF/hXXnLptBW63zQvX1YZ1cNCIa0nPYkX1wzQekPyauOQLmFqDIHJzysUZ
	 fkPvTA+gPbatUgDGYfFEybefYWoCBQ+bQAhws7thO3/rfk4iUVvhX3Ly02vtDOpkY1
	 oH1IMXDhKubsXtsey2J4YW3JlM/YKbDXmR+X23NQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbgCaVuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731703AbgCaVuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:50:12 -0400
Subject: Re: [GIT PULL] Btrfs updates for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585691411;
        bh=vwS2WyuE8y0mjPNrYzxpKkhHhYf8AtDFYMmOyIH/StI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MJRHfZqwriYITu3P1PxhHqGrvnCiaR1lWC7iOZAveP48CbzhBGqVnKeuA/K/JmU+M
         uEPY+fT2pLh7gFOX3e3heF+ucRx8rao4VjgBHoRB7/NWEtofOnGc0XwQUmg4wWlnob
         trfP42bR8NGnM8yNkttDRuIMoyyvnxFow+NU8dBg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1585581921.git.dsterba@suse.com>
References: <cover.1585581921.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1585581921.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.7-tag
X-PR-Tracked-Commit-Id: 6ff06729c22ec0b7498d900d79cc88cfb8aceaeb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15c981d16d70e8a5be297fa4af07a64ab7e080ed
Message-Id: <158569141150.7220.17016209965429680277.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 21:50:11 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 20:37:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15c981d16d70e8a5be297fa4af07a64ab7e080ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
