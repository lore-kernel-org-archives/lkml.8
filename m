Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB69C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D58420786
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597183152;
	bh=pduJdQOsaqltANr9l0iuMb/P8XQ2p94DV73pB5O3e3U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rilP0vpu+bSBRrqda4lZDEX9Vaw5YOdpNxy2dSeUt19e7+g6bxUi1ktWrSYN8ydiO
	 tt/jkJTBgpv1/wRLTOzVxoLU9S5hCyXBi2aX0L4czf6fo5i8TAdO/vZu1Qnvzw0jDf
	 QIMkfEdHQZDLnvHGYbvdV4DKyC9npNhm6ZpyPHVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgHKV7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgHKV7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:59:11 -0400
Subject: Re: [GIT PULL] virtio: features, fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597183150;
        bh=pduJdQOsaqltANr9l0iuMb/P8XQ2p94DV73pB5O3e3U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GthU30VIz6XaDDYj0LD8oG30goU0vf67f57r+Wl0jVapX3S60ZQ0lEtunpVsEZIdC
         2cUiR5/E6sy6zJbOlvN2b4ah+sxk3UAqCPKrGP/hv9VmRZ4J7DgP1XO6pCLDUdIeV+
         NrwmGYHf5kDH9jSY8ViGXW2i3EgZKJYynkcDyXuY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200811045613-mutt-send-email-mst@kernel.org>
References: <20200811045613-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200811045613-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: 8a7c3213db068135e816a6a517157de6443290d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57b077939287835b9396a1c3b40d35609cf2fcb8
Message-Id: <159718315071.19600.5549149981954786665.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Aug 2020 21:59:10 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.dewar@gmx.co.uk, andy.shevchenko@gmail.com, cohuck@redhat.com,
        colin.king@canonical.com, dan.carpenter@oracle.com,
        david@redhat.com, elic@nvidia.com, eli@mellanox.com,
        gustavoars@kernel.org, jasowang@redhat.com, leonro@mellanox.com,
        liao.pingfang@zte.com.cn, lingshan.zhu@intel.com, lkp@intel.com,
        lulu@redhat.com, maorg@mellanox.com, maxg@mellanox.com,
        meirl@mellanox.com, michaelgur@mellanox.com, mst@redhat.com,
        parav@mellanox.com, rong.a.chen@intel.com, saeedm@mellanox.com,
        stable@vger.kernel.org, tariqt@mellanox.com, vgoyal@redhat.com,
        wang.yi59@zte.com.cn, wenan.mao@linux.alibaba.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Aug 2020 04:56:13 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57b077939287835b9396a1c3b40d35609cf2fcb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
