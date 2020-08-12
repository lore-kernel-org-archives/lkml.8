Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12801C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2B0A2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597262314;
	bh=VVhBVHav3ExhH8kIgaVB9k1YSbyTb0vgcsz3MLhaaM8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BlBLLd22gMssaBZIip+aVluD9gBE05atK/oSCEH3c6F+brKyZhsonGG0AnqweKhU1
	 qLNBGOTHGbe62+k4aZ/QyL90BiuOyTKtq60SxIjSyXnGGdyzz8yirKOXSjGOt8OrW7
	 N3AaGap4W6gqeO1M9+kGtWt0k5tXOHf692f6rqZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgHLT6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:58:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgHLT6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:58:32 -0400
Subject: Re: [GIT PULL] Second batch of KVM changes for Linux 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597262311;
        bh=VVhBVHav3ExhH8kIgaVB9k1YSbyTb0vgcsz3MLhaaM8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DuT5tFUXIzxYhLJ9b8IPVqJ3uielKNi+fUCSy5KMYQDHffRR5w5QZMkDC8lrq9ym+
         U9JJjsTrl4XKVnRkbzjLgQMMTeCEbfqMXBTaNQFk8l7GowjwLgY0kfSf9tXbrRtC7N
         /5wJmo2yVEdjV3XODFvPiUNZaVnDoBbrX04u2K8I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200812082938.18976-1-pbonzini@redhat.com>
References: <20200812082938.18976-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200812082938.18976-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: e792415c5d3e0eb52527cce228a72e4392f8cae2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8cd84b709647a015790a94bc809068b7a55cc05a
Message-Id: <159726231190.30367.5315438051063519093.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Aug 2020 19:58:31 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Aug 2020 04:29:38 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8cd84b709647a015790a94bc809068b7a55cc05a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
