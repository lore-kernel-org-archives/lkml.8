Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5D1C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 07:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8624207D4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 07:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593846010;
	bh=Esf/u3g0UCsx63SOgBCESKQcNNwEoGToFfryVAiBXcc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZdIIVMUgn3a+xs4z+/qfpBqoE0t5qJ1Xjuz0fhbeGgdDbZK02ylrPPD5bv2L1lqBA
	 wx8XGD4MXEU/pHV5uI49wPrgxbm5WXTbLe464UMFHErpdosEeWpDkeYVaJVp6PXlsb
	 FTqWdmbZ066Ko3n+DiLcc/e9N2j3GlQGwYzE1FgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgGDHAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 03:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgGDHAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 03:00:06 -0400
Subject: Re: [git pull] sysctl fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593846005;
        bh=Esf/u3g0UCsx63SOgBCESKQcNNwEoGToFfryVAiBXcc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=myIPJaLi9LnjoXDPxUe6fr3ny1QALsLFX54Hb4Qf6d+qvxNCy01gHluL8F+S/4wLy
         k3ohpCTqVhOHgrCicsBJ7rcXyeLND7qjh13pdKyQQuHseLc84n9ZWX9huKqVBM0PKB
         2JmfitxfSqf61waXQM9Pd64/uO2gAgtbjsyiECeU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200704050701.GB2786714@ZenIV.linux.org.uk>
References: <20200704050701.GB2786714@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200704050701.GB2786714@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: d4d80e69927ab5da67026c1c94e23c305dbc799e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b082a41dae7d420db649bffe86cf5af62121f11
Message-Id: <159384600533.10337.9266764581349579209.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Jul 2020 07:00:05 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Jul 2020 06:07:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b082a41dae7d420db649bffe86cf5af62121f11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
