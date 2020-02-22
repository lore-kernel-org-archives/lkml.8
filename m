Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7449C3566F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3EA207FD
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582330514;
	bh=W3W8pYm8I7eHMCrdn3ZXX+yGKhlB96u/mT1KxqIfAv0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QokVopbZzD7uRO5bir/hp2vjOsSFNhwDEwSYbjbYpRlMcN3igsMNcEUJf/XDl2foO
	 LA5C8cSXMQ0BVPP1IoGJVbHpqwjY6Prk0r2pSMvQ3dmBOzakjDxLU6kG/EP0l1WzGW
	 O3/iEKwT4Xupxo/EmgT1BoQRMFVl7Xm+v16EGYT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgBVAPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:15:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgBVAPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:15:12 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.6-3 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582330511;
        bh=W3W8pYm8I7eHMCrdn3ZXX+yGKhlB96u/mT1KxqIfAv0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JIIpA3aScnOPW9wex9YeSv3xkK8mNA43T2pRU1hOt0f3jiXHwjoni/RUHtw+6ja88
         I2F8Ep2WScZrYfaVPCTzeLQa6z/WOQNSp4Y0BHtU14QOD0l/EJU1PyyVTbVfCzs2bq
         /eH8PxCWnK/zMaW8MQl+3nkuJMAJX/vdiQ8Hae/0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87lfowdv54.fsf@mpe.ellerman.id.au>
References: <87lfowdv54.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87lfowdv54.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.6-3
X-PR-Tracked-Commit-Id: 9eb425b2e04e0e3006adffea5bf5f227a896f128
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2865936259e27629fac422bc80c9b55ca1f108a5
Message-Id: <158233051185.15315.18250424563849105546.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Feb 2020 00:15:11 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@c-s.fr, gustavold@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mikey@neuling.org, oohall@gmail.com, sbobroff@linux.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Feb 2020 22:42:15 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.6-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2865936259e27629fac422bc80c9b55ca1f108a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
