Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E312FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB342080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597262312;
	bh=zrDNdGq14UnSuTzhco0MBFbwucmtKZVl3d6A9iVqZwc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CrGIAea2YQkqU76AOIaDXbvFhuPPGfDsCJeUcroihglBmG4kt/uoWIpFgeMCmUuss
	 gv5jfT4TY/AcnmxIwSV8+aSpUzuFkkAkJLZFcJ1CbCCwANkEUQ2+In5mWjTJZIkv36
	 inz2I9eb4wZqbd6Fr0QbBoKAv82Zs39crayes3LM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHLT6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgHLT6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:58:30 -0400
Subject: Re: [GIT PULL] VFIO updates for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597262309;
        bh=zrDNdGq14UnSuTzhco0MBFbwucmtKZVl3d6A9iVqZwc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=C7D/FdE2qnlZZJVDgtv87+dliN/kCexv2zHF/qD67NAVO9MMlEeyPWAwND0iaaO59
         qM5R0iceJiIoeAg5uq8e5Qand6l102QVXylBzjibxa4N257yPX3TLN1BIurCvjAWHu
         GnEf7edtXkLHka68tycZgdjSJX3EM1H/kTJK7mYk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200811203147.1ad96351@x1.home>
References: <20200811203147.1ad96351@x1.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200811203147.1ad96351@x1.home>
X-PR-Tracked-Remote: git://github.com/awilliam/linux-vfio.git tags/vfio-v5.9-rc1
X-PR-Tracked-Commit-Id: ccd59dce1a21f473518bf273bdf5b182bab955b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 407bc8d81837197ef02c7296f8068d3bf2c96f53
Message-Id: <159726230993.30367.12804520856299605186.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Aug 2020 19:58:29 +0000
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Aug 2020 20:31:47 -0600:

> git://github.com/awilliam/linux-vfio.git tags/vfio-v5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/407bc8d81837197ef02c7296f8068d3bf2c96f53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
