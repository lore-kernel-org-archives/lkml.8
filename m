Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8081DC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E68246A2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582832417;
	bh=fu+IklrsWVvJ32XFn+HVwCRbpTWU3GvpVRiKA2f5pGo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=UF8UCShefsy6/tc/1CzFD/JcV2oxAFsDTr26Lz22MFzJ3WPsh3hO6Gm0E4AMg70OQ
	 eQZBSfTa7OkzQdu0Tu9tSpeqp7/MsCPCIhuLCBRDGlnPg+msWteD2V45EzffPftWrM
	 S4fINkong4CGnkbU5+oGD/MGaVUsG3GNcPeUAwZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbgB0TkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:40:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730623AbgB0TkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:40:11 -0500
Subject: Re: [GIT PULL] Kbuild fixes for v5.6-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582832411;
        bh=fu+IklrsWVvJ32XFn+HVwCRbpTWU3GvpVRiKA2f5pGo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=slA2gp02jix2vdCKyqllixkgiM93hVbJZxZhZRk1fYQiS2Ewla4J/OCZzqaPlfqdW
         oT8wgCO24eS5Jj1JFmofq57gMW/3twcRRaxn4TtHbSmfkQTGuZkiO2eU6/nEKyMfBp
         K14WI0AqkLEztiB2A0544StYIlIIhheZOuLv3zRg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNASDV1hBV_4U6wHHMFfxsxctFhVpk4gUQ+pYMay1i4Memw@mail.gmail.com>
References: <CAK7LNASDV1hBV_4U6wHHMFfxsxctFhVpk4gUQ+pYMay1i4Memw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNASDV1hBV_4U6wHHMFfxsxctFhVpk4gUQ+pYMay1i4Memw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-fixes-v5.6-2
X-PR-Tracked-Commit-Id: eabc8bcb292fb9a5757b0c8ab7751f41b0a104f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2f0b878c3ca531a1706cb2a8b079cea3b17bafc
Message-Id: <158283241095.25748.287321509786595911.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Feb 2020 19:40:10 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Feb 2020 02:16:57 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2f0b878c3ca531a1706cb2a8b079cea3b17bafc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
