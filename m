Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377A8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 22:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080422078C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 22:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585953325;
	bh=v+le28gRLVWY6lPssJBpFW6VcLI4Pu4cjJLU3vSr/uc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fuDDVbkP6Kak4ffOQFqukTs/ObHji1S4dFfuXUreyDXEdyrcAbqCuwIvocQfR4vhq
	 dAWTeO1C1kGE5Y5czwYA/xjH3dZ2CHijzGEdccVFEJd2RdyqDSuWHBesNrTwd6PV5q
	 dyvUzQEpuI2UM0BHZn+XObZuXoBNUOsyPXNOwrtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbgDCWfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 18:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388507AbgDCWfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 18:35:23 -0400
Subject: Re: [GIT PULL] ARC updates for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585953323;
        bh=v+le28gRLVWY6lPssJBpFW6VcLI4Pu4cjJLU3vSr/uc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Qg85EO8Dx75TjEQpKPOyh/IU7UFa+jV2BPwlfBuhtl3Pz1wvzWN236MRiZU6vKqeu
         Fx8ZUjmIgmFEV+83ikwuf28nTq/IhEf21vI43EWf7K4IfpgZ0ebG4tdCT907Z9b0Le
         8/jh7lIPg68eDQCvNG2YZXKz/rwNWiz5i4lqMsaI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5b7afdcd-48dc-dc90-d7c0-53559a3ca3b8@synopsys.com>
References: <5b7afdcd-48dc-dc90-d7c0-53559a3ca3b8@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5b7afdcd-48dc-dc90-d7c0-53559a3ca3b8@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/
 tags/arc-5.7-rc1
X-PR-Tracked-Commit-Id: f09d3174f002ee2cf15623d5a0f68f7393536ce7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5364abc57993b3bf60c41923cb98a8f1a594e749
Message-Id: <158595332318.22488.8622901512202674698.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Apr 2020 22:35:23 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Apr 2020 21:57:33 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5364abc57993b3bf60c41923cb98a8f1a594e749

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
