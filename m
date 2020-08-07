Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C4DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE182224D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596832797;
	bh=Hk4+PfIxR2EQZpW4JSb1J4BNdkn5+Ty9FtAWhAM/JGQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Iwzutuc5SN34cgYSKG7fcBIWHvCxYjg40AhYVxCtjDeQQ/OU8u6ODYvpIaEBXsqnj
	 2bAUc1lixxwmmLjJY3bKH0dNY8QSA4diR4yDnn+NXsBECtWT3RzfkpVBZkj/nsGdsS
	 5rDzMcgAguTmSX81yLnJ77LH80N0uO2pyhDWsdL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgHGUj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:39:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgHGUjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:39:55 -0400
Subject: Re: [GIT PULL] Mailbox changes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596832795;
        bh=Hk4+PfIxR2EQZpW4JSb1J4BNdkn5+Ty9FtAWhAM/JGQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=F5VMiL5mjTh06sd0xq0K+QoF0w8zQ09qtacWchRX3KFTxpYFvHkjmQPJeQFMXqdab
         lIV3030s6gW4dAa1NXMnIsOIYHHjLNtEsxsdA+ZkO+9UV8GhXMyP+/0OY+peAaptRv
         429GT1/xu4sMSBuw7EDd+azQfmMxopXNkcMpbtGM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY0bZ8cdRa+vWYzE4zbujgQfKK=NzZs7G4o0QkxJXscEGQ@mail.gmail.com>
References: <CABb+yY0bZ8cdRa+vWYzE4zbujgQfKK=NzZs7G4o0QkxJXscEGQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <CABb+yY0bZ8cdRa+vWYzE4zbujgQfKK=NzZs7G4o0QkxJXscEGQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.9
X-PR-Tracked-Commit-Id: 884996986347dbe3b735cfa9bc041dd98a533796
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75dee3b6de4ce31464ffb827b81ddb5414599159
Message-Id: <159683279523.2860.1761338992300041236.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 20:39:55 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Aug 2020 01:30:04 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75dee3b6de4ce31464ffb827b81ddb5414599159

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
