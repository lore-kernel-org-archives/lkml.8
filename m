Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BADC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6AF20866
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583528115;
	bh=oArAAZa/9ojyftkYg3guTCBnbYyIN2n6dYOF6OupPBg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oSLwv9IHvclDX9o2fHr5virntqPL+oJONkzegxTf4HvChQwia4Ci9QgkDi8y4lgr2
	 K8zpGlgYX65N3vC6eNrT1oOIXDkdTC25Litj8yYjwG8EjPXGxKl3sJovDZ6lfKG5lY
	 H/rnDuktxau+j3sX1M4nOuJTJyVMUYWKAqvWk6tk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgCFUzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 15:55:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgCFUzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:55:09 -0500
Subject: Re: [GIT PULL] spi fixes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583528109;
        bh=oArAAZa/9ojyftkYg3guTCBnbYyIN2n6dYOF6OupPBg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LOOQO8StcPboBIbdFoMhgBQR5hA9287CIbJYI5aJ4KRnR2OlxuvdOjzfniawbej+L
         GQbYrnnTbVRpB26emDDCCzuSGbulPllRZx186DAOTfxBZxEnD0G/r5VRU3/WW5Q4ib
         ZvRzARtsxtnqqdGeqzA6n0/PulKRls4TDdZej5eA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200306174101.GE4114@sirena.org.uk>
References: <20200306174101.GE4114@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200306174101.GE4114@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
 tags/spi-fix-v5.6-rc4
X-PR-Tracked-Commit-Id: f9981d4f50b475d7dbb70f3022b87a3c8bba9fd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae24a21bbd96a7a4a3e82890285255d7e86540f0
Message-Id: <158352810930.1815.5403175202221783247.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Mar 2020 20:55:09 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Mar 2020 17:41:01 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae24a21bbd96a7a4a3e82890285255d7e86540f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
