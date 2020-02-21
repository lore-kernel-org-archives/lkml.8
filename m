Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162D1C35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9FE208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 21:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582319432;
	bh=ua9QVkE705ZtFcnikuO6IJL65XA/1/fU3oOT/kioq+c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IOWtESWNIa3q5t5MGfg4cDRTOKQ2SQNrpA85YzWMfRfAVATL5YecDHgLizzbixB6K
	 oZLuouh6S04pEcU538umEyCokVNJM+fkAjP4i/UZCrlTaIG1187sFkBb6SumZPLYkz
	 Q/RVT3mORdVqlDrqWfk49HEbUYECmbJ9IYR/32wQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbgBUVKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:10:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729680AbgBUVKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:10:21 -0500
Subject: Re: [GIT PULL] Staging driver fixes for 5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582319421;
        bh=ua9QVkE705ZtFcnikuO6IJL65XA/1/fU3oOT/kioq+c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=i9mdkngJE/d7J6K6xWaAevnUOnsqQoCbQp8L5WTUKd7zUh6CiiCCykmBjohcm1YF1
         vGWpnhrHKevRKRwerml2xuVvcZ6bOFS1/72VmCTspdwE6NUpWrKSizSPVzJZXv9N1w
         NtQP/4552LMYVaZTKK1KbvgSPGZlBQc/m0chx1ec=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200221113952.GA114312@kroah.com>
References: <20200221113952.GA114312@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200221113952.GA114312@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.6-rc3
X-PR-Tracked-Commit-Id: 9a4556bd8f23209c29f152e6a930b6a893b0fc81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5553ac71e584c3aa443e211ca2afded6071b5b6
Message-Id: <158231942131.18249.4740363837241143098.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Feb 2020 21:10:21 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Feb 2020 12:39:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5553ac71e584c3aa443e211ca2afded6071b5b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
