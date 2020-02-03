Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31BDC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747BF21741
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580742923;
	bh=GUH+MGIwX5p/S8jn4oeJtrxRzwRJq5/29a0e03ze37Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aFxdpA/2E48+EWHud2Y3Ev/6WN7cVnhH0jHq9hXsU44NjEcp6jm6YCLGcpHB/2MGS
	 JlashFNRTsDvGyLfIwyIYZL9OeaCliiY2LBnVqt3qjZwQPrSz/fN+DZ6VTygs82xul
	 bcgIF0kS7kfpnuemYwgkwB5Rm8CwEdrlywAJnLlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgBCPPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:15:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbgBCPPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:15:19 -0500
Subject: Re: [GIT PULL] Char/Misc driver fix for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580742919;
        bh=GUH+MGIwX5p/S8jn4oeJtrxRzwRJq5/29a0e03ze37Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FLkJS00b/R8r2lEoX3n9ppuUh/EFcoYSdR+gtWGMnTdHENLiSQI/kqP5m/U9uuouX
         hoio04z7v3dtDZ++4No9Pvq1febpeaaUrxAbZF0kW/ZLalLA4Ene38n+jf0S0TJjMf
         CqwDB5nxmJgwIOqkoWxEkq0OJhwHOvOVoON9385g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200203143939.GA3221812@kroah.com>
References: <20200203143939.GA3221812@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200203143939.GA3221812@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.6-rc1-2
X-PR-Tracked-Commit-Id: 98c49f1746ac44ccc164e914b9a44183fad09f51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 754beeec1d9024eef0db8dc4be2636331dd413c6
Message-Id: <158074291909.25778.18249983098947017725.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Feb 2020 15:15:19 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Feb 2020 14:39:39 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.6-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/754beeec1d9024eef0db8dc4be2636331dd413c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
