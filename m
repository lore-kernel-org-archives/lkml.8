Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B6EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 20:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E452176B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 20:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595188808;
	bh=z/g+wCEJr8g3uzhDuU3oIBSzRLMwVEcdTJMQ4orva7A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=r0vqDTmn8OMLOZXYoyYZ+yETIneWRw+Zn0FV7rPWp12+i0cRg1suMTVxO3I5mH3iW
	 yn2vjlNoWW9A/bqojC/RHh9ge7fry4vsfLJHomi9Dr0YhWDnHygr+4yWrII3j9t/3o
	 rCz2fmH8+qdaf4yTPIOBxi9bw+qZUL9I3gf0jUWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgGSUAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 16:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbgGSUAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 16:00:05 -0400
Subject: Re: [GIT PULL] perf/urgent improvements and fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595188804;
        bh=z/g+wCEJr8g3uzhDuU3oIBSzRLMwVEcdTJMQ4orva7A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=srbcNChHh2o5pw1b7Lxw1DSiELjdR2E73DZEn8lYilXgAJr2mFJbDrmpQwvLDJbH6
         LY3ndCvFRfhtvCvKTrmVOo/UUqTTM3NgfJH6zXDHB5lO/E5h3AKknucueh6DaJDIW7
         WJ3EQ3XPOHcuKI5zUUy5E5t5qx1bEkI5U+qB4GTI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200719130205.2430019-1-acme@kernel.org>
References: <20200719130205.2430019-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200719130205.2430019-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
 tags/perf-tools-fixes-2020-07-19
X-PR-Tracked-Commit-Id: 25d4e7f513d4f8afcf81cb6f00edf1248b0ff8fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92188b41f1394d5e4399fcb28c13a2933f255255
Message-Id: <159518880470.26827.6862364227829609113.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Jul 2020 20:00:04 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Jul 2020 10:02:05 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-2020-07-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92188b41f1394d5e4399fcb28c13a2933f255255

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
