Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141AEC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 18:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E33722076C
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 18:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591553442;
	bh=lFWKhs/k3D5sRQVqp62uTaAiMS3/6cXwk04ZFTG9R/c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DZvk3psIh0HBRLmOk48o6bgZhsrCW6O/ozxPFLgQuIuxMK8uGuZkDSsm3DguSv1Bg
	 AmEu7jFQZraL8x1p5qrh7ySwhJwndfeL4xkP5+L0fPOmP0RlIlaFKmhZ8IaHbdBmw1
	 wQFeUmGlqcIzQWCa8qs2iqLSLwY34g0aPajjwCaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgFGSKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 14:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbgFGSKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 14:10:20 -0400
Subject: Re: [GIT PULL] TTY/Serial driver patches for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591553419;
        bh=lFWKhs/k3D5sRQVqp62uTaAiMS3/6cXwk04ZFTG9R/c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rdvl2ts3GMb+vh4k4l66XQEzuZe9r7CPTRdNyUcAyhJcW13Vin9nhXhmOMHjUysdl
         oTbye4+lKmtAnOp+TsU/NCDxFMBX8AMRLIFwo6N8qAxfaNVAeAvxQTjuUDudvDaqyY
         qviWbn5CejmJNvDWaqqkhXDIe3w1xR1COJrX7YHQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200607132723.GA168173@kroah.com>
References: <20200607132723.GA168173@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200607132723.GA168173@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.8-rc1
X-PR-Tracked-Commit-Id: a1b44ea340b21c99b34c93acad233da727cb88ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 081096d98bb23946f16215357b141c5616b234bf
Message-Id: <159155341986.28494.1970838386926667880.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Jun 2020 18:10:19 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Jun 2020 15:27:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/081096d98bb23946f16215357b141c5616b234bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
