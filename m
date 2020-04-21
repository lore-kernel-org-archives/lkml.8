Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE61C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5820C20724
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587501023;
	bh=engZtD2Byr5RNVmx4+QRjiZoeOI+oX+7T22guYnldLw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=M4pTtWRN2TIWCIu7Rf9ENX9s+rRt/vj41/Mp92XwZSWKxckjm3JEFbUCYHnpkAQGW
	 pa8jFY+C4TSgyG+RfUoG3l8sDP8vSi4Eg15zYREpwnRDXiwSCB5kWGn6J3tQkH7acM
	 CAkJgcFJxCqP7bZ+gGIad7IlNyLpSNn+7L9w6Lw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDUUaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:30:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgDUUaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:30:21 -0400
Subject: Re: [GIT PULL] KVM changes for Linux 5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587501020;
        bh=engZtD2Byr5RNVmx4+QRjiZoeOI+oX+7T22guYnldLw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SON04QHRx3IFEjqIFis5u/ZUdV+t/flRU32973qWUsnIWwlXQJaolyovWTM1Yhjj8
         WngXy/ybARAoHH/G4wSES/+cmQPXEPVlrt9UVhVgd5bIA24DLmFZqK/XZ9yjYRNCl7
         mhHFJ4wj+u0zParG3ZCIJ1W2MJevo6WbeEmkG1Ak=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200421160651.19274-1-pbonzini@redhat.com>
References: <20200421160651.19274-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200421160651.19274-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: 00a6a5ef39e7db3648b35c86361058854db84c83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8160a563cfff2a94e4ef20508961f1c9eead3b1f
Message-Id: <158750102085.18550.2785276584947429254.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Apr 2020 20:30:20 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 21 Apr 2020 12:06:51 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8160a563cfff2a94e4ef20508961f1c9eead3b1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
