Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02603C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 18:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3ED320789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 18:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592071240;
	bh=Csj47HE+oJ1KGrLz38q4Gar3ApcNTulZI27Kjq+KAug=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=U1sYu5lNapMBI+nM/WzadqO/146j+XwMtqCCcWUED2SepxlLebhUPWut3k1JwNSTh
	 D07yFwiLztPH9Y2woxhKBlR0ziiRP3dC0kKUMEpXLg+fWvTP7lFLGx0vMqET20Ptxc
	 g4X6Z2FpDkoPO9N2PJBAkXA1xiPkdruxY9jOp0Ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgFMSAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 14:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgFMSAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 14:00:35 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.8-2 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592071234;
        bh=Csj47HE+oJ1KGrLz38q4Gar3ApcNTulZI27Kjq+KAug=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ap9Nz1fa39V/q/lZzP177OzmQtbHAhekJ0kaXR/tJjpqfJfat92a1ewaOaj2Lb1gP
         n5XM6MP10mAn4YhuYBSNq/0aU4biooZ/MbsJ2M+kbtm5m6AGZOjDRgme6+tuPZh/fp
         7N9e2B9OndE/ntSZdLNhhBGci5xisWY5+8/B3cA0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87y2ordqcm.fsf@mpe.ellerman.id.au>
References: <87y2ordqcm.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y2ordqcm.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.8-2
X-PR-Tracked-Commit-Id: e881bfaf5a5f409390973e076333281465f2b0d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 08bf1a27c4c354b853fd81a79e953525bbcc8506
Message-Id: <159207123480.28894.13432295695518771153.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jun 2020 18:00:34 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, aik@ozlabs.ru,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 13 Jun 2020 23:53:29 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/08bf1a27c4c354b853fd81a79e953525bbcc8506

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
