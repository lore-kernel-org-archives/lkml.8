Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EA7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 129BC20787
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589563809;
	bh=H7r8JOVXcXDVJJi5IhEOv9pbTm0V+PoBDVDqWSDZuM0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Y31u3y6b+aRZT3qcSWJuA99GjXAfZT+jgqyuzaeEYSeO5RA/JQYCDrXXxdNfrxIs2
	 YlGXyeDq9JwLPOaOFddASM9wVKOfBoq9/T8D6u2mUvCECXw8N0TK39nnIWnXPvhcON
	 XT22meXNjdjVyQpklllLgBvB8lYVEAcj9FX/qybk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgEORaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgEORaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:30:05 -0400
Subject: Re: [GIT PULL] hwmon fixes for v5.7-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589563804;
        bh=H7r8JOVXcXDVJJi5IhEOv9pbTm0V+PoBDVDqWSDZuM0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nJzA09EYFjF/awprp+XUyOQb/YzSGkOcyfH9fyYf70Hcjs/Xq5bkq696I8iAupOoD
         wGzzwk/94bsGS38+BNargOEyE3HmzjE9YS36HDjGM47tEehjOM+er3n7UwqFLLaa0T
         7/BO808LAZf6qwGGQGNiaOzBZZ9agh3HnukFB09o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200515152256.175107-1-linux@roeck-us.net>
References: <20200515152256.175107-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200515152256.175107-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.7-rc6
X-PR-Tracked-Commit-Id: 333e22db228f0bd0c839553015a6a8d3db4ba569
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 051e6b7e34b9bd24f46725f74994a4d3a653966e
Message-Id: <158956380473.31776.13184431620388889550.pr-tracker-bot@kernel.org>
Date:   Fri, 15 May 2020 17:30:04 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 May 2020 08:22:56 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/051e6b7e34b9bd24f46725f74994a4d3a653966e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
