Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8EEC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9279E20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580769329;
	bh=0Hcol5av8qsY7H7Tvut4LbPtPoBHn2pL0ZPK6yFvhdQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CPn35IjUigWJhH6ux8GXUjd418WWHMEI0p4aXdvROfzyOP9pyfYByugSEws5yDpF3
	 3JfyxEhGYcXB3RW8ms898T9QXZe8tKFTV+nftwddiDI+ktT16kpLxpahNs9nYyrKpt
	 HYkzUDnSnTgD9qL4pDaWGzRUHHGJR/uhoOiC9yXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgBCWf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:35:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbgBCWfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:35:19 -0500
Subject: Re: [GIT PULL] percpu changes for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580769319;
        bh=0Hcol5av8qsY7H7Tvut4LbPtPoBHn2pL0ZPK6yFvhdQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dBx0lTFhqm4QJtNoO3D2/iiT5wyjNRxbkLkMt61kX3v9w7GjuyII4RGTFw+FRFbE2
         4gm8GoRiUp0a9xvjV3swjkvrILWRVotW7iR++0O8Py4pMKbZ0gmy8cQMU3gPYObHQ7
         ezQ1FIJWO8O/eE5B0spUwnc2TIAGZ9fe2LM6VkzY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200203210450.GA25544@dennisz-mbp.dhcp.thefacebook.com>
References: <20200203210450.GA25544@dennisz-mbp.dhcp.thefacebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200203210450.GA25544@dennisz-mbp.dhcp.thefacebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.6
X-PR-Tracked-Commit-Id: 264b0d2bee148073c117e7bbbde5be7125a53be1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 322bf2d3446aabdaf5e8887775bd9ced80dbc0f0
Message-Id: <158076931918.15745.9277622294581924437.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Feb 2020 22:35:19 +0000
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Feb 2020 13:04:50 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/322bf2d3446aabdaf5e8887775bd9ced80dbc0f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
