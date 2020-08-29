Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B70C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 20:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2AE207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 20:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598732256;
	bh=73KV7FTwqmgi/LjPBGvFBTM3hTfyjZUUXbiuU5DCAek=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uIaIre0gqsHLZxcBOo/+MBoCii+62zU6UElBYzpZcsW1Vq9YcdKR6zaSEQmxjKMZZ
	 0vDgrFF5xRO8BVZbj3LYFmnl865cGDLCLJ+y4voEsQwNJOeaFLpm4cORI4AgZL9B9b
	 ggTJ69NnDxA9yFD35OEaFlQubkz3skgYQ3CKItpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgH2URc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 16:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbgH2UR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 16:17:27 -0400
Subject: Re: [GIT PULL] s390 updates for 5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598732246;
        bh=73KV7FTwqmgi/LjPBGvFBTM3hTfyjZUUXbiuU5DCAek=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WljKRLlXcFE4Bb71A0NP8gKE44DvvPbVk5TbtL4hv+QfyDyt/tUAQ2REKw/zUUFrU
         fqf1oABuyUBEBbh3pPztwSr58+QdCyuYlSWVAOoeYMt3HnMkfklWtBMMqduVvOpOQ9
         eLsJJaZAHXwR2y1n4c6LO0POuN9iwiFO9wp1nias=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01598698275-ext-0854@work.hours>
References: <your-ad-here.call-01598698275-ext-0854@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01598698275-ext-0854@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-4
X-PR-Tracked-Commit-Id: bffc2f7aa96343f91931272d7a8a2d8d925e1ab2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b46b921b0b92bfc507d29a39f1b265c48ed45be
Message-Id: <159873224677.9079.9591128771748000271.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Aug 2020 20:17:26 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Aug 2020 12:51:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b46b921b0b92bfc507d29a39f1b265c48ed45be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
