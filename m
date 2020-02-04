Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1ADC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FAA21744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580807419;
	bh=7UoyUd6eZyHhHXtwo/ibSZODYAQCVkBdlj/gf01XWZc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xUpdsRJUXz9q4mVrOz632pPnXxfDxqVcA1GBIWQjLjTWvcEG2xB1B4TwcIR4FcfhE
	 QXsCCB6VfRZf7CneWY1IEq4trnY7aOjMS2zbLkT7IubuTumPz+LNRfK4UXaYOHIgXl
	 AEaXKTIpfiWWfelpCv+anVewoPAvLUrXMO2P8Vx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBDJKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 04:10:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:52828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgBDJKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:10:15 -0500
Subject: Re: [GIT PULL] remoteproc updates for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580807415;
        bh=7UoyUd6eZyHhHXtwo/ibSZODYAQCVkBdlj/gf01XWZc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=POpMMIqSrkTr8lcI88LsOIHmjxxFwomlXc8+vj+XDiAzkDK+Upo6Zr6wpKlKQ2wtv
         3Jl4qOUDIaWoOWyw7YiSX9dy/YPViaF4fcwxOgp8uOmLBE3dBp6MF7x1yxv5LjKaEA
         +fGJ76413cXmMErcC9Ktrj4Ko05XFXlBzkibeFos=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200204053527.GB130281@yoga>
References: <20200204053527.GB130281@yoga>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200204053527.GB130281@yoga>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git
 tags/rproc-v5.6
X-PR-Tracked-Commit-Id: 600c39b34369e2a1bf78eb67afb99ce550f271cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a45ad71e8995eed2b95c6ef0f4c442da0c4f6677
Message-Id: <158080741512.26461.18233793131597857197.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Feb 2020 09:10:15 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Erin Lo <erin.lo@mediatek.com>,
        Brandon Maier <brandon.maier@rockwellcollins.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ma Feng <mafeng.ma@huawei.com>,
        Pi-Hsun Shih <pihsun@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Feb 2020 21:35:27 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a45ad71e8995eed2b95c6ef0f4c442da0c4f6677

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
