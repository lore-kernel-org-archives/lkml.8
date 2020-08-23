Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C025C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 18:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D150E20706
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 18:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598207979;
	bh=hIKoVmpC88VP1ZThEbWeQVRYJkQKluOV7vCcJ3XkcvI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YPpqQ6H3miTz/UJBkQUB2NHY79QQLiCoh/3bqQFFz3/cwTcl05txpkRlG2UiVESRZ
	 92jirlgvLhpe08OblI5BfhQ4/TEKSjp2d5rcl8vZGfc8hvqmebh7b+++SGoEmweM4L
	 E0ZO6pKAEyS+bsGbgYEHkp7wI1wNMMDgR+Cqv5bA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHWSjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 14:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgHWSjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 14:39:25 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.9-3 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598207964;
        bh=hIKoVmpC88VP1ZThEbWeQVRYJkQKluOV7vCcJ3XkcvI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J16Vx4irGTsvEoj+6w5Krxn8bXfPOXR8rzPSggBAewZUx7aTVygXGxnaRSkMD9D+C
         Xl8zz3va8W1QUwsEzhNmfYvaKAPf9plTbairHqH0o2bLK9rnDkr68CGwWKZjiYqTe+
         RJlvh2YZ/fW46lOXC98MeUYDRM+SmT2EkQcYnfuQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87v9h9h6gq.fsf@mpe.ellerman.id.au>
References: <87v9h9h6gq.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87v9h9h6gq.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.9-3
X-PR-Tracked-Commit-Id: 64ef8f2c4791940d7f3945507b6a45c20d959260
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb95712138ec5e480db5160b41172bbc6f6494cc
Message-Id: <159820796470.12134.6083209572149218193.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Aug 2020 18:39:24 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com, anju@linux.vnet.ibm.com,
        atrajeev@linux.vnet.ibm.com, christophe.leroy@csgroup.eu,
        fbarrat@linux.ibm.com, hegdevasant@linux.vnet.ibm.com,
        kjain@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mdroth@linux.vnet.ibm.com, mikey@neuling.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Aug 2020 22:50:13 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.9-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb95712138ec5e480db5160b41172bbc6f6494cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
