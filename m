Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CD5C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7407206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598815055;
	bh=lRC1r9SXxyMUzcRz2RCgByi874SQG96D/bTFj2piLW4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gdizqSLasO/r0oeBxKa/8c+grClikbu0CE99xA1zCjiPa9ngqTZ3SmwiHyii0EWY8
	 Y8ZmwZIpjX+L7Vxa1uFbsHpaStRcvIy2yDTUjw+Oegp+2k4UF5cnkpdq4DXDSx5NOP
	 B0PbPuH00hYpS5jd5B1eD77m1dcn9E+FSe2Mzj9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgH3TRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 15:17:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbgH3TPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:15:23 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.9-4 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598814923;
        bh=lRC1r9SXxyMUzcRz2RCgByi874SQG96D/bTFj2piLW4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R40+MLd4ni7Q8HNR3OWmWwoxCOu30W0wKVlOg2wiiVEI0zW1kSBsxBCNG/wxkk7p+
         6aRQxskkP9T55CcOSc88Oj5dY4mJc4aMu9XUat0t9yLXxw7GJRNQJkQAijsgKDjeo9
         car0pgF2CbbB/Au0++5Tv92ConSvT1LyP4bDihBg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <877dtg2uaa.fsf@mpe.ellerman.id.au>
References: <877dtg2uaa.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <877dtg2uaa.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.9-4
X-PR-Tracked-Commit-Id: 4a133eb351ccc275683ad49305d0b04dde903733
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8bb5021cc2ee5d5dd129a9f2f5ad2bb76eea297d
Message-Id: <159881492338.11937.9710630889804906438.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Aug 2020 19:15:23 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        atrajeev@linux.vnet.ibm.com, shawn@anastas.io,
        b.zolnierkie@samsung.com, aik@ozlabs.ru, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, npiggin@gmail.com,
        psampat@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Aug 2020 22:27:25 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.9-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8bb5021cc2ee5d5dd129a9f2f5ad2bb76eea297d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
