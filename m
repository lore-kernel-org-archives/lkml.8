Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43107C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBDC24686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580238604;
	bh=+uDVMUtEhs6pzXZEV7Sqgzktkr4wtz6oymBKV1GL0Xk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Fb/xFYAWBpwFVzSUmHr1HBup9DbmgYqyJ4RepOZKgVAsTmEUQoNbant/LbwVhYEBG
	 XSmimf9fhm3vghtA2cr753ycjMxUH3HBF1qJixeGzhIb6CSiTm/emLIJBahAGz6p5W
	 Pj6TZLyq0dhsigFBFSFzUtXsikK3yuT1cYoGoJ5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgA1TKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgA1TKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:10:03 -0500
Subject: Re: [GIT PULL] perf/core improvements and fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580238602;
        bh=+uDVMUtEhs6pzXZEV7Sqgzktkr4wtz6oymBKV1GL0Xk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lWFlKNbGWVkMPPP6xkGl5Yj7MEMMHj6z5Olhg5ZNn2TBoq5Zy7Y4xbhciHXx2ZoRz
         lPvVya6rp4diPoyyxCHYg7utecIUcFaBCcDPiiAplu4bfieJ27ccKB6Uks6JGewXpM
         iFhdg+WnynGkuplVDNVcr1FkG2HJwl+ZLJOZM/Lk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
References: <20200106160705.10899-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200106160705.10899-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
 tags/perf-core-for-mingo-5.6-20200106
X-PR-Tracked-Commit-Id: 6c4798d3f08b81c2c52936b10e0fa872590c96ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53f3feeb7bd2d78039b3dc9ab158bad2a5dbe012
Message-Id: <158023860252.9583.8458853393585082822.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 19:10:02 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        David Ahern <dsahern@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  6 Jan 2020 13:06:45 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.6-20200106

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53f3feeb7bd2d78039b3dc9ab158bad2a5dbe012

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
