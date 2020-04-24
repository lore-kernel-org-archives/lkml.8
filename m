Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B721EC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D1A0215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587753620;
	bh=LTVMrqntJetdGTIRO58rT+vA5NdI+WDIRPTXVcp1uoE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oIqcXEx0J2wEgxZdjMQh18hAi7oxtAOiNqHwRou8DPlxBoGy3rvWKjzRV07X5IbCN
	 4ylDeHgHHmdx5LE773aEQHumwaFrxhybhIZC9tuRtgi8fE8ITPeE20OnwjlAxgXrft
	 Zol8hwEM9QmXN72x4OkCrcKWNQWx/HIiHHP4ePGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgDXSkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 14:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgDXSkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:40:19 -0400
Subject: Re: [git pull] drm fixes for 5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587753619;
        bh=LTVMrqntJetdGTIRO58rT+vA5NdI+WDIRPTXVcp1uoE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FK0J9dooN0ZzQKlvTG/vLPCQSh70tTywweUgHHbNPpLrTUNxZ167kNXtJdia8lm81
         VT+kjXbrlRUv+lCEAb5ZtpZiIKt3NWSm60I/fxmX/9MAWWC8xjfDEBmgtfdz/NqAn7
         YxtPS1bpHUYzi+l81xdHH0pxOqEw5O25/DPDmOEQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txZkNiAoVMyoBwDaew+WDBQu3rcTYOTs9+Vn1unoq9m1A@mail.gmail.com>
References: <CAPM=9txZkNiAoVMyoBwDaew+WDBQu3rcTYOTs9+Vn1unoq9m1A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txZkNiAoVMyoBwDaew+WDBQu3rcTYOTs9+Vn1unoq9m1A@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-04-24
X-PR-Tracked-Commit-Id: e32b2484b3e00170b6cf57d99a18972e174e10ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88412a4e00f6baab2752e99ffdbdb0ee661cac30
Message-Id: <158775361897.26557.6691641549281826414.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Apr 2020 18:40:18 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Apr 2020 13:22:30 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-04-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88412a4e00f6baab2752e99ffdbdb0ee661cac30

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
