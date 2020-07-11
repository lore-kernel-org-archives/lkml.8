Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EFEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 04:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 430A12078B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 04:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594441510;
	bh=MR6mgC0BAJFeu5oGI1MlwwlElWhMLFe2OZQemS/zWGc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gwEezG+6OmSe0odpVO93lD4dp51R9ucQHl9/YU82rDWlretOCzSjksaeCOBt8iJxF
	 JbGJ737GP1dI850NlMjEQGVNuoZn++fEMhim7SG6MfrqFUp5Z1BfRZPRCYA7g3Kb51
	 q/SezTs86BEucXGTpsz4lpTcz8jGqdccGTOhV5S8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgGKEZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 00:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgGKEZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 00:25:03 -0400
Subject: Re: [GIT PULL] CodingStyle: Inclusive Terminology
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594441503;
        bh=MR6mgC0BAJFeu5oGI1MlwwlElWhMLFe2OZQemS/zWGc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OzzJDsEKit9SStfLxhkvORoN9ZeVR/HXafoUV350Gi5qv9r7kaQ5Xx89hdnR4sQ43
         jE4qTENzCQxIqsBQCDkXuyjcYrjvjb0lK9Au0zvKOqhA9jqwxr5pXVYgcbwOqyoDmX
         jKpr3PXo3vxKzvFgWBwm+NwipwnT4QJfKKUQpQgc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4gui-sbHHq8k9MmEojkSHd5XSF3RLBhUkM=sO8TKPAdZw@mail.gmail.com>
References: <CAPcyv4gui-sbHHq8k9MmEojkSHd5XSF3RLBhUkM=sO8TKPAdZw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4gui-sbHHq8k9MmEojkSHd5XSF3RLBhUkM=sO8TKPAdZw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/djbw/linux
 tags/inclusive-terminology
X-PR-Tracked-Commit-Id: a5f526ecb075a08c4a082355020166c7fe13ae27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49decddd39e5f6132ccd7d9fdc3d7c470b0061bb
Message-Id: <159444150312.19180.2884576870193335516.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jul 2020 04:25:03 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jul 2020 17:17:15 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/djbw/linux tags/inclusive-terminology

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49decddd39e5f6132ccd7d9fdc3d7c470b0061bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
