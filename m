Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648B5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6332067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591223413;
	bh=qza1y5S5jCJj8fMOxen3UeHeSefmu5V/P0j1Rv4v+p4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=U/YPpIQC/LBgo7Ks8MXanIMD0pF1LSLfEE0UreVKOuoIfvVQ4TGIswh+s6E8uaOv7
	 bJBErp9vsJ7/xIulAXWLOy2JMomt8iuDpmfxgkW8sIBfsvivxn6EEUg1FYbPqkt3Zf
	 lPvZO/+oLHvB1wCP0m1fBTdzg0BKO9JMRpAEg2k0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgFCWaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 18:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgFCWaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 18:30:09 -0400
Subject: Re: [GIT PULL] First batch of KVM changes for Linux 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591223408;
        bh=qza1y5S5jCJj8fMOxen3UeHeSefmu5V/P0j1Rv4v+p4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=F5HMycCORm/Fr3U+s+ZXGVu6SIcC+H8MRcXxMvK0IBSVHQMuSBPBnUxpwJ8ZSS1hY
         qeBQUdEYv17Pl+zVOxr6xgIB7VM/zGyp1ceJ5Vg6xdHxYXxVNPVsddWisRAY7p8y4h
         x1m8Q9cHUXnVDvymw3hZ296JVtY1lP2mxl/I8CCk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200603173857.1345-1-pbonzini@redhat.com>
References: <20200603173857.1345-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200603173857.1345-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: 13ffbd8db1dd43d63d086517872a4e702a6bf309
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 039aeb9deb9291f3b19c375a8bc6fa7f768996cc
Message-Id: <159122340855.21404.14460273079755710845.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 22:30:08 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  3 Jun 2020 13:38:57 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/039aeb9deb9291f3b19c375a8bc6fa7f768996cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
