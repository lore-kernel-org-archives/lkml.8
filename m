Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B32C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 18:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A66720759
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 18:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596393606;
	bh=54YlBizZZ30VuFxyUl35er1RAycHeS5nIBDep6dvfFg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=d/SD+mmV7y9XkTw2SXICw8l4RQreeDB9UmqfnrqGsJgv422yWc6XCKwyYcekTpAco
	 TL+88T0ch55FXLUn1Q4zqWflJFbDNfNpMXQ6jFNFE5GNE8uUtxPg99om6uPcAJqDzJ
	 g73X0errYGXImZpMk/FzkYon4N4egKO4sPA2Y2hU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgHBSkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 14:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgHBSkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 14:40:04 -0400
Subject: Re: [GIT PULL] Final KVM changes for Linux 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596393604;
        bh=54YlBizZZ30VuFxyUl35er1RAycHeS5nIBDep6dvfFg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=j66N0WS1DC5UKjTxGUXpeiCgd4qNenzmO4QYpnYj4f1WobmzyJkxGze1mimTLtddP
         GPQQssrIvU2Plflztorx9chBfqcleJrnxhx8x31qj70xqCo2X4CPIH6BLmsJBXthWy
         cJjx+G9gb/eG0YIz06li9akcqc9147Dmkz3Oc8dg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200802101211.8454-1-pbonzini@redhat.com>
References: <20200802101211.8454-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200802101211.8454-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: 830f01b089b12bbe93bd55f2d62837253012a30e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 628e04dfeb4f66635c0d22cf1ad0cf427406e129
Message-Id: <159639360413.23285.17190054151211035882.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Aug 2020 18:40:04 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  2 Aug 2020 06:12:11 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/628e04dfeb4f66635c0d22cf1ad0cf427406e129

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
