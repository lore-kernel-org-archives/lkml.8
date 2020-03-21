Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3DAC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 16:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51DB20739
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 16:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584809109;
	bh=w8zbmzctDgDYpvxXlZaa1Pbgdy23s0nWznWTWfL4WuY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ncNMtxgecU1lK8GLg9Z9nJ6umPdU/WLAxqAfPcuEPKyibLEIWPG6qfYNOcNGpnexi
	 BKTufSnh/Eqq029Dn4JhIwyE9NdMWHhS2S70yta/ovcrlcoCWOXhZK5X9z0MklGZy4
	 7KzuQ6Ud79eRXcC3H/QXdbFldR9qgxxIUS1dtHG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgCUQpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 12:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgCUQpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 12:45:08 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.6-5 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584809107;
        bh=w8zbmzctDgDYpvxXlZaa1Pbgdy23s0nWznWTWfL4WuY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wtfrOrpP+I4B/wbtIj4KS6umVYuEbARuxu99tg7a5+HUvBREeg1eZwV/vxiQdTYuQ
         6eNsEhKnmvYBc2/Y+lmOR+4R5VKNAfcfRGAlyu+Ta/phuSmXGLLMIwCWrdmleo8T2r
         L0oQvKCzt2yFhHJI7nmVLkIVNKq0hrE8bV24XzJY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87fte1dg0x.fsf@mpe.ellerman.id.au>
References: <87fte1dg0x.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87fte1dg0x.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.6-5
X-PR-Tracked-Commit-Id: 1d0c32ec3b860a32df593a22bad0d1dbc5546a59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c63c50fc2ec9afc4de21ef9ead2eac64b178cce1
Message-Id: <158480910775.29703.12350611387973365171.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Mar 2020 16:45:07 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@c-s.fr, groug@kaod.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Mar 2020 23:54:54 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.6-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c63c50fc2ec9afc4de21ef9ead2eac64b178cce1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
