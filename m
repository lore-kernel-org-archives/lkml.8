Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45572C47409
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D63921927
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580926815;
	bh=0a70b+4E7exBQp+DOqVsonSh0Vba9xag8BcogyB7Dew=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=eRH4guHN1DY0dczXmZ5+I+jn1vSMBM+VzD86AaFJpIuM6XBf+BRCCDhM/tab00gIH
	 /qGyaA5NGXtW7ERiXB6rhZk5GxLFW3x51RfAr3/fPTt7z2awa92tg7Wo8xj9Qf/9Iw
	 6F27d325KDRc/RXHqzvA/fc6/d5vD4jxvo3tUJmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBESUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 13:20:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:51752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbgBESUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:20:14 -0500
Subject: Re: [GIT PULL] Devicetree fixes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580926813;
        bh=0a70b+4E7exBQp+DOqVsonSh0Vba9xag8BcogyB7Dew=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dKMAT9HAfAbqNLt/RocVMIrTzd6lAhwqNqYLmr4M+7OzjuaLeHRkNuubg/rRIVU+H
         Mnw4T7xCPiT596IGYCiwmUBMeuSnfcJlFYk3NADERydHuRCpfdeFItpP3GwyBBCclN
         Fdff9F5TiS/3TeAf5y9dzyUojhT+EbmecahUb0zM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200205092506.GA31689@bogus>
References: <20200205092506.GA31689@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200205092506.GA31689@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.6
X-PR-Tracked-Commit-Id: 04dbd86539fd2f0a65fdd5a0416b7f6606f95e16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2634744bf38ab20d17fe8220f1f83b6f3801386f
Message-Id: <158092681349.14135.11727759666679610322.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Feb 2020 18:20:13 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Feb 2020 09:25:06 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2634744bf38ab20d17fe8220f1f83b6f3801386f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
