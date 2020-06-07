Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0F6C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 18:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B6E320760
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 18:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591553420;
	bh=Rp3t/Pdj8TnycDaoG2l3HKJnueizd14qsxZOkP9W4mA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nW06n8RH+68FAmasMwcD1pjFBSxk8an7F0enQcxFPdIveK8OJGAEs/wXAMB3687eh
	 iLG1nmJkHutIVn/wwvCUj7+KSoR4rfC5XwuDfp4yKqDYstz2hjk3ZY600Zkp3L2N0q
	 Lv0x/cOSVBkaMqpe/em5SJG7u2Ovx7V2fPZ7dt9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgFGSKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 14:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbgFGSKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 14:10:19 -0400
Subject: Re: [GIT PULL] USB/PHY driver update for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591553418;
        bh=Rp3t/Pdj8TnycDaoG2l3HKJnueizd14qsxZOkP9W4mA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qgTZxt3+Xd2ObZhvUMtZAxdpYMAPU9GMC4v07JZGF1tRvLRCj9X/srN1FjGXO3bZx
         IZtKPkK9Cp9ON0ahdmQjZzK3XhCLShnesrGDYt7+7m+gil5HuCE0YaMp3f3+TMcbT9
         a39IDmNCifUdHMSpZtI1xad6Ppnblsqp306AbTMM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200607132701.GA168046@kroah.com>
References: <20200607132701.GA168046@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200607132701.GA168046@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.8-rc1
X-PR-Tracked-Commit-Id: 347052e3bf1b62a25c11f7a673acfbaf554d67a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e611c0fe318c6d6827ee2bba660fbc23cf73f7dc
Message-Id: <159155341887.28494.14195988327420438133.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Jun 2020 18:10:18 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Jun 2020 15:27:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e611c0fe318c6d6827ee2bba660fbc23cf73f7dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
