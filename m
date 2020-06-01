Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF61C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3397820870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591048511;
	bh=H5WWUaDB5xkNQ8hrh01MQg/oNxNkD61LNt5Iysk27IQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZdTAs327/0S5Ux6GTPTU0cKhWW0z5IQv4w0aNYX4RahoTRM6JJmHpDlDZLamHoyhT
	 MPqxyV1xO1S6Oz5+WP6aCXf2tM0i/HwnNE2hwBhjqptyVT4arQ1BeDtRKWqyPg/5TA
	 zUd2aWZd4oY2cmZjXIHyO2Cm3q/MuPCYjwUWlSAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgFAVzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728788AbgFAVzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:55:06 -0400
Subject: Re: [GIT PULL] RCU updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591048505;
        bh=H5WWUaDB5xkNQ8hrh01MQg/oNxNkD61LNt5Iysk27IQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2iQjqujt2dmtS10Sh2W3z9RTcEoPRmPron5rY8QAbvn40ioM4ZUQbrX9ommTe1zlN
         mmKllnawc0yGdCYS9/Pn9jbH2S89XN8tRhnzc2ARG0GNhrb5I5fC5V+P3eQJuT4W+t
         +nDdWwcM1XLzDLPrgFt+OC5uKh38HhXRvF+SJsC0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601131557.GA756658@gmail.com>
References: <20200601131557.GA756658@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601131557.GA756658@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-2020-06-01
X-PR-Tracked-Commit-Id: cb3cb6733fbd8fd8d2c716095fdca42dadba2063
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2227e5b21aec6c5f7f6491352f0c19fd02d19418
Message-Id: <159104850571.21074.7614260809946986327.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 21:55:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 15:15:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2227e5b21aec6c5f7f6491352f0c19fd02d19418

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
