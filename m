Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA43C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F074206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591989965;
	bh=n8TjGPlzZHBN3WuBTWOI5Lhh92feVSg1DUZw+cdVaTQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yjZov6onu5KYfjmcUBL4ujYGgn/HWK24RS9s4yJacFIE82pkVkoOE7wAkTuCOhMey
	 g6bvKZ7rMIJQ3+H/XCZPM+HfeQaqfhJjsH9DbCTZlwB3meA/PgmhnxH89tak6bMhbz
	 sLHaLrSwC3ta9FX4saTyEns3yLHiokA/z3hg0/3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgFLTZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgFLTZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:25:29 -0400
Subject: Re: [GIT PULL] arch/nios2 update for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591989929;
        bh=n8TjGPlzZHBN3WuBTWOI5Lhh92feVSg1DUZw+cdVaTQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zc4aWD+wxQakKJKd44jz+Cd8vmDeya+QtJMq7gqU4Q8WmFg+ItgI7jlsLsVbaK1ML
         c/qFmjiJ7sUIGgfj3G+v1ZbWodyoU6T/DGJFSHO0tp/0H+YG/LmGCv5/jhjTNKgk7V
         4KqwAjWI9p7fIvmAeYTkSP2iGqxzZxV0OKsNGjC4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <BY5PR11MB3893D9118F509981F5612029CC810@BY5PR11MB3893.namprd11.prod.outlook.com>
References: <BY5PR11MB3893D9118F509981F5612029CC810@BY5PR11MB3893.namprd11.prod.outlook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <BY5PR11MB3893D9118F509981F5612029CC810@BY5PR11MB3893.namprd11.prod.outlook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git
 tags/nios2-v5.8-rc1
X-PR-Tracked-Commit-Id: 6b57fa4d374bb8c005dee396c56598c14b9c01a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7de26c41c19fc7b2e078d31fd039e1a017064b89
Message-Id: <159198992932.4050.12321009333314946641.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jun 2020 19:25:29 +0000
To:     "Tan, Ley Foon" <ley.foon.tan@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ley Foon Tan <lftan.linux@gmail.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jun 2020 08:13:51 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git tags/nios2-v5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7de26c41c19fc7b2e078d31fd039e1a017064b89

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
