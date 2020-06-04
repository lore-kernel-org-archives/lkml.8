Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08906C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6BC52067B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591305314;
	bh=Yv0h5JWVY2hpKhBY0LxydSI72GdrkFJDJ7DS9VuepjQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ggvRPXfoAxxWiM+jIscVoThjqcRDOaNGlWY/IFGSa8UKl+AOAX2MRa5vOGoSKvsHd
	 RVEtYfWen0JwaWlFFexciMyQuFFb/lQrd6AjDmOX/EbvKU6l1EmUpmjLVgMqB5YrOj
	 1sSWVt/Zsn9Ik0xuX5kAN8Xw0NGcKaeI46xz0Qz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgFDVPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 17:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbgFDVPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:15:11 -0400
Subject: Re: [GIT PULL] proc changes for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591305311;
        bh=Yv0h5JWVY2hpKhBY0LxydSI72GdrkFJDJ7DS9VuepjQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zV3tKlbY7e76hsAgAfm/jrtfh3JsZljljTJpt03jUX6+g9SNxLdQrddepkiuU1N2h
         cEiHcoGWjbwYnCU+fxb2WCYiv1/+a0h7ScYr++SZh4E2nclttLO5aJih6WRzZYsA6i
         BXPBV771UFJQxewcP/Giugtr6Ly5ON6j174J7WKo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <875zc8kxyg.fsf@x220.int.ebiederm.org>
References: <875zc8kxyg.fsf@x220.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <875zc8kxyg.fsf@x220.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 proc-linus
X-PR-Tracked-Commit-Id: 9d78edeaec759f997c303f286ecd39daee166f2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ff7258575d5fee011649d20cc56de720a395191
Message-Id: <159130531151.6506.15493334980174318527.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 21:15:11 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 03 Jun 2020 09:47:51 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git proc-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ff7258575d5fee011649d20cc56de720a395191

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
