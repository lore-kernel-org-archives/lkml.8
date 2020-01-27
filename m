Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8827DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590752467F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580155813;
	bh=qHzd1KJotK3JP/yWnlIZ6pl27AWt8RrFzqTrwtQ9Vlw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oFf91+O+5z/LLw5wCk+mslYONJ3BCIbeUSiZwpCVn0x5Gr7M1sSZCA6t6IVjpy8Y8
	 32maXp88fCXv2nRmiME5eaiwoFg0QhpLFNYeIQe3qy8Uxou7NrGiqzCLLueF7fniOo
	 exUEklNSUNqKiKPqH/JiPkyp94dHWh1bQ3KVzxdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgA0UKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:10:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgA0UKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 15:10:07 -0500
Subject: Re: [GIT PULL] PNP updates for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580155807;
        bh=qHzd1KJotK3JP/yWnlIZ6pl27AWt8RrFzqTrwtQ9Vlw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0DT1WKv3se+buRQ9eaPM1YPUtaTGb9idXoYOWY/gGPYX6PNBj9Ds32RBNiX2m/iwY
         GCAaRatkGdZUFSd9iwRpEnLmQD02X6JLPxOOlslW5JdtuaKsdPj/77Khg4oLuusLoJ
         H7V7EatolWmgg8gkkft2MG0ZHvOR9cZ16kASNQR0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g3sy7N7EA49pbDd951tVfMAgTA8iCPATG9jO0+1mfQDg@mail.gmail.com>
References: <CAJZ5v0g3sy7N7EA49pbDd951tVfMAgTA8iCPATG9jO0+1mfQDg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g3sy7N7EA49pbDd951tVfMAgTA8iCPATG9jO0+1mfQDg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.6-rc1
X-PR-Tracked-Commit-Id: 786c87cd312ad2ec774bc4606834b06844dada6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34dabd81160f7bfb18b67c1161b3c4d7ca6cab83
Message-Id: <158015580709.19143.16570671776546133536.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 20:10:07 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 17:35:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34dabd81160f7bfb18b67c1161b3c4d7ca6cab83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
