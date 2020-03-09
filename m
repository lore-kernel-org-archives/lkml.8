Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2593EC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBB62465A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583797208;
	bh=ZE2ffiezrvXnp/6PEvIpJmLiVf3FQc05fW0qI4CJcO8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mbkDF1CGMP4NaoPimAcaNN4kexqkSk4N5bOJft9prg85IgVDweMg7VRTzQCR/qcmY
	 PYk9rW6dJ75I7Vjez4ugB+uvv6y5u0y79z6JNBGjUFUrTashSVkSqhy0WHJ2qAPG6W
	 NKZYIDvsxJy1ZAbNq59OycX3vTdFzl1mnf+/mQfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgCIXkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 19:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgCIXkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 19:40:06 -0400
Subject: Re: [GIT PULL] virtio: fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583797205;
        bh=ZE2ffiezrvXnp/6PEvIpJmLiVf3FQc05fW0qI4CJcO8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZW67oHegO+ZiXPdbxp5Tiq+zuBmfQaAN/vt40ncqjqpWgmoFi/3G70r38UnQfZEzI
         WzlK8MZS1fXimoMbMO0J6Mf7B0O4YnbxKaJyC8kjIHX8R0Oin7QJRDdZIRk01Jzp+f
         n/yTvJf6LdqU+/LfQ+6xDlsIDcz/pPDULL5949U4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200309040825-mutt-send-email-mst@kernel.org>
References: <20200309040825-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200309040825-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 6ae4edab2fbf86ec92fbf0a8f0c60b857d90d50f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7de41b120bb7fbe83bb46e7585c7346d21b93585
Message-Id: <158379720586.7202.3470781027361589881.pr-tracker-bot@kernel.org>
Date:   Mon, 09 Mar 2020 23:40:05 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, jasowang@redhat.com, mst@redhat.com,
        natechancellor@gmail.com, pasic@linux.ibm.com, s-anna@ti.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 9 Mar 2020 04:08:25 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7de41b120bb7fbe83bb46e7585c7346d21b93585

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
