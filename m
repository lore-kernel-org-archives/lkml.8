Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D49CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D772082D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586539830;
	bh=OnM+gj60yVrV4BewUmzpN0FbBrIr6zGDE5biggxrUG0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KZko1y/1P1wwmyVrUTD1TR6hay4Bn/Yb3M10Hm6UifEZRwnpSmlBnpm0blBWFFl8t
	 hsE/ATYaVQVJoAhIYOYl49a0IbWAZtaYpZV2OjQqAk+Tc29pjK8HyblfKQH5Rc2r8x
	 +Ru8h4v2cb1UMKcyVtnjMSBuG7aL6HZIEZQlvRtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgDJRa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgDJRa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:30:27 -0400
Subject: Re: [GIT PULL] libata fixes for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586539827;
        bh=OnM+gj60yVrV4BewUmzpN0FbBrIr6zGDE5biggxrUG0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sHdJhafSCpVA7qZHxNCUaZti/98MiyBl9nrTcmgkj9hWRonzi9VxiJ+Iwcax9nwto
         WEv8x+vNjGT3Xj9s+FEyuRsvZafiiLuwtVLG2Rp0z7J7U+ttbc1b3XYOhLqHx2IicA
         KUhR7k8H+mGMuNURnbrPxSOgr+V1GYXZIJcLB9Is=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9069bb0a-c338-4516-52d7-99d85aca5297@kernel.dk>
References: <9069bb0a-c338-4516-52d7-99d85aca5297@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9069bb0a-c338-4516-52d7-99d85aca5297@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/libata-5.7-2020-04-09
X-PR-Tracked-Commit-Id: 7667e63c8af90e287f9e2d070599024cbabe63f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8693b3eb59f9055edca86b0789fd6593a57edf4
Message-Id: <158653982761.6431.708298111896222198.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Apr 2020 17:30:27 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Apr 2020 18:08:55 -0700:

> git://git.kernel.dk/linux-block.git tags/libata-5.7-2020-04-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8693b3eb59f9055edca86b0789fd6593a57edf4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
