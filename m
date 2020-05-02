Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0F8C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C220208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588380013;
	bh=qL5XeatVpXx9opii6H8sxkEfagRkW3msXRqev1hEn/c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jrFysWJMEfAnjN03EpVZ6H9xSEQEN8LvV+BLfmAPfd04EOW3LcfIv9iR9WFUeiNwV
	 +XYoZDiLes2coM6HQyOTk+lcj0g0th3SdAoKizNkgop2QWwMefFHRrGR9+DIQZP+7j
	 ox6vioHRVaOwddav2cR0JhJae7D3oMl6ZJYSF8tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgEBAkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 20:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgEBAkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 20:40:07 -0400
Subject: Re: [GIT PULL] VFIO fixes for v5.7-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588380007;
        bh=qL5XeatVpXx9opii6H8sxkEfagRkW3msXRqev1hEn/c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=U+k0L9S0CMJcw5ElOpkFm1YxksiouAQFYyafaU6xYZIeyQsspkY5+7EKel7Fc011p
         ljrfWjHa0EWPahAcUgGB9LgASWI3Njk2FUXkoL9ahljN8aI5Vh1Tzg1WSRDroiU4p8
         eq1tbcHsIz7piCx05Qd3rdOhuXkEy4BVX+FGVRwU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200501155054.39bdad7e@x1.home>
References: <20200501155054.39bdad7e@x1.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200501155054.39bdad7e@x1.home>
X-PR-Tracked-Remote: git://github.com/awilliam/linux-vfio.git
 tags/vfio-v5.7-rc4
X-PR-Tracked-Commit-Id: 5cbf3264bc715e9eb384e2b68601f8c02bb9a61d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 690e2aba7beb1ef06352803bea41a68a3c695015
Message-Id: <158838000720.10067.6965022670848578963.pr-tracker-bot@kernel.org>
Date:   Sat, 02 May 2020 00:40:07 +0000
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 May 2020 15:50:54 -0600:

> git://github.com/awilliam/linux-vfio.git tags/vfio-v5.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/690e2aba7beb1ef06352803bea41a68a3c695015

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
