Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFE5C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1613620781
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584724523;
	bh=OLXAhy9OL5VK+yLwXen0926ZLYIxANWzgKtd1H11emM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lWaB80fE2T6DzYbCQ0Ba6lDhahl/Q7YbktyEF+sTSVs48KtvsUgbR0ZB827SwDrmp
	 XH4KmaY+qUiEm+yuXhZ01+XNrs35oJj7ZD+ou7tY3IqR22FPfI/zllZY+sqmMxPafT
	 jcUeaYJ13Nf1mO0vmS4KbMgS00fudrn6at5RmvI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgCTRPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbgCTRPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:15:10 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.6-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584724509;
        bh=OLXAhy9OL5VK+yLwXen0926ZLYIxANWzgKtd1H11emM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=S2vzAo6rjbaQT+KZE3DBuvUEF4BRhNnxKbHm2E5t/ZiNoqlYcdviuKuksDTbQAZpJ
         T/RIdQiQuEdnHnXGaegXtA0Oav5grlnXQNAXNK8KgEbXZjVpmAoFcGzlaENTBTSF80
         3nKRsFgQ44mZ+gi49ONQBOtZKrK5kjdFH/SNa1Ko=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200320142818.GA760640@kroah.com>
References: <20200320142818.GA760640@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200320142818.GA760640@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.6-rc7
X-PR-Tracked-Commit-Id: add492d2e9446a77ede9bb43699ec85ca8fc1aba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f014d2b8584d0bf938e8d6761c79596e94b06f98
Message-Id: <158472450967.23492.7168121259826844822.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Mar 2020 17:15:09 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Mar 2020 15:28:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f014d2b8584d0bf938e8d6761c79596e94b06f98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
