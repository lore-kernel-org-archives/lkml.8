Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A20DC35244
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 19:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37C92075E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 19:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579979105;
	bh=BkeLU+tTLX0zoIaU3Jz0T3m8Bf0jMa5uBRTzt6OXpLQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=MpCmnZ01k77Wx2q6IlxLDTuPBXKzsq8Y8XzccJd8BdxRrn2fs3atRSZZJKZKTCgSS
	 rTxMWwSWGX9X9MH1MRlH/Gi/DngxW6l56UQTFzMQp4XR+EeIZ4G1JpPbbkCGlTFDgK
	 YHTPAJp3ibR+3XlzOKlyozbaiv60V9aoX5P8Y5HU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgAYTFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 14:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:50666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgAYTFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 14:05:04 -0500
Subject: Re: [GIT PULL] pin control fix for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579979103;
        bh=BkeLU+tTLX0zoIaU3Jz0T3m8Bf0jMa5uBRTzt6OXpLQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VHwC6PKaI+vVR3sFuETWR8lMKCW76xHpDNzHPKFo4poXPiQwCzhPrz7EFhO0zOFmR
         Bx6/mm8Kfc9IX1HPin09nrDnqe7l8xYKTqZ4P2j+vSk615YJhunWwdnAMG9Foxead+
         8P74iySyFlWlT8CJk6Mc6uYrSH20iLYbFHv9r7jE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdZ746gURHOeNf3Wj3_7BVHtxjd9Hz2n7QTmqxEroZ0N7A@mail.gmail.com>
References: <CACRpkdZ746gURHOeNf3Wj3_7BVHtxjd9Hz2n7QTmqxEroZ0N7A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdZ746gURHOeNf3Wj3_7BVHtxjd9Hz2n7QTmqxEroZ0N7A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
 tags/pinctrl-v5.5-5
X-PR-Tracked-Commit-Id: 319d5cce728cd70897a1306591a252258fc1428d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93d1a05ea6b29737715769e2c9551cfe8a5fef22
Message-Id: <157997910349.7716.8424591149477886166.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Jan 2020 19:05:03 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boyan Ding <boyan.j.ding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Jan 2020 11:55:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.5-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93d1a05ea6b29737715769e2c9551cfe8a5fef22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
