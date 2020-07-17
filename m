Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838F4C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6149C20B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595007616;
	bh=WlQPQOWds4+bw+jNUyohYzSNQzQakaqWQJcneG1rlv4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=UTSeb6dFb3nUvWCZxF9jW4ykubPYHJoVcSAwi4mRWgK52JmfC86HNNFwky3mKfbuK
	 1R2TiamVXWazzMSugbbfkEIW6GBTSOkUeYD9+uM14VHpfeUY6dDOFRybODK6WkmPoh
	 Q9rLKATVrzmsRCdL/8CGO6upuLItShnwwhSdzrkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgGQRkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbgGQRkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:40:07 -0400
Subject: Re: [GIT PULL] HID fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595007607;
        bh=WlQPQOWds4+bw+jNUyohYzSNQzQakaqWQJcneG1rlv4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KYpr8PSXatE6nkaxXQK9a4c/9EXBdnDoHzJv1o6YHq2Unzqmu4hOgEVwBHgbMMs0/
         FO3YLSjca6HIiJ8sKnaByq4f6K0KLvwP6Mc/FgRFnhZkfwSVqEei3icwPnZePunG1W
         aDSCdbnlcBFqZos/XA/QGeNuqS3t1qnKJeEUE6Zg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2007171358430.23768@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2007171358430.23768@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2007171358430.23768@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: e13762abf38ead29071407f32b9dcec38f21dc34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60541fb62438c6abd821874cfc3a24d280d1cbbf
Message-Id: <159500760710.14528.7704961929633716324.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jul 2020 17:40:07 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Jul 2020 14:01:54 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60541fb62438c6abd821874cfc3a24d280d1cbbf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
