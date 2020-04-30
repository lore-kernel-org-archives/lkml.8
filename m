Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8405C47257
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 23:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 788342495A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 23:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588290613;
	bh=HWovgElU4hW1BKQU5J0aUpKsqfA7ezE2T/76G2IjHko=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dHtHaUHQnVeBV/LdMgwEofOm2NJGu5JRvKlRCisLUp8/Oh3gzEJ/dQzDbt9DagV+x
	 2bLjZ1wnutz+LfR2nwpcobkTt/ehtT3jiD8l4zhLHmMCoMKEesY7dFEPkBRiD0ZZyS
	 aastxPaxfJdx4KY4F2+kwBvlgPYDpCqLkmSyda9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgD3XuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 19:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbgD3XuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 19:50:12 -0400
Subject: Re: [GIT PULL] Kunit update for Linux 5.7-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588290611;
        bh=HWovgElU4hW1BKQU5J0aUpKsqfA7ezE2T/76G2IjHko=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UzhnhWOyx6EDMeadZiRcK7ZnhRrXClDXVKcb9Lxf2dxGmbihy9zmgGgIamoFqbLrN
         mb7B7BsLLYy5oklosJNritD0xDdlfWz15W0tA3y29SWPPijWbQi8y4XllqRHuxi857
         3HkHez3lkEqUd6qx5u2Xr3SwQ3fSL4hvX+MMCdVU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c5edb7c4-c5ed-0209-3c7f-cace9d775d64@linuxfoundation.org>
References: <c5edb7c4-c5ed-0209-3c7f-cace9d775d64@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c5edb7c4-c5ed-0209-3c7f-cace9d775d64@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-kunit-5.7-rc4
X-PR-Tracked-Commit-Id: 6cb1818798812fe7e2c8fe3f489ad1c86adfd6c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0468915bdb7cd3160c892664a53ce320e254281e
Message-Id: <158829061177.2910.14526058322469740978.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Apr 2020 23:50:11 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     torvalds@linux-foundation.org, skhan@linuxfoundation.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Apr 2020 13:26:18 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0468915bdb7cd3160c892664a53ce320e254281e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
