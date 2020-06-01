Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01343C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D119520872
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591040111;
	bh=u/Ee3P9KHgLJRzwrRlkymizP9BKMQ5BqTXXCRaVYxEQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GLU/3HGgZpGbxPMqHqxuye9tfWe7zRHzqmRml3aD6iT9ZRzXAXHx/KnxdYnWZ1fhp
	 az4mWDJhwTMDCgYlKHVhqEmGJxtAqOtGeEPqx9dm0ig7KXR/J73TmGc1ySaqVT1sgh
	 Hn0pQ+aeX11hvZvqTICWvgBJ9JjXvbRBuVaJosgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgFATfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729474AbgFATfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:35:04 -0400
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591040104;
        bh=u/Ee3P9KHgLJRzwrRlkymizP9BKMQ5BqTXXCRaVYxEQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Mp5KpzyOTleXIQKud2LaDCdiFRifVz5yeVVcZdTTL6/8yp71x3rxgxKG8ODoDnkVb
         nTuyc5aYjfC6LVPrDTvukM+ZYL3Iyf/3J95BuJwi2GgmaX4iV1k/sy41c8NPu6SP/i
         Plb0yNOYBvIErTRT7HPnDjg41rwtlIjtaXlGswag=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200522155806.GA9053@linux.intel.com>
References: <20200522155806.GA9053@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200522155806.GA9053@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-20200522
X-PR-Tracked-Commit-Id: ab91c2a89f86be2898cee208d492816ec238b2cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6f91ab6a2bac8580026fc4a5d4724f0b9eeb11f
Message-Id: <159104010398.18844.15058503805552614850.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 19:35:03 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        dhowells@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 May 2020 18:58:06 +0300:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20200522

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6f91ab6a2bac8580026fc4a5d4724f0b9eeb11f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
