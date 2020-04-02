Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33429C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076192072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585867521;
	bh=PakBf7akxskSU99wEll/YnEXc+/sHzL3yLGiah2X1Eo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SvnhksERHCwRBrgYGwx2TATzMVREcSVFQm2mM5cZpPwh0Ql03K0Z+/aWm9x4BrXfA
	 fq/iahUdZ28j5pnQSxwTECE8ccGB4M52pw/v9tRM+GZ85WrNwvzxzZEo6SGr3iq8rw
	 cdZRhT780mXB8ltSrWIRd85L2VKV9oHPAgfFYQRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390378AbgDBWpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 18:45:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390361AbgDBWpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 18:45:18 -0400
Subject: Re: [GIT PULL] First batch of KVM changes for Linux 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585867517;
        bh=PakBf7akxskSU99wEll/YnEXc+/sHzL3yLGiah2X1Eo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rEEiZH4aZaLm1RD55uQdwPICiMtiZXHtipGrGLhnkAdW9VLQbpCSQ6o+rLpjfISkV
         oEJLSihxXkVK3k2JVdk8ampcHA94pm5i4q68SNyETUg6b18P5Jv9RDtK2XX9ERTzrN
         XTviZgoFNGakSkRWQiV+1dJcXfXD2Kz3t1XGzEM0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200402192243.7186-1-pbonzini@redhat.com>
References: <20200402192243.7186-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200402192243.7186-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: 514ccc194971d0649e4e7ec8a9b3a6e33561d7bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c1b724ddb218f221612d4c649bc9c7819d8d7a6
Message-Id: <158586751768.2810.15790479518784305948.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Apr 2020 22:45:17 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  2 Apr 2020 15:22:43 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c1b724ddb218f221612d4c649bc9c7819d8d7a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
