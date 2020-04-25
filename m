Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B25C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58FE8206D4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587843030;
	bh=n2L4/mjr88k5uaObaoXiyXw7V1lQA62Wol/uoVuasi4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HzLpay16r1dHsrsy1HKM/8vFSaMfx0wLV2HOJ9morf+qDQUXHQAN2GRUGHoktE0qj
	 2kI7e9pD8QKfJsLXA3riA5BtsVa4adD6orFi4IioqjU6eJ/BMrkGTnOGlSywZ1nn/E
	 /dY/z00m4Ax+nR5sl8Fgjz1aWMe5iuUKBJN9u4f0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgDYTa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 15:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbgDYTaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 15:30:18 -0400
Subject: Re: [GIT PULL] Please pull proc_flush_pid fix for v5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587843017;
        bh=n2L4/mjr88k5uaObaoXiyXw7V1lQA62Wol/uoVuasi4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=S0PeTVPM4vZbFXsiIuEXHueT3PRfIqVN7QWb2hITrloFumDCp8mwo/hdLJYQFWu8P
         kg99cHeQQFz/wmfxWNnPsVCwxEKgy2JhAy8AbzlCi+qPUXTVO3TSqP2pVIGe4nTUlw
         2Ol8CQhg4h+kCiWHj/DvKr27Cf6fNX5jiSfKzghM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <878sijo8us.fsf@x220.int.ebiederm.org>
References: <878sijo8us.fsf@x220.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <878sijo8us.fsf@x220.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 for-linus
X-PR-Tracked-Commit-Id: 6ade99ec6175ab2b54c227521e181e1c3c2bfc8a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2768df24ec400dd4f7fa79542f797e904812053
Message-Id: <158784301793.5802.14062877392747886162.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Apr 2020 19:30:17 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Apr 2020 10:58:35 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2768df24ec400dd4f7fa79542f797e904812053

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
