Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC068C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52F7246A2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582832411;
	bh=Ab+qEk1lb/ajwu71W0xKWBx+ma65ivDZoLX8sPVrgBA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=K9CAd200BcgZ60RgNCvrvweQQe9VKawcTDog5KeEkTmOBntQKwYYhuII9A4FOOJUC
	 aoL/0gPgt1TZmFODUntc5fzN/cn3bDOKUoyTjclDkbNwv7SdvGLbn5Utn9ogy4/IIw
	 H8BrribQ/I6Q2N59lJS3qnghyEytNYNw+snnjsGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbgB0TkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729953AbgB0TkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:40:09 -0500
Subject: Re: [GIT PULL] Documentation fixes for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582832409;
        bh=Ab+qEk1lb/ajwu71W0xKWBx+ma65ivDZoLX8sPVrgBA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SO5ZZlsrVWIoJ/vyf1IU6yupQAPmC40newLj2UsbKX0QZxCLFBPAi/WRoWjMmqHC+
         nhgTC0W3WYYP7ZR7G2ziVsUIQtjJ/kh07reioAFwUZfOwgh23226X7nR9MjJ4MS6NT
         0uOW4Pd6vC3aut16pm+vH4t2KnDKBDCD0aIQUtCI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200227020645.212d7c7c@lwn.net>
References: <20200227020645.212d7c7c@lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200227020645.212d7c7c@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.6-fixes
X-PR-Tracked-Commit-Id: adc10f5b0a03606e30c704cff1f0283a696d0260
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e46bfaba593c36de591a1153746af6bcb40ef67c
Message-Id: <158283240930.25748.14722633919442792780.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Feb 2020 19:40:09 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Feb 2020 02:06:45 -0700:

> git://git.lwn.net/linux.git tags/docs-5.6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e46bfaba593c36de591a1153746af6bcb40ef67c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
