Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CCDC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3140205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588617516;
	bh=nzCS/0VeEVnFZKSnvBrdWW9tNCygeSVuj0l6SJQjV7o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YfLgZShs2A6Jz2McfnFtt6+mFGE+lFcYZqgClACTQEdoPhH/+uiT65ojCBovvTBUY
	 abkjVE6dGW8nPiA7Kd8Zojw++VPF3fKAvuWx+haTNWDU3agGM1gf05Zml1EZPWgbhJ
	 nKnR96H4ULs+TSObj17N/fb8ORKQe3JjkDhV0JRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgEDSia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgEDSi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:38:29 -0400
Subject: Re: [GIT PULL] gcc-plugins fixes for v5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588617305;
        bh=nzCS/0VeEVnFZKSnvBrdWW9tNCygeSVuj0l6SJQjV7o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BKWja+0cIhhqmHJl2smmQeBYDrzaV+JcOrb667Z4iXtu+tKyPNyyPnrS7gsWnYgwo
         jYA7YST+/14SOYCvYKqnaK2s26UZicnsBp3HBOXpLZVqF6GB4NZHAPeTWkhAoq+r2H
         btbehkscE9Ri573TW/QnSIh90RPgYDfEWnoTVs3g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202005041045.BC2557B6@keescook>
References: <202005041045.BC2557B6@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202005041045.BC2557B6@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/gcc-plugins-v5.7-rc5
X-PR-Tracked-Commit-Id: c7527373fe28f97d8a196ab562db5589be0d34b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9851a0dee7c28514f149f7e4f60ec1b06286cc1b
Message-Id: <158861730546.3296.9511173151431427293.pr-tracker-bot@kernel.org>
Date:   Mon, 04 May 2020 18:35:05 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Pierret 
        <frederic.pierret@qubes-os.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 May 2020 10:46:49 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9851a0dee7c28514f149f7e4f60ec1b06286cc1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
