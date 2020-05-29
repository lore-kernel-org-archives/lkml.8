Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53976C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF2B214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590786609;
	bh=MqSKC4szqdRygKLm1IzOCwllN8Az0h7L85M0MyP5DS0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bHRTn96E0i5UOuhySa2psAdZNdoOC7G9RCokKeMTV79p5+O24kNl2Z+YMCGvH+ioF
	 7ez/sfvYLV5BJfdFlN2DlL3FgaVKYKsYpWkdLXay7/4uR7+/H8hDKmwXqATVDkp+uJ
	 JrTtFtQk2wJjqi6MMQDJYrw39cKNvWZi6YqMSSXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgE2VKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbgE2VKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:10:05 -0400
Subject: Re: [GIT PULL] sound fixes for 5.7 (rc8 or final)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590786605;
        bh=MqSKC4szqdRygKLm1IzOCwllN8Az0h7L85M0MyP5DS0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gD/8ii64ZPL1OoJMzl9jh+d3H3TRsTdf9qq1Djsfgir/gf8Kn6BH1hf83lJMXR/+7
         K4u3J+0447xz4DmewglDUPJw8fDk48TNXnKDb5Qq9dAcx3iuxmka2lUt0wqOyMy/NE
         G2aJRNuS168TTpNPL6eJdxN5sSeXCszFmfrQRLoo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hk10vktn1.wl-tiwai@suse.de>
References: <s5hk10vktn1.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hk10vktn1.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.7
X-PR-Tracked-Commit-Id: 630e36126e420e1756378b3427b42711ce0b9ddd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d54b64ef0df92101286cff739f95dd89e52ec09d
Message-Id: <159078660494.32003.11323150083221489004.pr-tracker-bot@kernel.org>
Date:   Fri, 29 May 2020 21:10:04 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 May 2020 10:55:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d54b64ef0df92101286cff739f95dd89e52ec09d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
