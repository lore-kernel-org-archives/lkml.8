Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724BFC4332B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A10C2071C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586022624;
	bh=O/M0Xi670dJt4pqqvin9h8KSuZtxbX8f16RD5Ztc2aQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IKO79mNiQ4iVwDNgeu78J1dYiY/uCtkBKWfJXzTKAUJ9wNwB0TWiN4pyp1jQ+SuVI
	 W2f7RM9UsdAX4igF3XRAxQqquu+n4P+foF8HqGmujmKghLwemXuKPi4hY+SU7uPA9a
	 WUXlJhald78blM18x8LEf9N4pZgsqDr48lPg+Co0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgDDRuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 13:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgDDRuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 13:50:23 -0400
Subject: Re: [GIT PULL] VFIO updates for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586022622;
        bh=O/M0Xi670dJt4pqqvin9h8KSuZtxbX8f16RD5Ztc2aQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yBVQsBwdA5F6iW51CfrlFIxf67qS7GaJ4QhJCdPqiKTBJEWs5k++Fa7tRTZREH583
         BGYtWgrK284Cl4y1GtG+DpzjGBmk9HM+s1FfRLkA6V1wd4V9XW1/aPJGxkDtZsja0P
         5sdYiPonMkWEHFhOoDDZTJuQ1Q61xghgxePmLBDE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200403162242.5e4f9afa@w520.home>
References: <20200403162242.5e4f9afa@w520.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200403162242.5e4f9afa@w520.home>
X-PR-Tracked-Remote: git://github.com/awilliam/linux-vfio.git
 tags/vfio-v5.7-rc1
X-PR-Tracked-Commit-Id: f44efca0493ddc1e8731047c234ec8e475943077
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2fb732b33b0f4d73f391066c0a970b942c600dab
Message-Id: <158602262259.31764.3687805120660330306.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Apr 2020 17:50:22 +0000
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Apr 2020 16:22:42 -0600:

> git://github.com/awilliam/linux-vfio.git tags/vfio-v5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2fb732b33b0f4d73f391066c0a970b942c600dab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
