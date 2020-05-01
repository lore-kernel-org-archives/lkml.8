Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2D0C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF0A21974
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588358115;
	bh=2WT6aiHZPuq2kVjyUjT09gDN6JPwEFNG4Npx11qayos=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zq6epm0eAEbKuYhOpm9IRhUwsvkgrsSRoRuLrY3LJ9amEGB7MuozJX7wlvd1CO6k3
	 VLdHWtOiyzs+oeHKhbiD/OTRHTDBc3PzpfxXN2lWwRk2VEBDUSHkeq+cUVDenvHtcp
	 l35UPqtK2e78mVK9OAuCiGCC/81x30QRs+DzQwT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgEASfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730189AbgEASfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:35:12 -0400
Subject: Re: [PULL REQUEST] i2c for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588358112;
        bh=2WT6aiHZPuq2kVjyUjT09gDN6JPwEFNG4Npx11qayos=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mfa9OwJn4J8fmDWRwxqqB8DMAgF7rxMBwwDT8OsDEHjdW+bqrWJtmsdXckMGAYedy
         3aF24rA8yRIbpYkLwteciHiPnemGzCKqvSb0J4Yk5WAOpbpnD3Nf/pzf3qUnDV+qBT
         1MiO0vohmQPcKWlJUP/zMDlUYnToSZXmNrm/GZ1A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200501145014.GA24395@ninjato>
References: <20200501145014.GA24395@ninjato>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200501145014.GA24395@ninjato>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
 i2c/for-current-fixed
X-PR-Tracked-Commit-Id: c926c87b8e36dcc0ea5c2a0a0227ed4f32d0516a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab386c46e44eae70e2c23f27fea70014758cbbac
Message-Id: <158835811239.18489.9681586703398147281.pr-tracker-bot@kernel.org>
Date:   Fri, 01 May 2020 18:35:12 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 May 2020 16:50:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current-fixed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab386c46e44eae70e2c23f27fea70014758cbbac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
