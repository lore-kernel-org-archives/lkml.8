Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7683CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 17:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C29206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 17:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598117542;
	bh=8K0jUsGXkC83DrDlS2QiLNPUAJsU7P/a/bjYxNJzG5s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rz/UtAIUFLA4GhTGjgyqPwULYko3D6C/6onO+0kMR/s3h7BFf4NFGxULYjRLsVKed
	 aGBLZ240PT8Avva9ntFJkf2GWk5s18n8gTAlPBe5Hvv0aH9B1eM+32phFbuqUmRvfQ
	 KKaJOAP388wgFOYgJ4CSHEQrki76XNCTw0Ewlv08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgHVRcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 13:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbgHVRcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 13:32:15 -0400
Subject: Re: [GIT PULL] KVM changes for Linux 5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598117535;
        bh=8K0jUsGXkC83DrDlS2QiLNPUAJsU7P/a/bjYxNJzG5s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Bvo4VNWyvgEs3kERSEWP8hhgzFAI26YvP5JJPOrnD3ioTMDf0zidTAHmVJA3AEuRt
         wB4CqH7Ew8iEGiycv5b9JxhXi9sIlK06SlUP9X9WpHBgry1kL/6UxfyBr7I07u6mXp
         +C5twnxR6ZuGSA1yhfYt22oSK2Xhhi71esliEE8A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200822080647.722819-1-pbonzini@redhat.com>
References: <20200822080647.722819-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200822080647.722819-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: b5331379bc62611d1026173a09c73573384201d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2d9e99622796576eb6faa236b2d1f592cc43ace
Message-Id: <159811753509.17427.9520000885402685829.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Aug 2020 17:32:15 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, maz@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 Aug 2020 10:06:47 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2d9e99622796576eb6faa236b2d1f592cc43ace

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
