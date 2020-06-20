Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE5FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 19:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17BD20809
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 19:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592682928;
	bh=lZqKdXrIkGJ4mKRjqm7KPxs60xWyU++w6Xq+Hzr36s0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=idOCOqiOvVnym6INegBoPCp2MMdPDrIVGvkapxDZuic4OWAD3f+Q64mLO4Ox9pt9J
	 ocnWVFPDvtl6yQeRk1S2H0k0coNJFOOIZSnQ6O9vvjrkhR99c61UBMJVO3SaEAItVZ
	 kulOEu9n3u+lyigPm23PsUurY9pKVa4VITqUfZAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgFTTz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 15:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728711AbgFTTzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 15:55:25 -0400
Subject: Re: [GIT PULL] s390 updates for 5.8-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592682924;
        bh=lZqKdXrIkGJ4mKRjqm7KPxs60xWyU++w6Xq+Hzr36s0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FjbXzOEFRQen0di4YL01Zi5SmTPW+IXAcagDSF85mJUvukLSuTkKrlzgHDNddKiTX
         H1AYsd2AbaXUph58fJU7SCe6EYLiGZfWJh5Zwn19/FNmx1CKVODD1DHFstyTmzaJpE
         +yTFObyjvJolXBgEwRYo444FRnZvMObC+Sh0wAx8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01592666516-ext-8102@work.hours>
References: <your-ad-here.call-01592666516-ext-8102@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01592666516-ext-8102@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-2
X-PR-Tracked-Commit-Id: b3583fca5fb654af2cfc1c08259abb9728272538
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1566feea450cb0ffcdb47daf723f62640c9f616a
Message-Id: <159268292485.15446.12282892481530206157.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jun 2020 19:55:24 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Jun 2020 17:21:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1566feea450cb0ffcdb47daf723f62640c9f616a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
