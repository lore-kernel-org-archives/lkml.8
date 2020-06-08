Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E4FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC1EB2078D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591646728;
	bh=jnK08mAfkMWGL456sL7IcuTGBY0+8FtULzjMebbboYQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=k5Uo+eBG1bXV5UYSrN4mcFzo7ONkPTe+ogawKApYxN6IXyMofIFp8fVnFlAYSNipp
	 QBKAAE7x2WsjHwcgxS6RR7YRqV4xWJSSf7+g8QmOEQ4tQYyyr1rORShWXwNX7dclMi
	 TYvgNkvhBMgpf07ioUCjcFjn3iZkBT9oWYaMwXpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgFHUF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:05:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgFHUFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:05:24 -0400
Subject: Re: [GIT PULL] Ceph updates for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591646724;
        bh=jnK08mAfkMWGL456sL7IcuTGBY0+8FtULzjMebbboYQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=e9Mfu/Bj3SXPXezp7h5IUcZDwy6fB+tMh46zY0g9Pqj07qI/slefiXm6hfhdks1gT
         eKnz/fmkHsgANagf9ra93KAnW68YfP3jmBBC5Mwcse96DxMzobZA8Bg3c2lI2Zab1+
         YaVctQqB4l8KE1f4NhlMgFamiUBgPdBiUcixVdpo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200608163626.7339-1-idryomov@gmail.com>
References: <20200608163626.7339-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200608163626.7339-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.8-rc1
X-PR-Tracked-Commit-Id: dc1dad8e1a612650b1e786e992cb0c6e101e226a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95288a9b3beee8dd69d73b7691e36f2f231b7903
Message-Id: <159164672399.26583.16571782263097298968.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jun 2020 20:05:23 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  8 Jun 2020 18:36:26 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95288a9b3beee8dd69d73b7691e36f2f231b7903

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
