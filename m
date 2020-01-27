Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF535C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9E022527
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580152507;
	bh=HOEZDx1p4MQA6P1YpbE1cmfkV5MTdk0sXTNfccxyrAQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=NHu0rnJJMUXv1rsADJkv9oJ+7yZMz3YSP9GrO+eMS5dflOVOFMm/Seql8048vesu3
	 XuxnpGcSWntC8xdDbsZwZENlv2+XHWHOKYFqxOGaabUKT2+1VAFVtVu1pErnAJtWu8
	 zdXn3QH6OO3Hl7WWk7C7qYE/Wrrk55grUoTOvGVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgA0TPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgA0TPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 14:15:05 -0500
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.6-1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580152505;
        bh=HOEZDx1p4MQA6P1YpbE1cmfkV5MTdk0sXTNfccxyrAQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AyhtaXvTjC/4UwDTLNw4pJqfEjUxaB6TdosRYfxOWby+9MQP5KC5xnkbFTz8eC8C5
         js5S+qk7vc8q8cbIg9nBKWcMTqcn7pGc3znfyl5vTBEs86M6d0MtGENB0zVw6ri6ZV
         25rz1kvtPNpVsvSaFjw1NL43ab9dUlIdVYmb92fU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200127112349.GA12412@smile.fi.intel.com>
References: <20200127112349.GA12412@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200127112349.GA12412@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.6-1
X-PR-Tracked-Commit-Id: cf85e7c7f437cb4e378bddbdb366477096714819
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 08c49dc135225ab29569df955114912544df5c53
Message-Id: <158015250526.1024.626258560476411897.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 19:15:05 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 13:23:49 +0200:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.6-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/08c49dc135225ab29569df955114912544df5c53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
