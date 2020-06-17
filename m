Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE73C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6D320739
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592354732;
	bh=86pGc+/tozmUEw8Weuw+lobVvXEYiYnitipnG9NNpBA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wpl4kZ3WtuVZ3am1WmYgSxP3PBJHfOvFDQBDEoYadKtoPqvdes37PST4DZDClIOX2
	 H6MCnQpdek31PMKJ64k4IS44ROxSfNq5as8jk+YwzhwHc7b3+qO1P6Q5lcRvtflltY
	 vKeqbUBZd7afQnpv/erjYPt4JgHR5akgyeTaikYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgFQApZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 20:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFQApX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 20:45:23 -0400
Subject: Re: [GIT PULL v2] flexible-array member conversion patches for 5.8-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592354723;
        bh=86pGc+/tozmUEw8Weuw+lobVvXEYiYnitipnG9NNpBA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sRxzkGwzCyCRTt3Q/frN0Epwcdz5r+MNjtP2w4vWFyhhQO5ahiGTCQ46Y4dhWdjTA
         sDeZu8K8uwkIsLoxyIojauklWpl0yE49INyrp8u9P8WmbGmeTRHvaKs5Ruy74b6781
         BGJdg+qnVHQ60DptK1MrNpBUDucgLHA/2urVTWds=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200616045155.GA2728@embeddedor>
References: <20200616045155.GA2728@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200616045155.GA2728@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
 tags/flex-array-conversions-5.8-rc2
X-PR-Tracked-Commit-Id: 76fafbfffb447d2a5a95d5a9486b0217c00f9785
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffbc93768e9d3a3dafdd90124b1244b4723d30e8
Message-Id: <159235472341.15875.62064333386436917.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Jun 2020 00:45:23 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Jun 2020 23:51:55 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flex-array-conversions-5.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffbc93768e9d3a3dafdd90124b1244b4723d30e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
