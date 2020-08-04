Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCFCC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4E822CB1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596577212;
	bh=maxnV1epqNNixHTGH/sQ8yQ9/x9HWx4UxFuH7B2aSXU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KugUPWTNAS9bfopolqLUnfuKZze8aX7v8Sbu08Q91oqvX5KNdg2JF8wdRsMizVu3Q
	 Lgn5Od82SbdXTzR6m3arZA1Y2TArp+xfFMQd+Mgvxu4gSjSBWcrQaXlPvgbxj/O0PT
	 +jIw5EVCiZyymIh2vkbQCl2nLIydN7qNOtPOWBaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgHDVkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbgHDVkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:40:09 -0400
Subject: Re: [GIT PULL] gcc-plugins updates for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596577209;
        bh=maxnV1epqNNixHTGH/sQ8yQ9/x9HWx4UxFuH7B2aSXU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yuLwHCECtShMGyYedjYlcYZPKAdC2PwekO6VR5uKDEdyuaWJ508SIHtEpFZ1fz6im
         y1w4vDBL7+TuYR/TVqmr3faUydNnTTabWrq1ANFgkB/S2+afjzZS+F4PLjROfFxd7q
         YU5GPvFnwxZSKrxW73Bq57WRn5H87iq3dUUFLYdY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202008031150.63BAD93@keescook>
References: <202008031150.63BAD93@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202008031150.63BAD93@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/gcc-plugins-v5.9-rc1
X-PR-Tracked-Commit-Id: 496b24ec6d47f2d304a0c5836ba4b1bb5d30bab8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e4a12a1bafafecaf1631f02099e82b424967718
Message-Id: <159657720909.17686.1274329466782739946.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 21:40:09 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Alexander Popov <alex.popov@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 11:51:29 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e4a12a1bafafecaf1631f02099e82b424967718

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
