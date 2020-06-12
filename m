Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25018C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 02:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05B9B20853
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 02:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591927835;
	bh=SapbRGy+tBBaH9xyi/ooRH0bYVMjRuSyJQ7XCH6tWC0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Dl9DJ+BYoWfHwqOCsl3nNLN4gVquqT4UTxdY/WdGjByrfHSQ2cemCB3K4uzn3aFF2
	 O9Wwf+vWOoUYd1GWksObqRm4Z6HZ/iQRQnrhFTwPHCgBpwiTVMOKtB6Fk7SfFJdeAk
	 V4dcQCZ5NSZXRRrwqYhB3X2fgoTa+byKQlqQQIQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgFLCKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 22:10:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbgFLCK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 22:10:28 -0400
Subject: Re: [GIT pull V2] locking/kcsan for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591927828;
        bh=SapbRGy+tBBaH9xyi/ooRH0bYVMjRuSyJQ7XCH6tWC0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=davQPN5jHQfQRBDxOrkwiHDlvOi/jh2krBIBeU4SYgbqWMU7jMxOKrsBc0y0IeU4T
         E1/VkzoW+v4nSHcVRgZ9NXxaA8GJTAjYIeVsnMiNEWnKXX2sBG234NWJuoBPjewOQr
         ASFM5JsQQxRCHKjp4M4OrEZHWfxO3c+r+kUQohEA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159192148975.1475.16272172258276079370.tglx@nanos.tec.linutronix.de>
References: <159192148730.1475.8112596092479045470.tglx@nanos.tec.linutronix.de>
 <159192148975.1475.16272172258276079370.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159192148975.1475.16272172258276079370.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-kcsan-2020-06-11
X-PR-Tracked-Commit-Id: 1f44328ea24c9de368a3cfe5cc0e110b949afb2e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b791d1bdf9212d944d749a5c7ff6febdba241771
Message-Id: <159192782831.28098.9074267506729348260.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jun 2020 02:10:28 +0000
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

The pull request you sent on Fri, 12 Jun 2020 00:24:49 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-kcsan-2020-06-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b791d1bdf9212d944d749a5c7ff6febdba241771

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
