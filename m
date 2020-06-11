Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DECC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C31AF2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591912825;
	bh=DS6y3SjkcOuZDH5mEngOK5/NJYRknCIaiRGxsskXPMY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=q+mJdwFwkRontj8AucMudsMvkcZ52bhP04UuAGtST4yEvgHiwg+E5zm1+ssSwq9Ci
	 cmHSS3NuLQ/auPY5Pk9KHb0CgvXaiwwfurNDrPwXXOswJozG1JsNSZCKcpaIltVIAz
	 BM3MtrXTdPFovJEpcB8hFCH59ov8jXVSrYdut+Zw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgFKWAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgFKWAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:00:22 -0400
Subject: Re: [git pull] m68knommu changes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591912822;
        bh=DS6y3SjkcOuZDH5mEngOK5/NJYRknCIaiRGxsskXPMY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=e5nLgkDaU8+MFWpp7elBARKWdilIudVKadUZ4MKQpWkeEksjH5DtbaH3oC1kgUt4b
         uH1n1tGjAESEmdoATphfG9/lm/sbuGNUlKwQJJZOOp0UYThqHjRA8a1kmmihh8oXDf
         ed/Nnym+vgRcHfMFjOKX8u6nZ/8W+AV40m3jdeoQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3dc0ca7e-9c44-adac-a3c4-53ab6e0288e5@linux-m68k.org>
References: <3dc0ca7e-9c44-adac-a3c4-53ab6e0288e5@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3dc0ca7e-9c44-adac-a3c4-53ab6e0288e5@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git
 tags/m68knommu-for-v5.8
X-PR-Tracked-Commit-Id: 9e2b6ed41f8f99c97b13c9d15cbef235dbd97fb6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3ea693439833b5ed9b932512e9a90b9381035c9
Message-Id: <159191282248.15411.14728883102312632727.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 22:00:22 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jun 2020 15:21:29 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3ea693439833b5ed9b932512e9a90b9381035c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
