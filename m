Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCD4C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 15:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952AF2087F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 15:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583682911;
	bh=F7A7UrFbb96ePTNkO/uyloNHxEfY9Goxf5S8be5Uwpo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xo9XIykR9OZs4SmqUuTJqJpaVOfoETSNppXXc1HgOXb7dNwglwpEln0yTBmIgjoHK
	 STFe87C7DBqyFc3fBgCisCqnNt5i5UcoNueDeZ+ORmXZAb61wTux10ZJYv+rOJ/4L6
	 Jfx7sXOY4CYUZroEBa9kPQANu4y7bkbgcxcqs5Tc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCHPzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 11:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgCHPzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 11:55:07 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583682907;
        bh=F7A7UrFbb96ePTNkO/uyloNHxEfY9Goxf5S8be5Uwpo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hkjVnoBPmDLA13SLl6MuLS91VSw3BulQ8X19NnImCLoXjswhX7pVQc7QKvEwxDro5
         vIRD2EEQTvIrPWl4zOJ1AE614geW1oRvOz3Wnk3JPWYHlP+KWhEtSO5n/yd2o+0fcv
         5xa3e5uwR15/NNvk9AsL+Mqc7qXSwSRYX6I3zfEo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200308095310.GA4027283@kroah.com>
References: <20200308095310.GA4027283@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200308095310.GA4027283@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.6-rc5
X-PR-Tracked-Commit-Id: f0fe2c0f050d31babcad7d65f1d550d462a40064
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 378fee2e6b12f31ab3749e0aa4ed0a63be23e822
Message-Id: <158368290705.12496.3585322471902760186.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Mar 2020 15:55:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 8 Mar 2020 10:53:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/378fee2e6b12f31ab3749e0aa4ed0a63be23e822

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
