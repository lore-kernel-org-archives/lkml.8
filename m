Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404E5C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 00:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 159A320789
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 00:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596326416;
	bh=7K6jS9xjmDRqMhEw7JOuVX/JnfJe7FxXBMu467koF1I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vXNryR4roUR56fbIGL/KOZvFTTpX7ksCnqmy4ovcD0XQ/p111uK0LELGtIHT2rB/z
	 76tEM0QwDkfJczYN0n0j9HB2UVGMwtDlC5vhtQA5s/2g6j9Nt/Sc2WLhrDaleK0a3w
	 cbg+f0uw5ZayC4YO3DEzrvdkhYU8zzsx9qB2wXHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgHBAAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 20:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHBAAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 20:00:04 -0400
Subject: Re: [GIT PULL] Fourth batch of perf tooling fixes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596326404;
        bh=7K6jS9xjmDRqMhEw7JOuVX/JnfJe7FxXBMu467koF1I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pfdkSo7Jxu3Wd6a0fte0rqk4Qh42c1JLQs1qoM1sM8vB4BPuJ961vNq980wWwFnoy
         Mq4L4Pf41gfwYDFbmAKNcqjsK0kabBlIob1WSvEhJjEUV6C7cmSap2Q3fiWeXOklKC
         oZXKUmpJ3/DvyHbo+ICJufoAjmfwBillvqyvKLoY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200801190618.3311731-1-acme@kernel.org>
References: <20200801190618.3311731-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200801190618.3311731-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
 tags/perf-tools-fixes-2020-08-01
X-PR-Tracked-Commit-Id: 39efdd94e314336f4acbac4c07e0f37bdc3bef71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf121a0bda29daa67a1fcedbdf479f6b03c9f977
Message-Id: <159632640437.16599.15587396153041720392.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Aug 2020 00:00:04 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Philippe Duplessis-Guindon <pduplessis@efficios.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Wei Li <liwei391@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  1 Aug 2020 16:06:18 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-2020-08-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf121a0bda29daa67a1fcedbdf479f6b03c9f977

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
