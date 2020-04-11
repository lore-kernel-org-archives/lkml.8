Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EFFC2BB1D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9952082D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586568033;
	bh=V+MDJpnk9Wx8HNhilLv6ed2m7TidFGSx+wD3TIHvo4g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pSzg/b2ITNSuCpDwmIGRFTJyazeqqR35MgIfjW/6WOhcvts11Va8z26d26/iPEpbc
	 39LgC47nHKnk39vGzOPwzTo21aCkatWkFw7CWrxN/ecqn9wPQhSKDIpxd9m7iuGptt
	 V2eJ7swsK4B7T27QqhmHw4xBOygUaKigyAJqy3PI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgDKBUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgDKBU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 21:20:29 -0400
Subject: Re: [PULL 0/3] xtensa updates for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586568029;
        bh=V+MDJpnk9Wx8HNhilLv6ed2m7TidFGSx+wD3TIHvo4g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0AhoSOgdngMTmvIIuEnqJV+KG9kyVD563x7fsvgmCe/wh8ucm2RtA5RMmoijLpLfz
         6/2+EsxIoSr7hHV7CwARcKkyfyrkPgne0lgytn/9XRomwbsWhdj3Hp1y/5lt38+Zgr
         aEfiLKmfu7EXAG2TISSrIaGpoRTiPGlKB+KwvkNo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200410195331.12735-1-jcmvbkbc@gmail.com>
References: <20200410195331.12735-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200410195331.12735-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git
 tags/xtensa-20200410
X-PR-Tracked-Commit-Id: 70cbddb973859158731ce77ab20cd5e53822c089
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9539303a9baadde968cef2ffb6cfb48b4f63d1f5
Message-Id: <158656802933.16442.12156669957653820765.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Apr 2020 01:20:29 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Apr 2020 12:53:31 -0700:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20200410

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9539303a9baadde968cef2ffb6cfb48b4f63d1f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
