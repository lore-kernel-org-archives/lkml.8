Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8C3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EB2B206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591295150;
	bh=57RFLmoo9mdWBHBwZ7cwcBnpuKppAwmTiGlvgZZKUr8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OD6Lve/8oL/A2/c8ocBfCSvB0dG1uf5XUvgzZD98byKYw+oTGdoYVPODLMKPg8gBw
	 6Ia0L2kGZeCi0ZVkpXArO+1G6d0OfFZgnakEivrjSzIShkMqT/vjTcxTFEteC4JB6T
	 3kjmAqE1fYcklRqqTIB4jb87jtAoitf24N9S1ovk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgFDSZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:25:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730795AbgFDSZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:25:11 -0400
Subject: Re: [GIT PULL] HID for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591295111;
        bh=57RFLmoo9mdWBHBwZ7cwcBnpuKppAwmTiGlvgZZKUr8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R5C4ByQHsRAqV3HKvpT3RXQip96dEMRkJKn75r7TIgWdpaxAmH0kyTwDh3PfFYhbt
         1BFzUJXrtr3A3GH9IQCqUMoCwCkWsm5Y/kvUWcyv83zDtb5ZEeJDbxTe/QKEZt2xPQ
         msMOWL1ZWE2ZX5n7HPEJvnCC7Que0wbNmOCPXBiw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2006032225550.13242@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2006032225550.13242@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2006032225550.13242@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 16ba7e312045cd5d32fba0156312b4303f200787
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a789d5f8a99a366778a6e42b3700a246244201a6
Message-Id: <159129511171.18772.16037885585927613453.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 18:25:11 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Jun 2020 22:31:00 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a789d5f8a99a366778a6e42b3700a246244201a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
