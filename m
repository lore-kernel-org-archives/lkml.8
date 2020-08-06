Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C18C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C66E23119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596734430;
	bh=hOyepeo7ajq/qV478J77IxRau+eLPtke6CM4dH7d9QQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=drNHFwchSM47tGFHdpFBD6nA7hQ178Wf4UgNAOemsyPC8hccOtJGh7Cr9wO/BzVIX
	 Kn99TlbHq1s12c52GeFSxo1QEU8uYni+ScJlJsUpBCOA2gGBWxDB0hD2YXJt+Mwzk5
	 c/RxwFe13NaZWCrnOhzBEVlj8n9g4U5+wkR4D3DY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgHFRU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:20:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730166AbgHFRUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:20:01 -0400
Subject: Re: [PULL 00/10] xtensa updates for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596734400;
        bh=hOyepeo7ajq/qV478J77IxRau+eLPtke6CM4dH7d9QQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IDs0/Nx2BP9hlcVcumDkv1NzdU1z+Vl349KRMn81uU+kMQwP1fwInKZrOjJLu/znk
         9Hx+bvg2Ovlvo6HggxjPyVE2pNuxrJEZDsDGvO5EaeW718PEBUwodQh5tyj/zCvMLq
         kbCjXelvr86lfUdXebo0DyWy5nJ/q4roVDO/AFZE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200805161713.7476-1-jcmvbkbc@gmail.com>
References: <20200805161713.7476-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200805161713.7476-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20200805
X-PR-Tracked-Commit-Id: a0fc1436f1f4f84e93144480bf30e0c958d135b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbcf9cd1576752ebe8d618ad8c6500b7e262ffac
Message-Id: <159673439969.17279.12066367649345071605.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Aug 2020 17:19:59 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  5 Aug 2020 09:17:13 -0700:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20200805

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbcf9cd1576752ebe8d618ad8c6500b7e262ffac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
