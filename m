Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0A5C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 19:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7068522244
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587324023;
	bh=2vZxi4Xruxuu/F4WsMcJfIJJDFxu+7VLth6g8GYy/qQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uWntCR30IsFdpvNBLNj7cw27OjD9JjbluQQxjhOdjc/yt8uBsWy5GZny76J2KbIsE
	 UHhhJ7Bhrp3g+u/RtAGzw/dIkFdvZ5Tfg1Kne8lWspf+lyFA9joY7Z1Q5O0Ym04jK/
	 3hBJ95C/w1PWA/bVtv2j5asFYThw3ciUcUdFsMgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgDSTUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 15:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgDSTUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 15:20:21 -0400
Subject: Re: [GIT PULL] flexible-array member convertion patches for 5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587324021;
        bh=2vZxi4Xruxuu/F4WsMcJfIJJDFxu+7VLth6g8GYy/qQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jqricItRx08yQT3zSza21r+npSXTQ08qESZ8sV+AoxgQlpDojZqy5ZBeGfpuIaHFn
         P4ZmzBfFtKeHvB4TBqtIE6wCvnWT4WpgvqMxn5t3W7PxfgZrWW+W5/Znssk5b6RMDN
         1peZM/AT2hoe7+XAMeFcRskZVA4aVTeu9/xLOa3w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200418213828.GA10666@embeddedor>
References: <20200418213828.GA10666@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200418213828.GA10666@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
 tags/flexible-array-member-5.7-rc2
X-PR-Tracked-Commit-Id: 43951585e1308b322c8ee31a4aafd08213f5c5d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13402837414070492004cd0a9c80b5fcebbd1a9e
Message-Id: <158732402159.20624.16837438173291252358.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Apr 2020 19:20:21 +0000
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Apr 2020 16:38:28 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flexible-array-member-5.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13402837414070492004cd0a9c80b5fcebbd1a9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
