Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE899C433F1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BACB207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594400131;
	bh=nowGvXNA3DjOHHb09qf1pz/Mu96aKprdOOoau4Dv8+s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qOZk65/gPrG2DHZIwLWhAp6BOtu8f5BiS6cgBSwrLnfzm7dMYYP8a+g2A7cYhFHpJ
	 7LOFo+xZsZnIFR+eisf7PuyIoiXsOTz14xNK5BKwDKW3T7KU9s8apC5tlMCH/TtQSY
	 +tnDA4qHHex8xSR58IALEoXYbZ4Yn5qmx6r9gCFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgGJQzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbgGJQzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:55:05 -0400
Subject: Re: [GIT PULL] Second batch of KVM changes for Linux 5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594400105;
        bh=nowGvXNA3DjOHHb09qf1pz/Mu96aKprdOOoau4Dv8+s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vO0Xbk//ewD00d19ni9JxxE8bHR4GVydUooXgt96D5k3FPMv8Jf0N/KcXtdB8DkAZ
         WJDEugHPvH/HT6bzQonv8xXIVoFv6hzwx6N8L6T7l9W1DV4K70pOxj2uah0iVQrYSF
         /ke3cgxamgtLrjUSYwofVWPzKRH0hEcViIXsppyw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200710130659.10507-1-pbonzini@redhat.com>
References: <20200710130659.10507-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200710130659.10507-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: 3d9fdc252b52023260de1d12399cb3157ed28c07
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb24c61b53c3f47d4ba596fe37076202f7189676
Message-Id: <159440010506.18761.14423608163514612269.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jul 2020 16:55:05 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jul 2020 09:06:59 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb24c61b53c3f47d4ba596fe37076202f7189676

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
