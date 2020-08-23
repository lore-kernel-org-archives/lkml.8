Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13575C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 18:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCBF120656
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 18:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598207971;
	bh=KAo7p3+/CkMPBRIFXyoz2K+9gUhqmXjS0w51MKyL0pE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ILgIB8RElLKzkiQSxaJD4jwDtenWPgqHdwQ6HaourlcWeAR3XBU2BnS0eNEwyWmsx
	 aY3kL6Vut3S4LBw6ubG14nf0SQK4p5MPqhAEgjqZ6hyS4435CzQkuuHb706jOGOlyF
	 rTxyW3EpRpNvj07WatviH5ixT5uAtzOqugGIrqOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHWSj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 14:39:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgHWSjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 14:39:24 -0400
Subject: Re: [GIT pull] efi/urgent for v5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598207963;
        bh=KAo7p3+/CkMPBRIFXyoz2K+9gUhqmXjS0w51MKyL0pE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=akNdxEc3UhzVWUWQH9ssBDEDRs7UiL4CRS3MQBizzNus+wW3eOAQS72AXnyAhlfjf
         5PCernOJndZCCzZYlwYkIna2l10oLQHFVsqbxOuhBrbJXls2W9mJjf6U1KqHh8fbLP
         UooKiU1AqFI2GIQDHBIlhIt3CmwQt4MWZrpXD4Vk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159817113521.5783.17455022106783691165.tglx@nanos>
References: <159817113401.5783.14776307451257171431.tglx@nanos> <159817113521.5783.17455022106783691165.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159817113521.5783.17455022106783691165.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2020-08-23
X-PR-Tracked-Commit-Id: fb1201aececc59990b75ef59fca93ae4aa1e1444
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10c091b62e7fc3133d652b7212904348398b302e
Message-Id: <159820796394.12134.89042346103752538.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Aug 2020 18:39:23 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Aug 2020 08:25:35 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2020-08-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10c091b62e7fc3133d652b7212904348398b302e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
