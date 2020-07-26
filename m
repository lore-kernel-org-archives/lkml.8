Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD98DC433E8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF7A020656
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595786720;
	bh=y9iEoSIpXIcSYGuTUeiq/f6Ov/PWdLhenKRXegZvtTo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rl8rkba1kNn11bl9n700CVDjleN8Uky+txuorkUV/dQ8fB3+ioQAzSpRlevpy1PuG
	 M/nFfdqBfYBJLfmF0ZsG4P8t2UxRe1DiwjqW+HrsEJprK9QP0e4kYTDTnMZrYRfyLm
	 jgK+rasPBKAt19zMTNsLJzapqBD7IHMa3vF70A8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgGZSFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 14:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgGZSFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 14:05:06 -0400
Subject: Re: [GIT PULL] Staging driver fixes for 5.8-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595786705;
        bh=y9iEoSIpXIcSYGuTUeiq/f6Ov/PWdLhenKRXegZvtTo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eKn5lhRV3aU99flVE/DVKU2LPgZzY4DnEFxEwqyU6w9G3Xngu0F4MLTM5Xse1J8J0
         ZFbReXRke25b3xO2eIkLhdGxYIzzS7CPqJTUn3SA59w7S3Mynzwmm1fy5M491p01nL
         6igd3ul6t0fiCpqWPN51Vbov+xgUsNN8Vawby7Iw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200726111246.GA1283734@kroah.com>
References: <20200726111246.GA1283734@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200726111246.GA1283734@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.8-rc7
X-PR-Tracked-Commit-Id: faaff9765664009c1c7c65551d32e9ed3b1dda8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f208a76fcb5700a0c5104e5888679acc31d1ce41
Message-Id: <159578670573.6689.13908897203143238236.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jul 2020 18:05:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Jul 2020 13:12:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f208a76fcb5700a0c5104e5888679acc31d1ce41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
