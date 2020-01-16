Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A206C32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 00:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AB22084D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 00:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579133705;
	bh=pe8T01hhSlDS/Xmia1m9m4JnW9kz2uLoHUlYkHPXOP8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Uz2bOkaUykxW4EynpJAtRheHOGAAIRHdX3sBKI9JXK/JK8jG3hv4vrgx7gWHWR/56
	 7iBzMVMIaY+BLbeS+ARBCMvuahmt4NjoKLoccmvprZ+ixaADhkdzKpR3Mw/AuBZ9uY
	 YPrFiWgGYvQwxjGy73RxHPFX+9zas6uSJBK2bnq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbgAPAPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 19:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729880AbgAPAPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 19:15:03 -0500
Subject: Re: [GIT PULL][RESEND] arch/nios2 update for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579133703;
        bh=pe8T01hhSlDS/Xmia1m9m4JnW9kz2uLoHUlYkHPXOP8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o8EnVk6nFzcRnW1ozU8PdK/nvHoxUZqDiHqyH32iA7zFx+zSoOVZjEy9fub9qy2J+
         yZtXHkBQCNPy51qVSCwudZMnGnaxjAMRlpfdi5MSxNVlF7pdqWXDTM1F9IxYlyeDGZ
         1tMvQBY2dUM0RUvKpQh+obP56WmZfcGNDK5osOIo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <MN2PR11MB450981DBCE5894AFEE2B016FCC360@MN2PR11MB4509.namprd11.prod.outlook.com>
References: <MN2PR11MB450981DBCE5894AFEE2B016FCC360@MN2PR11MB4509.namprd11.prod.outlook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <MN2PR11MB450981DBCE5894AFEE2B016FCC360@MN2PR11MB4509.namprd11.prod.outlook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git for-linus
X-PR-Tracked-Commit-Id: 051d75d3bb31d456a41c7dc8cf2b8bd23a96774f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4feff2264dfc144060582df8ac461fa47679b91
Message-Id: <157913370337.14410.9025298056818510255.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Jan 2020 00:15:03 +0000
To:     "Tan, Ley Foon" <ley.foon.tan@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "'lftan.linux@gmail.com'" <lftan.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Jan 2020 00:06:16 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4feff2264dfc144060582df8ac461fa47679b91

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
