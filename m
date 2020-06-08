Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DD9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 939CB206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591646738;
	bh=aq3IuTPH0A+V/G+c+5zjiRNFi/+M1aSNJBD1yGrnDY4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qJk9JPkmiSdtPxwh9Ig+zXHC2kz4eVY0cCze+ZGSZGpPRTKuD0ZD4TEDsoCa5WW7X
	 N7jtfX7JKBS247iU8QDgh+hm0OcPHx83kxRiM9pJza+xhFTuIOKgPW8CSQDVsmhKqf
	 +JMUnVm7Qkyfm9fuixU7bpwqAnL1BG61Afe1TKh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgFHUFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:05:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgFHUF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:05:26 -0400
Subject: Re: [GIT PULL] remoteproc updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591646726;
        bh=aq3IuTPH0A+V/G+c+5zjiRNFi/+M1aSNJBD1yGrnDY4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VMEyFv2md7PZH3F5WFni9PG5TD6N0PWLV+xgds6xU+nkyPRuMn41Y+cLxDdHBvld4
         /7wx74XQJtH7D1fw5LOAGuVwbk1QR7wxaysc6pLvIqByB+Pl0zFIRpDBd80QpAdBt6
         1/VpzDvZjnIW8iwkX059WRwZ1xQrAc/D8X97VxXo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200608183005.2302840-1-bjorn.andersson@linaro.org>
References: <20200608183005.2302840-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200608183005.2302840-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git
 tags/rproc-v5.8
X-PR-Tracked-Commit-Id: 7dcef3988eedbfb40e7e95a821966a029a5a465b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abfbb29297c27e3f101f348dc9e467b0fe70f919
Message-Id: <159164672625.26583.11071908518468082884.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jun 2020 20:05:26 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Clement Leger <cleger@kalray.eu>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Suman Anna <s-anna@ti.com>, Alex Elder <elder@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Tero Kristo <t-kristo@ti.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yangtao Li <tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  8 Jun 2020 11:30:05 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abfbb29297c27e3f101f348dc9e467b0fe70f919

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
