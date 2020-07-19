Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CBEC433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 20:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C7F22CAE
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 20:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595188811;
	bh=/869dRUqDCyzwmif4yC4i63gYrUNbKFOdfv0XjtQlr4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=glYXsvEVzUQPrFwIANWtApSWxBEPY9qUQyqbmlqNkkUVb8Alr6R+izfyntqKg8zVC
	 Wo3TvSYZjXrOnvQZb/a3jVgaamlXSjIk4w5BLWLbA4hVPRgk8XlRR6DIfaVKsK3cpc
	 Ligy5tgXTnejVtqYEG7s6yAyu0ZPbnwui+XYX6nA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgGSUAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 16:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgGSUAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 16:00:06 -0400
Subject: Re: [GIT pull] x86/urgent for v5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595188805;
        bh=/869dRUqDCyzwmif4yC4i63gYrUNbKFOdfv0XjtQlr4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zqJp6iuq3xapjUmxfbAKMoMXiu29EuMf+1LPm3sXQrs/2pbTTU1xVZAaJCAHbCODi
         VTtDnmlnDbzm51KgQHTZup68z61/mu961trVDHA+1CipHV4Xd4WMZ+GD/6ey/GIgvZ
         5Fgn47fQbx6brK6sXNyydzmZvlMamSuV+XdjMpIo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159516469375.4147.270001582364335381.tglx@nanos.tec.linutronix.de>
References: <159516469014.4147.6471285397574034610.tglx@nanos.tec.linutronix.de>
 <159516469375.4147.270001582364335381.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159516469375.4147.270001582364335381.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-2020-07-19
X-PR-Tracked-Commit-Id: da05b143a308bd6a7a444401f9732678ae63fc70
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efb9666e900b6f8f079adb2ab18a7be266434cd3
Message-Id: <159518880590.26827.3413394578759470686.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Jul 2020 20:00:05 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Jul 2020 13:18:13 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-07-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efb9666e900b6f8f079adb2ab18a7be266434cd3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
