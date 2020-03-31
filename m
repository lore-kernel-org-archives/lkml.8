Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB753C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBFB20643
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 23:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585698917;
	bh=5XgE+VOpFzknOKkgzwBf3/kioX86cuFPUgz1Em0Eph8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=cPFLEN6gi1EqmQJVxbo90RdMt58aW8zvjUQ17QUj82Uf5ZtF7TxsMhLOfOTe5HfXL
	 0pg/XfLGlJPb456etWJx2AFMQnYMkkRwuJkDU03oxJIjsshPLav7oRVqqSvsExu3bf
	 PIZuBUrEB8A+EDyjzD3g3G6J0RSKK3MYUfG8g07M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbgCaXzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 19:55:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732024AbgCaXzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:55:14 -0400
Subject: Re: [GIT PULL] Kbuild updates for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585698914;
        bh=5XgE+VOpFzknOKkgzwBf3/kioX86cuFPUgz1Em0Eph8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HjhH70rGgrFs90WsLwOkO/N53WDB5puoqL8uA+l6PvS19JGJOtf6LqF3YlglKeJEG
         EBJQYWYbZWw6JS/HmizinXVMTyE3Xk8xspZLoOZfOCG9HKjzVn0DXi12YtpGRHGdFd
         HXPB3j9mzB+cwjF8la5cY3Wclb9OVELvHamYz+ko=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAT=8t1eGQb=NFrQhoCemTqTiNm6b2N66wo87sUAY5xJeg@mail.gmail.com>
References: <CAK7LNAT=8t1eGQb=NFrQhoCemTqTiNm6b2N66wo87sUAY5xJeg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAT=8t1eGQb=NFrQhoCemTqTiNm6b2N66wo87sUAY5xJeg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-v5.7
X-PR-Tracked-Commit-Id: e51d8dacf2724ebb8eda8ec69dd81da4f70a4213
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b67fbfc32b544daa7f4e0f4e0ecdec4e4895938
Message-Id: <158569891410.16027.17776005591975074696.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 23:55:14 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Apr 2020 01:28:16 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b67fbfc32b544daa7f4e0f4e0ecdec4e4895938

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
