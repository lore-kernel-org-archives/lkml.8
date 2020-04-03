Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC0DC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E082082F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585947041;
	bh=DlPCdeWv3vePua5ch0XSErG11m6aV64AKbQrEQlnezo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0cBSLex3WZpMZOSDSrylym63LKeZzDllF0ZI3+vpFx65r72t5GEHtc/QCUYXPr6RL
	 8cRhoeqihJG6HieYi1J33oQZLUtHQSouNh/HX1Q4B69DRr28Amyyjl1pZCR5tBRF+D
	 jFh4U4l7f2oIV4/jPwOo/XqEx3/f6y4GYTuh5eb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgDCUuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728108AbgDCUuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:50:19 -0400
Subject: Re: [GIT PULL] cgroup changes for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585947018;
        bh=DlPCdeWv3vePua5ch0XSErG11m6aV64AKbQrEQlnezo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YY/OgPYaHSEmpA5tpc7rQT0Y0B2stm7nrBHwEBtTdze+gwJxNrjMNnewZpNPMEn8B
         Cf7cxmShDJLfvjjl5kK31cofpK9FN/JYn/HSgq+oYpespsLSR5jNcSqObgnpUS9yyh
         DRjlhjzzF21RY41QzNbzzojS+yafuybxyD5rjbXE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200403155243.GF162390@mtj.duckdns.org>
References: <20200403155243.GF162390@mtj.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200403155243.GF162390@mtj.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.7
X-PR-Tracked-Commit-Id: 0c05b9bdbfe52ad9b391a28dd26f047715627e0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8836005236425cf3cfcc8967abd1d5c21f607f8
Message-Id: <158594701850.4594.1736276801098098729.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Apr 2020 20:50:18 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Apr 2020 11:52:43 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8836005236425cf3cfcc8967abd1d5c21f607f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
