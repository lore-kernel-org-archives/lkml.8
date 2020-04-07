Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB22C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5679420748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586289333;
	bh=X8SARuotaC6mxy/ctY3ZlwjUF2pQ/3bmecn8BGIhhAE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2JXT0esZ1piikfvT+ajOXWYZHuTYYTBcMsmj1UisBfE1tvx7Um6nwMYcAMHa1B1ZY
	 gkIicGkbEpIyjfOCrzYTUX61uVjAfPoHTPf39nKxzg0MUFNvPPrgZ4OLOZMZDlUlj6
	 okyRCbOaq2Jy4OWt9kUj89Gs1otsFFo0m8MqpIkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgDGTz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgDGTz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:55:26 -0400
Subject: Re: [GIT PULL] OpenRISC updates for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586289325;
        bh=X8SARuotaC6mxy/ctY3ZlwjUF2pQ/3bmecn8BGIhhAE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c/XBGjzE5XMyfx+zpkZdxkxk2QleADHbPwLivvocpZhjRLEXbSQnabVH6VB63HslF
         6GbMWvauRkva/MHK0CfCRIsgpsNrd2gk5QLJeK7pJT1F76VQ0QaFz0M/HUS0q3qKD6
         8m7Mv5z6QXQ+PSwdCebOhpeadntXhn7pSocbaYhA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200407121628.GP7926@lianli.shorne-pla.net>
References: <20200407121628.GP7926@lianli.shorne-pla.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200407121628.GP7926@lianli.shorne-pla.net>
X-PR-Tracked-Remote: git://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 9737e2c5f0bc768b58416ec070bd96c91c52a153
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5d247661e869b71e4db5ca69b08b9607895d496
Message-Id: <158628932584.3792.16656826106512591465.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Apr 2020 19:55:25 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Apr 2020 21:16:28 +0900:

> git://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5d247661e869b71e4db5ca69b08b9607895d496

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
