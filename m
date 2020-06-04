Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18626C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB9CE207F9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591295122;
	bh=Ri46w9aH+hcb5dojslGGxtuTxDP3Ok5w9s2kHVDFIFM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IDy6uNZzibMFJ1vp+ccomZjS0Vg5K5CEz/8j4dv9suc5OSMUZxnPTVQ1XItINhoC9
	 /fm156Hux7MjQydb/q5N3DgbtTL90HjUUbBlQL8XmR79LNGlJAJz+78fl0vofZn+d3
	 TLP5HUjlq1pUx92NhMXpNPutomJBTR4peKFgZqtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbgFDSZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730434AbgFDSZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:25:15 -0400
Subject: Re: [GIT PULL] LEDs changes for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591295115;
        bh=Ri46w9aH+hcb5dojslGGxtuTxDP3Ok5w9s2kHVDFIFM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Mp1HNkzf9M/Vts2udph5HfXoQURJIGWg7voQktq8f84KtYU8u8+bubIeP1U+F/m2F
         xmthWHunz4Du2lS7oWz9hteXpO6EQdk04Ussz0Izyl2Fj81OCseW1nkbYfX+VOhwMt
         dNdjWea0n7DGHYIzbNsBK5oDwxv+ZVdQ8xdTHcU4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200604121905.GA4931@duo.ucw.cz>
References: <20200604121905.GA4931@duo.ucw.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200604121905.GA4931@duo.ucw.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/
 tags/leds-5.8-rc1
X-PR-Tracked-Commit-Id: 59ea3c9faf3235b66bc31ca883d59ce58b8b2b27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86c67ce20d080bdfefafd461d3068cad0a49a66b
Message-Id: <159129511534.18772.2353289185245530089.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 18:25:15 +0000
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Jun 2020 14:19:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git/ tags/leds-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86c67ce20d080bdfefafd461d3068cad0a49a66b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
