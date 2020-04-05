Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C0FC2BA19
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D871206F8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586115934;
	bh=moizqoc5JI14FvfsokJUuS5iC740fL3t4MLuM7q6hx0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OXGVxi0k90kmXPbrJFTha9pDtbYRRLMjnaEt8cB3GjdUWrfnxM9jfzKt9WhRkb7p7
	 g3brZQtr5XpjB7GVweq68CR7rNO03tSyuNDuNM6n0FPWywuceFAi2FeLB+KMyXjD27
	 5ohNqJVf6dgA6qVnXc/fnQOD8BkSo4Ux4A3ZaD5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgDETpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 15:45:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgDETp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 15:45:29 -0400
Subject: Re: [GIT pull] perf/urgent for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586115929;
        bh=moizqoc5JI14FvfsokJUuS5iC740fL3t4MLuM7q6hx0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZOVSgZlMpxrv2AcwWErnUTKI3nRtorCYVtSbVHU0EZshvKuFgFhZfmJooBdJd1bIn
         JWp3Q3J/UoHeRvqMZ9Q59zzztSuBxDKvkRfOqF7C2sryL5zkMuP/QpMg/gTANS0z82
         zj5Qvabdvql6sDCToV59n8gkG7AVi7R5C+DuqUfg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158609411109.4266.17403116661607373065.tglx@nanos.tec.linutronix.de>
References: <158609410988.4266.5816311298811487752.tglx@nanos.tec.linutronix.de>
 <158609411109.4266.17403116661607373065.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158609411109.4266.17403116661607373065.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-2020-04-05
X-PR-Tracked-Commit-Id: 7dc41b9b99cd0037a418ac47e342d56a438df649
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c48b07226bd41f4053aa2024c5e347183c04deb5
Message-Id: <158611592940.11305.3488972537035972176.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Apr 2020 19:45:29 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 05 Apr 2020 13:41:51 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-04-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c48b07226bd41f4053aa2024c5e347183c04deb5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
