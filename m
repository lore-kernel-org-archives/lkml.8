Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE5AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 02:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFEED20878
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 02:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591927831;
	bh=+3L9jIEIC48bLSHCoh3X82RXTvv/8Bj9cKyewmBkI7o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WydD0sjpHYuqGsSy6OtJ2eY70UQw+IqvWeprZ3fOXn94Iuag3C6X/98HGSGsbaNUa
	 gp0A2hm9HkN8QxudqD9Ntg9xrd7niWCn7WBmJPL/0ePh+HY8UJplZC3cH6DDxAzUMO
	 bFrvn7O+POvKPSe1ZEDnbo2cSroux9NmIirZUs3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgFLCK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 22:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgFLCK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 22:10:28 -0400
Subject: Re: [GIT pull V2] locking/urgent for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591927827;
        bh=+3L9jIEIC48bLSHCoh3X82RXTvv/8Bj9cKyewmBkI7o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tsugd/dk3WoOdRceZZsuW2TqZZnWQiPsie+E2EJ6jaGTYjVlZ3DI/VF9J/JbXgYWX
         abOwHL8u2b+LeBkFm+q+IbHmEiE/NJSQTmv3oK3cuPpZf0QBecXqDUfmrSYm3j8Ugi
         4Q91601+/XWFg3Hhn0hu/GZjj9ytW0UvV8oAU8AY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159192148852.1475.15416757527255848556.tglx@nanos.tec.linutronix.de>
References: <159192148730.1475.8112596092479045470.tglx@nanos.tec.linutronix.de>
 <159192148852.1475.15416757527255848556.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159192148852.1475.15416757527255848556.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-urgent-2020-06-11
X-PR-Tracked-Commit-Id: 37f8173dd84936ea78000ed1cad24f8b18d48ebb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37d1a04b13a6d2fec91a6813fc034947a27db034
Message-Id: <159192782781.28098.17936734561356496033.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jun 2020 02:10:27 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jun 2020 00:24:48 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-06-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37d1a04b13a6d2fec91a6813fc034947a27db034

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
