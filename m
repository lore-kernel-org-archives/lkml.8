Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E352C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F57622C9C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595007609;
	bh=tKW7MfXR/ekyHWWTF10lMVLg1JvvrAuMIwabffTqn90=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Vj1JNCrsUk0UckE3bTzUQy+/o7gmuZixXqZWrN7sQ/zWpLEp+pYwRZqFNt37PhxlS
	 Ng+TgzYdiWka6Bu/1JrsPgSNicYmV6cWVtf8YBA58rbAy5dxksktj0aVgxE9a3zDLx
	 1QAHjyP9hkS5vRxHcIpLGTqn8Sh44Dp5+kC7cwys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgGQRkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgGQRkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:40:05 -0400
Subject: Re: [GIT PULL] sound fixes for 5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595007605;
        bh=tKW7MfXR/ekyHWWTF10lMVLg1JvvrAuMIwabffTqn90=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=d6ULtDf459YJIEJ5vYV7su+Un7AMV7f+Zi32S7nnQjhRFYsOAxwWqS5N3guHuPgDa
         bXrx3ANgaJXTgXMFau/dWJkWnjah/lvyIWvzxht7viF9lxUPGm/eN+2T7Pj94OmU8j
         D5WtJpXqhjtAvFxYf0S0OVT2EFDE5AsgE20GCdew=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hv9imk4p0.wl-tiwai@suse.de>
References: <s5hv9imk4p0.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hv9imk4p0.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.8-rc6
X-PR-Tracked-Commit-Id: 5734e509d5d515c187f642937ef2de1e58d7715d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a238ac2d6aa587168db943661646883126f3c3fd
Message-Id: <159500760556.14528.14847597320207977049.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jul 2020 17:40:05 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Jul 2020 08:59:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a238ac2d6aa587168db943661646883126f3c3fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
