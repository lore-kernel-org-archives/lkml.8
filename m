Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E659FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B723920708
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593972011;
	bh=lAECUTMXAiDpEHH55AjQAiGLqG4MOGxbK0LWwcMZkY8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=04K8cfy8eMZD6Q5G7p2LkGqlsWgI8TFP3kB2/rHAcKe2VzYYkibOic92mD6XcZNRo
	 AZLpodJdagdHRuWePEBoQqINPdYlDr4LU7K7BSGbW4cNgjrHtcLUIIFzp3/bXSZ9wD
	 CNp2a/1a+zCLSaUn3UfFBE0Vxs5pFVmzEn6tHdDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgGESAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 14:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgGESAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 14:00:05 -0400
Subject: Re: [PULL REQUEST] i2c for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593972005;
        bh=lAECUTMXAiDpEHH55AjQAiGLqG4MOGxbK0LWwcMZkY8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pfOgMnW1rSI+60qtadnT6lH2azMS1pLi9lswTwCqixrMakR6mw6G6BOrkx+D+ZN5X
         iAeuFwTsc/mgsP9WVkED0qhv88M0zHzTNHoNpUWoS9d3Kq0zadhngQHfuYaVwqNAQv
         fxbmEhUteHh/n1r8r0UQflexAjtSHwTO9GqzRFvw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200705065633.GA1175@kunai>
References: <20200705065633.GA1175@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200705065633.GA1175@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current
X-PR-Tracked-Commit-Id: 597911287fcd13c3a4b4aa3e0a52b33d431e0a8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7783485401e802b4802c93cb1b23deb7f0d168a4
Message-Id: <159397200509.8921.6186146852508057826.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jul 2020 18:00:05 +0000
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Jul 2020 08:56:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7783485401e802b4802c93cb1b23deb7f0d168a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
