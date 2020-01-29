Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF71C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69022071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580324417;
	bh=tXKQnpqyzv/3jq3kxrPbXyFJC2Dm3jjakMtdUV7QSkc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OCf4kteSGHiQHOCLkyuHqdjzwJopEfLr+4G3NNAPo9xmdcSt5uEo8D2VFM4QJT6bs
	 TmdDPD+89NJO3R5Ou/ZSWt4RLGWKzKuSOuIDcg/YoaTedMQueZTCsi8cWFhltW9GAl
	 DR1APFWNb5/7bRGG0/Av/nmn4m36WGVoHtZE314c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgA2TAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbgA2TAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:00:10 -0500
Subject: Re: [GIT PULL] Char/Misc driver patches for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580324410;
        bh=tXKQnpqyzv/3jq3kxrPbXyFJC2Dm3jjakMtdUV7QSkc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PcMwUafbQVZWospJAHTXvjA/91MAN2xfdlbRYV55WW5+d2nSN60twrTDy4PV1elQy
         l1Cbc+FPdSX/CJBIfhUukKuPV/xtyR4z8trpBTCY1cmh9F9x+6b5tD/6lUUqmwFpxi
         7zX/4FQYHZA7Xg31HN/TrcMNMAbZdkuG84IGTYGU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200129101523.GA3858602@kroah.com>
References: <20200129101523.GA3858602@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200129101523.GA3858602@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.6-rc1
X-PR-Tracked-Commit-Id: 0db4a15d4c2787b1112001790d4f95bd2c5fed6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 701a9c8092ddf299d7f90ab2d66b19b4526d1186
Message-Id: <158032441008.15518.5224890766145091657.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 19:00:10 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 11:15:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/701a9c8092ddf299d7f90ab2d66b19b4526d1186

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
