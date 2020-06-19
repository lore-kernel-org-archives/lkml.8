Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE263C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC91420707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592595027;
	bh=x6QnEUI9EDQlZ40p1wD135xUtfgRj9k+Enu9q9Z/N90=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mAuhZ5Ehu3KErzwo6HNUd/vqL0hu+WxAq9i8qtdGrxcy1zVHSFiZrq4tlv2duQ9A4
	 vNYGI+2mhDcWZDG4uCS3THW3Lk9F9WNpb7fNjdDv6a4P10uBiSRE7WdmDCPbE3OeEx
	 GgQgANC9TOBehXD/fTHz/ji29xFSRcsnLU8D9+FU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbgFSTa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387867AbgFSTaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:30:23 -0400
Subject: Re: [GIT PULL] perf tooling fixes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592595022;
        bh=x6QnEUI9EDQlZ40p1wD135xUtfgRj9k+Enu9q9Z/N90=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yOO3mxp9C88EFxj4YJfP6l377JbD40eJfopT4AnaB/LoqFkBOg+l3gvKLYHWGQ2AQ
         OYfU3Hk40P/CgnZkGp7WuoKwX5rSr3Xs7JQY+AxEdLR+4G2kn0dAbSY9TRhzvgSqT1
         60LZC1oI8fM12PPQDo99UnzBqk7caPZgphOjKMa4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200618192840.4519-1-acme@kernel.org>
References: <20200618192840.4519-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200618192840.4519-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
 tags/perf-tools-fixes-2020-06-02
X-PR-Tracked-Commit-Id: 6a1515c962b17e2596ae7b9f074fc5685d6b435b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98d7e741a0a37fff24f99e4b6c5a1bd1e50cd47a
Message-Id: <159259502282.2705.16542690620448124686.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Jun 2020 19:30:22 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Gaurav Singh <gaurav1086@gmail.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Jun 2020 16:28:40 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-2020-06-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98d7e741a0a37fff24f99e4b6c5a1bd1e50cd47a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
