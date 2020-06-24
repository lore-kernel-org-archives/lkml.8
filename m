Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4ECC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C634206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593019822;
	bh=oxPIjg4Y7WtOZI+S9vhkTY+465B5ALE8m4DMhounppY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HYuxmNXWC8Pg9dXV4Dcv7Rc0Bq59sHyTjp6hvqpNOEVpwWsuzaS2/7lbBbnWMVFn4
	 EJMzjqICz0TxasoO539SsybVdYlbN5Baznn4dOWCpOsdVhh0HeudOjYS+vYMiaajg7
	 y2ARXVlvZZj60qi91Ta8PkpRQbDalS71h4gHEn6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405567AbgFXRaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405427AbgFXRaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:30:18 -0400
Subject: Re: [GIT PULL] KVM fixes for Linux 5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593019818;
        bh=oxPIjg4Y7WtOZI+S9vhkTY+465B5ALE8m4DMhounppY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ySQXhDLqBjhg+F8lAocq3TViw/g7mrEkkHRRyl1ZFze65Df7fZSWpfRU+UpGXl3xP
         AtSsK15e2AzHgYtBo+fB+ZAWjMW47nygKSPDoAMC1jpWguQwXUlnGhXuWvly4ZoJiG
         nwj8VieFuXzhWhHIl2KQIia1vQ3dBm9ESRPw3JGo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200623171117.326222-1-pbonzini@redhat.com>
References: <20200623171117.326222-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200623171117.326222-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: e4553b4976d1178c13da295cb5c7b21f55baf8f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26e122e97a3d0390ebec389347f64f3730fdf48f
Message-Id: <159301981836.18191.11209681669909428701.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Jun 2020 17:30:18 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 23 Jun 2020 13:11:17 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26e122e97a3d0390ebec389347f64f3730fdf48f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
