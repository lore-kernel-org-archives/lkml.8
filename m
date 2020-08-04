Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E560C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E9A2076E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596503406;
	bh=I6PD5Cvd9NZnMudYPuSB0csBKRSn2TvJXVEH3qDmFy8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vWHagbJfraGa0CVRA3A7kVphHox0aXCDCHlmRfHhIk8RGjiWDKQB6U2WTVCaOnfWB
	 VTImVmDy/EsXy9SowkjVLxKsmd7lkHsuSl47sn/qO+5bnqcas2dPYMo3OUj+HtFfxa
	 mZ9WS7oIiRKNzOpp2x4suoc+Kciz3Vtqz62E1IGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgHDBKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgHDBKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 21:10:04 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.9-1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596503404;
        bh=I6PD5Cvd9NZnMudYPuSB0csBKRSn2TvJXVEH3qDmFy8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kHl9bRHxx+YW8j/A3qv/a6Dty82G7yeyb2Kcw0TSXQgpSdski5yz0jSOdu1B1ykaQ
         9+yy7pS0iWnpT4aM1ZejO98nnghQYRUNhkHnoLv0QO2dEiuguy3e4gNRnIVGPheIGk
         gbjDcWmvm4RBwaGkgA2F80vnHlPTSahFU+way604=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803113352.GA1413788@smile.fi.intel.com>
References: <20200803113352.GA1413788@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803113352.GA1413788@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.9-1
X-PR-Tracked-Commit-Id: 67186653c90360922e3965d0376a61dbf6c42711
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09a0bd07764359650d41dbcb723f81321e523217
Message-Id: <159650340427.9528.1715576343141241987.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 01:10:04 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 14:33:52 +0300:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09a0bd07764359650d41dbcb723f81321e523217

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
