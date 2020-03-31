Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BD4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 03:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8539B208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 03:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585623617;
	bh=VukL9bu/3cyFMX7SSWyUJThG+dplD7kb0sLuZNDtTXs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AVBs3R2NKwV7KUxVEUapm8IrMKaP5icmWTMbmuqLrX9CM7IPkjNdkvfAjiWVH5JeZ
	 xF5+V/fCveR4NhUYkt6/U1WOxfh3KHcR+ONAYLL+ZDJQxZ58eQqeFGPyS0A5TNWOCK
	 nMbLmZupDPAxnWEezr9gzcOWp/FoeRNOBVr9Xmx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgCaDAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 23:00:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730280AbgCaDAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 23:00:14 -0400
Subject: Re: [GIT pull] x86/splitlock for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585623614;
        bh=VukL9bu/3cyFMX7SSWyUJThG+dplD7kb0sLuZNDtTXs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bRj1h7yLKjw/63hMaClKF5UJeVzm0MZ+qRUjwi/3ww6dUce4QRfJr0TMQeIeAmJEs
         kzdbk7o+XPg8+vKFOQa3DzkWCfpjDiAWhqQ0Gl5X0z4B3HKIUgIjzVDts/m/MOTJcb
         TfFf6zcDqjwUvAzbuxrw+BB2ClxPj7mAB8zBSuww=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158557963557.22376.16443742264836974381.tglx@nanos.tec.linutronix.de>
References: <158557962955.22376.9136086165862170511.tglx@nanos.tec.linutronix.de>
 <158557963557.22376.16443742264836974381.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158557963557.22376.16443742264836974381.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-splitlock-2020-03-30
X-PR-Tracked-Commit-Id: a6a60741035bb48ca8d9f92a138958818148064c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2853d5fafb1e21707e89aa2e227c90bb2c1ea4a9
Message-Id: <158562361396.8590.209811273314510607.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 03:00:13 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 14:47:15 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-splitlock-2020-03-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2853d5fafb1e21707e89aa2e227c90bb2c1ea4a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
