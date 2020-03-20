Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF200C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81F720709
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584724533;
	bh=rZAo5O+lN3GPqMvU5RktRv74nMxT/GT+Y45YO/aK2bU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JIxCeX9eIE+T2lzJjDwaiTZMGSr0ksA+mgLLgFxyGsgGcJZi4MxU4tU92TBnnnRz2
	 EVIsg+o3LaHp0X88dHaMvGX40WpSsxj0R0+qSIP+w/UY3i2UkDr9ER2V8qADUVQv+6
	 SfkH14gK5RZ5DiaPfNwATZnqBC7yA36xIRu9dqFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgCTRPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgCTRPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:15:09 -0400
Subject: Re: [GIT PULL] sound fixes for 5.6-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584724508;
        bh=rZAo5O+lN3GPqMvU5RktRv74nMxT/GT+Y45YO/aK2bU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JZtm2ZXpL3HPNNdjG+lSdz2cFoX/JkgZgzDrlUI1WmV5RO/EWdccKRXBT7AybXuNb
         8ScxwJwkOXG6ROLJJ2FIAqQQAbkHCGVl2TMOttdwIRI9/BmPHOaQQfjDmx8NJlMdUB
         oVnCEttBjFMQ2fVuiy1RZvORee4kLqMFaH5fCRS8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hv9mzs2k5.wl-tiwai@suse.de>
References: <s5hv9mzs2k5.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hv9mzs2k5.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.6-rc7
X-PR-Tracked-Commit-Id: a124458a127ccd7629e20cd7bae3e1f758ed32aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12bf19c9268263cf8fc6653966813ff9d5ceef17
Message-Id: <158472450863.23492.261015574928411887.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Mar 2020 17:15:08 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Mar 2020 12:12:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12bf19c9268263cf8fc6653966813ff9d5ceef17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
