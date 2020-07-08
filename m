Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6185CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 00:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A7A20771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 00:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594166706;
	bh=bFz0XD3XXeJwo06qMWGrcu+03e11AsmfH/V5+bjZrlU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DJx9XDUpIIiT+luRXzQq0O72KU9yaX26PAHyf7IlYKMG9n8eJ+08qpRHL6bmrKYr0
	 Fkrl6EaFzx+/6wcMtvVCUP3NurK3RnTbigtELK/Y7ENSdxTn/5w5lvIyXrEjRMNrXm
	 FcvPgNStOR9XETgEywNTZ6nJVM1NWyjwjEwF4C+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgGHAFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 20:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbgGHAFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 20:05:04 -0400
Subject: Re: [GIT PULL] Second batch of perf tooling fixes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594166704;
        bh=bFz0XD3XXeJwo06qMWGrcu+03e11AsmfH/V5+bjZrlU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=l5/UGdGT1IIKZNS1gEdOuHQrOFEr8V5+P9bwfAtQ0CYB5geP+47MV4VjuTqXHr3zh
         yWnPqht4CwmN6inTPZtZd1XZUe0RKsvikhBsqrCIA2gqoCav02eftaGmVddKsjFYXe
         gM9Vhncfg3x0mBAmYEKvdaDILCir8Kt7FlW+B/Mc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200707202450.23345-1-acme@kernel.org>
References: <20200707202450.23345-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200707202450.23345-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
 tags/perf-tools-fixes-2020-07-07
X-PR-Tracked-Commit-Id: bee9ca1c8a237ca178f281062bf162637071ab04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dcde237b9b0eb1d19306e6f48c0a4e058907619f
Message-Id: <159416670428.16656.5257808883488752855.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Jul 2020 00:05:04 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andreas Gerstmayr <agerstmayr@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Wei Li <liwei391@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  7 Jul 2020 17:24:50 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-2020-07-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dcde237b9b0eb1d19306e6f48c0a4e058907619f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
