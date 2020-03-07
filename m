Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726E9C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 14:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415092073D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583591419;
	bh=Ev86iZBoGTPXKQRhi2ePP6wDemQ7zCT9lln7nV8YQTw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2qQ8HqH487g2inFWHj7wSVV6wnCIq7rh+1xxgXUIfvZaVnUq/mvFHOxdxCmgG1vZh
	 4TvhFzJ6h4cvG0S0C7Lom/7vV4C/FWFcJ+eyMB4PqhYczSqskIEos/Fv4FdysTP88H
	 oMaGPvOh1b7+G+fAf0A/gcb/VnExTKV+k/BV4cl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgCGOaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 09:30:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgCGOaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 09:30:09 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.6-4 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583591408;
        bh=Ev86iZBoGTPXKQRhi2ePP6wDemQ7zCT9lln7nV8YQTw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PU672xzDIEtQG3VLGQv7+zqW75tm4K+w4i9PBqVYk3inxljrS2ZFCVmGVzhYsVOpE
         C28wH4KwV9S7wmLTLkcVGeCgqNcmjseB+XtsMbhSu3XaLRJ1aLPtzHo777jHKOgncN
         BE3XhTM0Fyadfengg0l0ARSlDIXGM1m0q55O57L4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87imjgpesz.fsf@mpe.ellerman.id.au>
References: <87imjgpesz.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87imjgpesz.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.6-4
X-PR-Tracked-Commit-Id: 59bee45b9712c759ea4d3dcc4eff1752f3a66558
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5236647adbae2d4cfc11eda20a38e0a300b97e73
Message-Id: <158359140879.13770.6319462140753604746.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Mar 2020 14:30:08 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        desnesn@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, naveen.n.rao@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 07 Mar 2020 22:47:24 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.6-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5236647adbae2d4cfc11eda20a38e0a300b97e73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
