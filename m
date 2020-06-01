Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC274C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A848D206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591040131;
	bh=RP4AHdvGM12+pKFGYNto5gPUKAllwL5cyIUdUqaiS9U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=w2UQg7ny7IyJsVIPJUxxgJqTk/McN53WzSp0Y4MvVrdfLi6Z1OhHONBNdcr3LDop8
	 /vRamIOxwburrHFvpJvjZHwuz8rFpzYhSQx+VB2W5diPi8fJPV/q5fcsaZ72CuwWDu
	 GAlfAOhpPkIkHgTGyitbWAIKBIgfkx6Dtpsn50Bs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgFATfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729633AbgFATfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:35:13 -0400
Subject: Re: [GIT PULL] x86/cache updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591040113;
        bh=RP4AHdvGM12+pKFGYNto5gPUKAllwL5cyIUdUqaiS9U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VtrtlIMgn2OSjDRqrUsBExn+EmoWC2GwHHLwsI0DeX3BK7Ptd28fYawmnuF/SS+jr
         15U2gUjw/mZkEHHvdxajY3m3rGNKkfn1uSchIpxF8q5G/MwsD7iK5YX/0t+K8Jhmw9
         IXkP61B1Xkp4IUOnj9MfMxfDyuWW0yyLKAx0YMCI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601170903.GC30795@zn.tnic>
References: <20200601170903.GC30795@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601170903.GC30795@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 tags/x86_cache_updates_for_5.8
X-PR-Tracked-Commit-Id: 0c4d5ba1b998e713815b7790d3db6ced0ae49489
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bf9511e3d9f328c03f6f79bfb741c3d18f2f2c0
Message-Id: <159104011330.18844.5864759241466276106.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 19:35:13 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 19:09:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_updates_for_5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bf9511e3d9f328c03f6f79bfb741c3d18f2f2c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
