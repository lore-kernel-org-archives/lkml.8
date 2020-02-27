Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9778C35DF9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A182469C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582832413;
	bh=eeGY8AZSjPCnOpimAQU2I1rDi2xJnAqsvj8R6nJOjkI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=THOJlkSypCgMBDNjs359oi/TQzSirjVk1zSRIasW8YAIogjzyDbUo22AMJ4KVat3Q
	 WB7LQy4ce4O7/g+pmjNOTaFuZmKUO7FN5Yr5NrqLLqnpLJXTewJBegSAnu1kKk0Shh
	 UFT3bxT0kTsCtIVDo9U94gmbReoDSljdpDI4GJ28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgB0TkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729953AbgB0TkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:40:11 -0500
Subject: Re: [GIT PULL] HID fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582832410;
        bh=eeGY8AZSjPCnOpimAQU2I1rDi2xJnAqsvj8R6nJOjkI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=X/jcEblP05yjuurtKjnCWcvbD8AEd+kFEftr81zz2ueegOXXIKrmRdb7+nXTA9E0/
         ehJuVU36iGDc3tGbpUanzeLJhAlo/qFaF3NVigXwqd2xjJdEXbBxPEhbV6pGNXjk7N
         6smNLkwI9PP+gRMn0xelyVFKqocSnzzvY9BtKvWg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2002271539500.13129@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2002271539500.13129@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2002271539500.13129@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 4eb1b01de5b9d8596d6c103efcf1a15cfc1bedf7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 278de45e145bedff90072fb47bafdde8393f6a80
Message-Id: <158283241070.25748.16506674996473659207.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Feb 2020 19:40:10 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Feb 2020 15:46:10 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/278de45e145bedff90072fb47bafdde8393f6a80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
