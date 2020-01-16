Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFBFC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C00D206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199408;
	bh=aF+qcS9mrjO8tbEi8YwhBFivADRMZws4q6LY/Bt7bLw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kAxmcoTbxEEe9cyhxepyg+iwGU2upb5KB64d+2ibV8QR/kHnv14I70iWcTA/iM7gv
	 4KJoLQY/ogmLagKMLIVA8QBM3cR1CkntJaTGI3ekhIzx7mO7jFT9D+vB8N73oyEbYj
	 eBpBd4HEUWHCvF/efYpkh/2nx2/9/SL9Mc9iVoAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404007AbgAPSaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:30:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436720AbgAPSaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:30:04 -0500
Subject: Re: [GIT PULL] chrome-platform fixes for v5.5-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579199404;
        bh=aF+qcS9mrjO8tbEi8YwhBFivADRMZws4q6LY/Bt7bLw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZoBbonQLXLG7OOKSs39oqVjJ0jPHR2DnBCc7IWUXU4voThjbyYS6n1QTEN+8XZCuF
         4l0YVn7T7Rr2S5kuEIaZwJzPKKkswWK0EYhOcmIOiC/M0TrOvuzGT8ahTyWs0Rn9W/
         Tg5OGyTGTnuP3DexfCSKKl2fEi6p2OoTsd+LL+2Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200116175802.GA147875@google.com>
References: <20200116175802.GA147875@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200116175802.GA147875@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 tags/tag-chrome-platform-fixes-for-v5.5-rc7
X-PR-Tracked-Commit-Id: dfb9a8857f4decbba8c2206e8877e1d741ee1b47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c99ee44b8921b872089a7374c733310d995fd92
Message-Id: <157919940438.19397.11912146279100722478.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Jan 2020 18:30:04 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, bleung@kernel.org,
        bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Jan 2020 09:58:02 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-fixes-for-v5.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c99ee44b8921b872089a7374c733310d995fd92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
