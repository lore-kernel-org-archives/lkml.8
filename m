Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCB1C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 02:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306FF21739
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 02:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580265913;
	bh=vpXC06tMpAfdu7fbElWg/pipJTvQkEjTEu6dg+ve1M0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LygVx44BiaAS9e4pevRWHcaGG2xlWKtUogs98gaY/W5GPXGyrO8trayTelgbwmq2R
	 Hg+q82OOJWGb6dOo/742meyj0CR+LL7ex/1bc1+QuHia8CRcZwNTNilwddLbDOtW2i
	 7ESFeKHHOAWAZLSTm9tfPMXWOgVWZVyNWzlh0oGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgA2CpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 21:45:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:60802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgA2CpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 21:45:07 -0500
Subject: Re: [GIT PULL] s390 patches for the 5.6 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580265906;
        bh=vpXC06tMpAfdu7fbElWg/pipJTvQkEjTEu6dg+ve1M0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Q8cw9cd8+XutakK36qq56ya+7qQz2oWUFNht+p2iiIjZTTGN9tx44Hzx4cWqIqZqV
         xnfLokn90JUvd4UOUDE0U4GDyHeDoHyT6dDQTMQL7GadyDoncdBIIA3hNKzc9PGPwU
         RrXwhI8c6UApUeLakeWqa0LFQ6oKq/Vn0/r+dKLA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01580230449-ext-6884@work.hours>
References: <your-ad-here.call-01580230449-ext-6884@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01580230449-ext-6884@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.6-1
X-PR-Tracked-Commit-Id: 17248ea0367465f4aaef728f6af661ed38e38cf1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 740eaf7d4dd255789987a543b0203ca239b37087
Message-Id: <158026590645.23129.14207583440671082747.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 02:45:06 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Jan 2020 17:54:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.6-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/740eaf7d4dd255789987a543b0203ca239b37087

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
