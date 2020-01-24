Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48713C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1102077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579888805;
	bh=G5wmcCJIZMdkTO6ZAzrVhDTigeLl3CYbvT4oM7gHOfM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=j1z8ldff0tiWNx2qg4kjnIbg+afH+u1Vg+dYCKFzC503HgU5EtiKED5FTUDLPk/SN
	 MaEPAoRR1zzbKBAni9e8EeYqSfmgbW2k2Tc1qjGDztEjq0zDi1seSBo4Ka4TbcXmQ3
	 RRPA3x4Ps1NsP+wyAMb7KoGZsitpvblCDLXREf0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390984AbgAXSAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:00:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390537AbgAXSAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:00:04 -0500
Subject: Re: [GIT PULL] MMC fixes for v5.5-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579888803;
        bh=G5wmcCJIZMdkTO6ZAzrVhDTigeLl3CYbvT4oM7gHOfM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cyX7/uyWtC87MjXBvRTBm+hAbRRY1W0+8jFue4Z5zr5T1nhf24nh6bRYVLA0fw7C4
         0BbPC/Xo9I3AvY7ycHloKQMzxBjOgdHyAI+lm8tLwkKR4P/XJIDHiElLtzWdWMMEo9
         zbR0olod1taXEdRHEOOkbyekZ5A7FTIalXRP2bxk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200123200257.17258-1-ulf.hansson@linaro.org>
References: <20200123200257.17258-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200123200257.17258-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
 tags/mmc-v5.5-rc2-2
X-PR-Tracked-Commit-Id: 2a187d03352086e300daa2044051db00044cd171
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 838a860a390547dc6f8bc9d0a77d4ebad1dc8ff1
Message-Id: <157988880348.9531.8970732011194689582.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jan 2020 18:00:03 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Jan 2020 21:02:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.5-rc2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/838a860a390547dc6f8bc9d0a77d4ebad1dc8ff1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
