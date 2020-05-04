Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A290FC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF4C206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588617512;
	bh=y7Pu1FubvJ8XEaBkpZaNRpWFQQvvFrFooiqYxgdFwlI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Wq9Pl1JApYDQ0vXLr6K3CIFBdcs2PbZRgOMDPIRX//XHs0wpRN6YcwEjVrWtXJRlP
	 7T4Wn3jb1xOiPTUrPFISoDMm3EH/Fp5SzVPkaPahzk8EhDpBabp1mxlsN2FoKr2GBB
	 2Cw9EFn/OKj0CXVL40SASCyDF3wanT1NYnxUMLr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgEDSib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:38:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgEDSi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:38:29 -0400
Subject: Re: [GIT PULL] vhost: fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588617305;
        bh=y7Pu1FubvJ8XEaBkpZaNRpWFQQvvFrFooiqYxgdFwlI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o0+z+lEgyX0XO0M7qlk60y8gvXxm+B6YVhwMNbOooUgwauzhVMCt/iHrM/8Us84/I
         NQq+6lH48j3BGusVJfeNnvuYfBB5Hh356hYbLBSr3dG7hdxtouET22MjN64Tcun/cw
         79y9gGmTovRi2prymYxytR1uEJmUKeN4JuEGaWJ4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200504081540-mutt-send-email-mst@kernel.org>
References: <20200504081540-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200504081540-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 0b841030625cde5f784dd62aec72d6a766faae70
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a16a47e98a30ae6a424d30ce9f4f99e4d9384713
Message-Id: <158861730512.3296.10840791650276451054.pr-tracker-bot@kernel.org>
Date:   Mon, 04 May 2020 18:35:05 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        justin.he@arm.com, ldigby@redhat.com, mst@redhat.com, n.b@live.com,
        stefanha@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 May 2020 08:15:40 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a16a47e98a30ae6a424d30ce9f4f99e4d9384713

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
