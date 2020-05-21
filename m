Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5D9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB29E20814
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590105004;
	bh=HjNf7SWN8ezpCTP8PfgpBvtzLLjYQPpKpLsmvOe3gjo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sngjjd3elomx9oVY83w/14GI49HNrW4UqmL9LZfncQNGHAGDCEYEGQso/SL27ogQw
	 7NTOcIR7rKdcvPkyZWsTgOIx9s0gq4gCkRr+R9nxIZ15wTELDoa3SaNOVrsIT2heJQ
	 gmsEPDTyu90yaMTLgBtNAKrpxD2s+UMZYblUOwyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgEUXuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 19:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728881AbgEUXuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 19:50:03 -0400
Subject: Re: [GIT PULL] apparmor bug fixes for v5.7-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590105003;
        bh=HjNf7SWN8ezpCTP8PfgpBvtzLLjYQPpKpLsmvOe3gjo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=olNvMVVjuDwxtMZu8h7DR0/n4wfOh5GGjcLFNNPRsG0KmCCL44qFCpygJjBK0lIpD
         ZL3mpS5O1Vp437xIiwDAjscVvorX128l/kpkY5yZsmJ9hJy76CSPVUDXotNCl8b7B6
         Yj3E58yDmnTvSFiwaNHc4QbGmm6UxJZoFnn5DAZ4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3155dfe9-0b22-9519-f84f-152542606325@canonical.com>
References: <3155dfe9-0b22-9519-f84f-152542606325@canonical.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3155dfe9-0b22-9519-f84f-152542606325@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor
 tags/apparmor-pr-2020-05-21
X-PR-Tracked-Commit-Id: c54d481d71c6849e044690d3960aaebc730224cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 051143e1602d90ea71887d92363edd539d411de5
Message-Id: <159010500353.16226.13758404686922498666.pr-tracker-bot@kernel.org>
Date:   Thu, 21 May 2020 23:50:03 +0000
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 May 2020 16:01:42 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2020-05-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/051143e1602d90ea71887d92363edd539d411de5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
