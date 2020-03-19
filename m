Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62D0C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE91520836
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584638708;
	bh=lnsQjdeqJQsdSGPoMaKkmJ46L3EHOJRkUYALAl/T4nI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CUYw47HiC+0P/HDVwlUi7XnyfGZL0/a1hu0h0um6PU0vE2UK+LbTOKaMFi7GSB7xu
	 f1gj19HStbVpnVYZpFC77+mKgpSr0WUWoRBVPFxKdrnJsDbN/pxKMct8HRhqdsCf74
	 LyazbCU92qZ5gqOumTPc7z7ONbrYtJbefBZaf0VU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgCSRZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgCSRZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:25:07 -0400
Subject: Re: [GIT PULL] CIFS/SMB3 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584638706;
        bh=lnsQjdeqJQsdSGPoMaKkmJ46L3EHOJRkUYALAl/T4nI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QfURL3qSTgykW8OKyPew6FC2qUrN+6/U1ZCOiFVKUtL8cKHL3n4GJHltI+6X+J/OO
         rzpswnOyInQDAqygVyXYmYzPstfdrzozoUuKiylrQ39vVV+LIQ4eam9xCQW3/2Shfv
         UW1Bxi+FiM0wqRGrjBz3OUqMaWHd49QCYE5E7aNM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msOYEYH_YrSwGn6KYW83U0kyNS9U04xLgVFMx4xr32J1Q@mail.gmail.com>
References: <CAH2r5msOYEYH_YrSwGn6KYW83U0kyNS9U04xLgVFMx4xr32J1Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msOYEYH_YrSwGn6KYW83U0kyNS9U04xLgVFMx4xr32J1Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 5.6-rc6-smb3-fixes
X-PR-Tracked-Commit-Id: 979a2665eb6c603ddce0ab374041ab101827b2e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd607737f3b84432b8a00cd31ac753dab1c38678
Message-Id: <158463870646.20508.5032357592544063265.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Mar 2020 17:25:06 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 Mar 2020 23:51:13 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git 5.6-rc6-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd607737f3b84432b8a00cd31ac753dab1c38678

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
