Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C75EC4345F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 353AA206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595626822;
	bh=slEEdAte+3RZRNr6CPInbQkt4P3t0mEJsH/8BkMkXRE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ncBYmY6MynpUsLG0NVBu0fTrSzjO6xYBmh0VRl8PybagN6t4MrlheOPCIhOV734a4
	 e+H2QKs6i8EOJUCr3aGrptsSsbbJA9w67cHT+DowcWBMOV+Zjnemfetfen9zVR/zB2
	 lflXSNTwYLL79sbK+iskt+yjkLLBC5PnhScTx85Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgGXVkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbgGXVkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:40:07 -0400
Subject: Re: [git pull] xtensa csum regression fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595626807;
        bh=slEEdAte+3RZRNr6CPInbQkt4P3t0mEJsH/8BkMkXRE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=x3Jv0rrcqkU7zzLGTblSSYeeMlbDDdaaSdYSSwbsxWTY2WMjew+k3/rc9rgv5y1sg
         VFPPQJVL9lnCBaw6burOOPZ+HfQUgksshdIxrybNjlv74/HbK9KWlD/Z/xWTxh+IgD
         0kWVvQQ7iuRBXlXwpD6OM4+8b7YSIryjuHLsY6+E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200724181644.GN2786714@ZenIV.linux.org.uk>
References: <20200724181644.GN2786714@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200724181644.GN2786714@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 5fff09bc141570cd15c118b097b17dec832b517f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c953d60b1180c4a59a55b72fecd278d264d60f5b
Message-Id: <159562680706.3064.5349217479253905359.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jul 2020 21:40:07 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Jul 2020 19:16:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c953d60b1180c4a59a55b72fecd278d264d60f5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
