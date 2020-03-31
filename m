Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39810C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1AF20678
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585698915;
	bh=Ic+Zg2b85gzRC7NZ13TncC4v20pV6X7PQYKXZOcy8PU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=B3N3HSz9VbAqm9dIsRa+9WTyfiKQHDpogb9Jks2YXyfYXDAhgjPCkdOXd5Vt8tQ+P
	 /slyo1a85hInkdfzqKblD5+UXkuYOAPCBc/fcbBm1g/d9yQ0mEVlAScxpDECulxQTW
	 hSFm8MdYj+BAMvKwEt5WTeCxnLs2LqYBoiFdiNRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbgCaXzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 19:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732024AbgCaXzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:55:12 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.7-1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585698912;
        bh=Ic+Zg2b85gzRC7NZ13TncC4v20pV6X7PQYKXZOcy8PU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=q0T4HgU1yPLjvvlG2LTGrcCbfQKnIEMp/WNR8Lmiu6KmSbNxr+PSXHd5st5M4DC49
         23nvx2W+XnEV6qCFZCwIg04wdRg63R2sJ5Ib4M4+TwLgwaRp9Pj7NbOfb7QLMYUDFu
         0kWFxKy/NCmFbdkj2V+T2/1sl3ctEE/7hNWOHJrI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200331122139.GA3453702@smile.fi.intel.com>
References: <20200331122139.GA3453702@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200331122139.GA3453702@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.7-1
X-PR-Tracked-Commit-Id: d878bdfba8ffda64265c921cf7497934a607f83a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dba43fc4ba2fed63e898867fa973c69c37623939
Message-Id: <158569891231.16027.13452491483212239297.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 23:55:12 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Mar 2020 15:21:39 +0300:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dba43fc4ba2fed63e898867fa973c69c37623939

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
