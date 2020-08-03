Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E66C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B8622BED
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596492618;
	bh=4+g7dAyXxVj1q45mbcSm9a587fFBry3ZzevUCBHeQ0s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tmS5cH2Cc/CBQkCN1/D+hkYm++Z0tRUiJtmFPQ6tn89894rxnErZJcBb6ffUUqvoT
	 EFod2xzQh9F6/OjBI7zdyP0SKhGc/WForll8SXskWD6cGaYK58ZTx9tMjk7HR1nqPD
	 SgVWfxBImzI+hIs+L0zfL+TjQDzvA5Wpqa1ZR7lM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgHCWKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729511AbgHCWKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:10:06 -0400
Subject: Re: [GIT PULL] perf events updates for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596492606;
        bh=4+g7dAyXxVj1q45mbcSm9a587fFBry3ZzevUCBHeQ0s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Yk70YXMEpe1RYt0MJsTpXEKAfVrhJkS7iaDRVyQkkNCK6qzt1OG1tiSLfTcNdIWjp
         WXON4pUSezoNmHE6EF86eQkENueCv5Cowe1Ku3j6QiVP8bNu2MtzgOqbhSFfDafAQB
         ZMNCi+st3t3Rg+YYl/alCHwKdg7vP6Qej2X70+TM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803123729.GA567306@gmail.com>
References: <20200803123729.GA567306@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803123729.GA567306@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-core-2020-08-03
X-PR-Tracked-Commit-Id: d903b6d029d66e6478562d75ea18d89098f7b7e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b34133fec882d2717f2d61a2a010edd3422368c8
Message-Id: <159649260652.26696.6489057376367161606.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 22:10:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 14:37:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b34133fec882d2717f2d61a2a010edd3422368c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
