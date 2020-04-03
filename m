Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AEBC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF5B20675
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585874438;
	bh=NwF0phCbiYdOD88pZvDvdSU+V/tyYvt4lh2/SiBpYjA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=NdfS3ODZskazC99VCVOAcb35pS6VBSqcGeOAHhEUo7GGmIV/5q0u+6EclA76cifSH
	 Pck9CjqlrAM6E1pI8tnmsTDbajGE4VGKZf1grvG6HREIW/14Jefo482hEoe+OWzZzk
	 28TysXf0kVNn9fqdK1NqFAIoltNPc0KjBEBwXNus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390521AbgDCAki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 20:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390431AbgDCAkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 20:40:19 -0400
Subject: Re: [PULL REQUEST] i2c for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585874419;
        bh=NwF0phCbiYdOD88pZvDvdSU+V/tyYvt4lh2/SiBpYjA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Lgsm5vTiTvzsSE/P0n44GDOelCSg42GpsBubvA8fszT2Pl1+pGBOIDQ0apiuZjpY9
         nsUZ0em1NBmFYpQhjW7/JVzlkviGRupyVK2Hu/IS8h/FV1iLqOUZzLqUXlH5ebxNPN
         /ZaMW1ggjDn6mNg7vsgDBrisx8EEZeh2P4qxA5ZQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200402095948.GA2414@ninjato>
References: <20200402095948.GA2414@ninjato>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200402095948.GA2414@ninjato>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.7
X-PR-Tracked-Commit-Id: df576beee53ac97fe0a413430e623e658805891d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c8db3eb381745c010ba746373a279e92502bdc8
Message-Id: <158587441905.31624.16830080488714978048.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Apr 2020 00:40:19 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Apr 2020 11:59:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c8db3eb381745c010ba746373a279e92502bdc8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
