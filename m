Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE07C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC27A207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580146512;
	bh=hqzU+k91YplbYcFktJyLQioGAqZazvT3yznS3wfsK8Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=seljTwtao8K3OPuX6C/e/KP0xZdhq0910TbuxzYVBrBnAjY8ZyUxRH4TxIK6ABYJF
	 +BsBKlBmeo/0fYMA8VtEb3WdOo9krvJGH654BzOxdET3wzGDYFGLWdGSlvYlEzcWBQ
	 81W0rC+V+qtBF9s9ozEPvGiTyoRK2MPvhNEeYT0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgA0RfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:35:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgA0RfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:35:06 -0500
Subject: Re: [GIT PULL] x86/microcode for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580146506;
        bh=hqzU+k91YplbYcFktJyLQioGAqZazvT3yznS3wfsK8Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zw2A3fZxKpOEEhgXbmxwf4KR8bFo7lrHh8XtDhEsBrTW+geld0aXJIuxT9BYC6Coq
         s+qj56vNqvtp6o2e2A+03sx6aqQOUIN+R+ksfXR0J9egKQ2WeOeWEax3Bn8rU+6lvd
         cF3ZTdt5n5X/E0c6PEx5C8vxtu4Gn8wFjhewrW08=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200127113903.GD24228@zn.tnic>
References: <20200127113903.GD24228@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200127113903.GD24228@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-microcode-for-linus
X-PR-Tracked-Commit-Id: 82c881b28aa89215a760e39c5f6bcde2d6ce4918
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 067ba54c7a7d4cb76da4c8434bd6f117b61ac8ee
Message-Id: <158014650624.9177.7484134068206327534.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 17:35:06 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 12:39:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-microcode-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/067ba54c7a7d4cb76da4c8434bd6f117b61ac8ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
