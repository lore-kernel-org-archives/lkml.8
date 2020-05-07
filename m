Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8987C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C973C2184D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588872913;
	bh=pNvybinVXhnLApEYIsATDA6ow4V7vidIFGKxLR60T1I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pDtj/RJVIDuK6nVpzPFXqYwS8ybQl3htzA7Ju/WduU5cD5xDbacHx5hTd9v7bmCJg
	 byc+StDxJhsxDKgzx4ORMAos8psauzSKKP2ZMQBa7dYSKR16NIFj8rnxXq+uh+g5T3
	 h3aDNoyt8BpX6cB5S/T7Wkgd6qnb27CPKVejZcmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgEGRfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgEGRfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:35:05 -0400
Subject: Re: [GIT PULL] arm64 fixes for 5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588872905;
        bh=pNvybinVXhnLApEYIsATDA6ow4V7vidIFGKxLR60T1I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0MRyfyijVYgrRS+zGknQwqukXy473QDY59v4keVrs/+VVlezEJ5kcldXNHl20w6mx
         GRQxasinAZiWiWVi3Df+Ch1UTTsVwn9YV7/oYA+v9fIrvTh3F3HIcFt2d4zsSfsgNB
         Q10fMjh5QkWqqSbfKlHQrmR3AiNwACamkN335zxk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200507163108.GA17399@gaia>
References: <20200507163108.GA17399@gaia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200507163108.GA17399@gaia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 027d0c7101f50cf03aeea9eebf484afd4920c8d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e7f2eacf09811d092c1b41263108ac7fe0d089d
Message-Id: <158887290554.22656.8225125558948373624.pr-tracker-bot@kernel.org>
Date:   Thu, 07 May 2020 17:35:05 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 May 2020 17:31:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e7f2eacf09811d092c1b41263108ac7fe0d089d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
