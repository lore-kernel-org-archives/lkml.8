Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7C1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4786D20734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591722643;
	bh=AGV7xMV78eyjBnrPi//kfZU+sGTqY2z4YfrrYO//a/o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=W8SsUWH4I9Cot7T72RYXYrBwepIXWbD5htWLgEqa0TAAE0cXJJEX3hgFpKC5mULHO
	 vIIK982p9iXdBl43FAQAgivnawr3oIoO5ajORJPKSmN+FswIBOgKL44YGegWh3pt2q
	 1k6eE60VyQBbDomaw009X0KGrtxchsDg690e9p4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgFIRKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgFIRKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:10:22 -0400
Subject: Re: [GIT PULL] Kselftest update for Linux 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591722621;
        bh=AGV7xMV78eyjBnrPi//kfZU+sGTqY2z4YfrrYO//a/o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wxD2oxRX5TjT7XoqdiXZak9EjqvONv4yGPSCD12c8zor/sRaBLJqK2mAREoCHzv1z
         8T2ntXrnSL7zXZcnT9Ives1GUofK2a/U08Vf22LqcS2Vv9ZjPE8wlC+HqLRBkpT8iE
         +5N6QQBTZkQRVOO8yEwLKedgPt6kUCHYFKUurlDg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9e5f53d8-ecc7-5d78-e232-3f525541bf88@linuxfoundation.org>
References: <9e5f53d8-ecc7-5d78-e232-3f525541bf88@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9e5f53d8-ecc7-5d78-e232-3f525541bf88@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.8-rc1
X-PR-Tracked-Commit-Id: 382561a0f11c4995d48ab82670412f8d6c418430
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc2fb38c85508a875fc2e95f1e14e0bdcf59e1e9
Message-Id: <159172262192.7211.14059629904718694859.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jun 2020 17:10:21 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     torvalds@linux-foundation.org, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>, vbabka@suse.cz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jun 2020 15:53:12 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc2fb38c85508a875fc2e95f1e14e0bdcf59e1e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
