Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17009C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A51208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585874415;
	bh=CLKjtUIczRo54tSUO1qfBLTMy3x1GV8EUM/p4aYQjno=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QFrIHIhIClOPPcEt/qAtQYkXuM+7LjApvSYS1E6nD47ZhmT7cauLvbGdR68UyAU6s
	 UlE3leiWFIPN2b8lwr1kSLvXwQRtPxDB880zPdkA+8wH22vg+r9q5XIXQ2H1ndmSQt
	 Np9SIsonMCYflYAG7kvaeIKXafr3yKdYgyIaO4cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390412AbgDCAkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 20:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390401AbgDCAkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 20:40:14 -0400
Subject: Re: [GIT PULL] remoteproc updates for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585874414;
        bh=CLKjtUIczRo54tSUO1qfBLTMy3x1GV8EUM/p4aYQjno=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=G/NeFgESF4iYO3Yd9crbZ+knu3Kid0DO4S99b07a/yTK8c6vny81DR1a1XZLRuywQ
         bQ6TMmy4HDs1WcEZ0Qj1on/5963Lec+XvRgaqa1ja2XCdtlU4+RdrNrWpdGcjxrXmL
         Pkky/g+H8cbp0BqPqkvcOGfLbIk9MhXBqp6+o2M0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200402010812.GA751391@yoga>
References: <20200402010812.GA751391@yoga>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200402010812.GA751391@yoga>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git
 tags/rproc-v5.7
X-PR-Tracked-Commit-Id: a7084c3d47c4aaedcca217ce87b7b5b5fe3cfa35
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6570114316fbbce4ac5f970578adaf3cbf07ec3
Message-Id: <158587441400.31624.15782732090715471262.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Apr 2020 00:40:14 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suman Anna <s-anna@ti.com>, Clement Leger <cleger@kalray.eu>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nikita Shubin <NShubin@topcon.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tero Kristo <t-kristo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Apr 2020 18:08:12 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6570114316fbbce4ac5f970578adaf3cbf07ec3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
