Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3004DC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 22:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D28F2089D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 22:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593297915;
	bh=jyZZ18KkRpX5wgksdKr8kWB63rnqisWW7ZTZXJd/bhk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PvwCQPl7ikrJskZgA8wc/Uegg1jNM9+3yBufrBnOuHaACVk2EynfcByBQTHfXpnZt
	 l+6j/T7y6ybUodoSuEGLNz03i/l5ryixMaW/sqqp4Zb3DkkmxAYZ1z399v36NuSKfw
	 XXvqgCzTCaAuhz34F0j4AoP7k117ynbAcFbWzvH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgF0WpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 18:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgF0WpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 18:45:12 -0400
Subject: Re: [GIT PULL] VFIO fixes for v5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593297912;
        bh=jyZZ18KkRpX5wgksdKr8kWB63rnqisWW7ZTZXJd/bhk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=k7pnSZJM5uPbA2zSdf6K2PxlBbYGvt3E5TO4RC53cdm5YXyTdI3HWJl/CRZ1v1Cra
         LrySvFRq1ELF/UwikyxfXLIDZXfzKqe3hd8vFDB30pLgCV2FkcM6s1DknexEyL11Ye
         YufDKoGrcsLR1JjhJiMYGwt3WBKbejRfBLwXHfmM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200627082518.38f98251@x1.home>
References: <20200627082518.38f98251@x1.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200627082518.38f98251@x1.home>
X-PR-Tracked-Remote: git://github.com/awilliam/linux-vfio.git
 tags/vfio-v5.8-rc3
X-PR-Tracked-Commit-Id: ebfa440ce38b7e2e04c3124aa89c8a9f4094cf21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c322f5399fc36300ae870db8fbcf793e063aaae5
Message-Id: <159329791253.3578.13577951558627313676.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jun 2020 22:45:12 +0000
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Jun 2020 08:25:18 -0600:

> git://github.com/awilliam/linux-vfio.git tags/vfio-v5.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c322f5399fc36300ae870db8fbcf793e063aaae5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
