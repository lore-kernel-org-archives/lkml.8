Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D52C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8F024953
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588872906;
	bh=ASNy/2e1zfLpRcSs4NhltLEnFps/ycNPUpbuPsuzhbA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0TBYOlwUkbTXNFJQN03E6nOVnj31+riuGm89g2XmuruzYWd7561U/Q01r/mSbRfDH
	 rI9DiAlrcQBsHwLg3dobQSrwyAd5AOkaZlAgKYE0rknn3FvqgvRX7k7+OdYZion47+
	 +cpQmbhpszeQ7vywwji/mDLIFc423VlMmZePXYEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgEGRfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgEGRfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:35:05 -0400
Subject: Re: [GIT PULL] KVM changes for Linux 5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588872905;
        bh=ASNy/2e1zfLpRcSs4NhltLEnFps/ycNPUpbuPsuzhbA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rUxP5+sES0IjTkkdI9Ou6Y0gCh5I1jx50D2LYCD6D4UtnqlMeEIkLYcuWtgSoGG7R
         4YxxEaVvB103ushyOzBniANJw0skI4vPYWqWuGgMnQY34bMCGJlv6C/qvXZ4pxvHN7
         6kYDZBdpvriYnCn3mIqg9Lj4Ginhl0Nxf2jNiM9M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200507115332.495930-1-pbonzini@redhat.com>
References: <20200507115332.495930-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200507115332.495930-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: 2673cb6849722a4ffd74c27a9200a9ec43f64be3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c16ec94dc767a4d8c48149d646e8c835512cf8f
Message-Id: <158887290507.22656.14504039152108528383.pr-tracker-bot@kernel.org>
Date:   Thu, 07 May 2020 17:35:05 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  7 May 2020 07:53:32 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c16ec94dc767a4d8c48149d646e8c835512cf8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
