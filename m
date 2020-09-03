Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83958C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF96208B3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599152970;
	bh=1IkEePEIll01Z92NpfKCXg46IdmJidHc/uoirtAIPBk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ilgN+BK3ShFkjGFyoz3kQJ+jt3URokIjn5NUriCVjFnipb0odcqssqlT6igQ38Rxl
	 TClfPRC4nFHXZZItHm4NGo73pQdhNj/tUPsIT8HaT/g1xKBt9i8/Lv6F/zyezojqc1
	 L+DiTBXb2Nt8zZ6hNQhi7oQpwDHp60piCLNh2OiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgICRJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgICRJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:09:18 -0400
Subject: Re: [GIT PULL] Fix min_low_pfn/max_low_pfn build errors on ia64 and
 microblaze
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599152958;
        bh=1IkEePEIll01Z92NpfKCXg46IdmJidHc/uoirtAIPBk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bPM5ARFAkx9qZuI3rNkWTUkWgPFn9NxKNiG+99zbKZRNkz2dbKE4EwNmcuLomBRgy
         Bi7gLgUuVkRPuWdYEys0XPTAGSyRKq8/DZhy74WghgOqnTwHAWiJcJlOdnRlM+4QRb
         bukOukrH8/eJbmOG0Su1lmQT9cR5LwyuLsCcTY8A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200903145438.GA1781636@kernel.org>
References: <20200903145438.GA1781636@kernel.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20200903145438.GA1781636@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git tags/fixes-2020-09-03
X-PR-Tracked-Commit-Id: 5f7b81c18366c38446f6eedab570b98dbdc07cff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e28f0104343d0c132fa37f479870c9e43355fee4
Message-Id: <159915295844.22690.13812822281386649645.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Sep 2020 17:09:18 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        kernel test robot <lkp@intel.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 3 Sep 2020 17:54:38 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git tags/fixes-2020-09-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e28f0104343d0c132fa37f479870c9e43355fee4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
