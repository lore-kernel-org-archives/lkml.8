Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582E5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3517020823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590006609;
	bh=WDeYoHot53ESIixuTZ65c/GG9a6J/45XWKc8BZEBD1Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=arujvIEy8+BPSLVNHktoQEji98uEyVBLi87GMZAQTFskoAlQKlC9hoV4g2IZGOh0p
	 CZCAHzHzDR64U9rrPysypV+bORYazSaL1TPYBShLzRFqm5ns4QRzH13OZwefDw2M9g
	 zTI5oo9TFuduxppQhfogFMvF3SWzHetyQLCJGrTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgETUaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbgETUaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:30:04 -0400
Subject: Re: [GIT PULL] UBI/UBIFS fixes for 5.7 final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590006603;
        bh=WDeYoHot53ESIixuTZ65c/GG9a6J/45XWKc8BZEBD1Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=D7zjVYxx7gu1Tg20tNJ4G2Tqx3tHKcaevDFh0D/ZXSXW1mKvZrfhILlJ/99TzfJ4c
         Nq4em4EstKjKGmhftyPT2tuQa4paBJx9espfeSO2Gamxy4SUy8JE1ATDTLEyf3Rl2L
         8Za6OuKL89RpAQR9APlNIQVX0GyggDXayn8SqMjc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <294087931.249343.1590004178869.JavaMail.zimbra@nod.at>
References: <294087931.249343.1590004178869.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <294087931.249343.1590004178869.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git
 tags/for-linus-5.7-rc6
X-PR-Tracked-Commit-Id: 0e7572cffe442290c347e779bf8bd4306bb0aa7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fea371e259ebcc85d2d51a036743189bee487289
Message-Id: <159000660389.10849.13761453252049235258.pr-tracker-bot@kernel.org>
Date:   Wed, 20 May 2020 20:30:03 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 20 May 2020 21:49:38 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fea371e259ebcc85d2d51a036743189bee487289

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
