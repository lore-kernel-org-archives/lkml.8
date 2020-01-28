Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186CDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6ECD2467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580254808;
	bh=WcVL55yM5vmF24gnlm/ugfLFZQFqTA8w3K/W0MVG2Fg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=suh1kRgs4FWunUk/d5tYBAOUUKxjyfSrjaFWPRp9LVaZfbZexBHZgziQBf6r9v6PE
	 qin1z4CvWxMdjseenFmfPtRnxC15hAGzWCWo7nVyNkSRr709IJqXY3VIo9LmV2IUrr
	 qdxvkJXMxZ7/taikr17ZL0RMyEfJw+Cc/cyI1BLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgA1XkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 18:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:49316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbgA1XkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:40:05 -0500
Subject: Re: [GIT PULL] Btrfs updates for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580254804;
        bh=WcVL55yM5vmF24gnlm/ugfLFZQFqTA8w3K/W0MVG2Fg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EWBnCxN2w6EUoFksBREMvNHT0DY9pShVJuA3WdkzX4m1sDvBhpJpnijLQAQagd+Hw
         Dk1hHlWKXOUO+Ea83NzXb2Y1MQUPqt2PpEIUuqUdwKYxgDRIbtC5Oj1i/3zXx+7Fpm
         IE55eryvyEcWjqDyncK/IEeayl7nkE2TVH0WCLGU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1580142284.git.dsterba@suse.com>
References: <cover.1580142284.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1580142284.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.6-tag
X-PR-Tracked-Commit-Id: 4e19443da1941050b346f8fc4c368aa68413bc88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81a046b18b331ed6192e6fd9ff6d12a1f18058cf
Message-Id: <158025480492.16364.6553027097982015044.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 23:40:04 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 17:30:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81a046b18b331ed6192e6fd9ff6d12a1f18058cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
