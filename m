Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D8BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CAC420578
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598296927;
	bh=HQYIhDEJFQHKLSfJOitcmoFKB9nF0wPzPT9kJIALLnU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aIOPskVyQgNVSJkuS4hdEWTwhznOJ4Y3D20cOYNsL58pCx9OBPiQQumxEiTXowRVc
	 33vlERI2CaKLqADw/euZkEmq7rHqkImj8hvPUV3QKM/mdkhC6LHyMFzys8tw1o7Zur
	 d5jwDrpWPGY5kMVxfl1cVctC/7oVf+IbLIDzpBj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgHXTWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgHXTV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:21:59 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598296919;
        bh=HQYIhDEJFQHKLSfJOitcmoFKB9nF0wPzPT9kJIALLnU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bmy4pv8VwKj5DcdfYhQ52d2i0UoNjpWDXsDLqmYbAi7Z2W3f4yi6hjTywnIHDjFJH
         iq6Fbds+85Yk6NX43WjYL427y9EKFYlueQGhwPOcUjlal5x/7rZHPc9EoynJj0J6rg
         jOWz/hJbVPWned7sy1MDrK81u3oJOrcS/lY6+UgY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1598283719.git.dsterba@suse.com>
References: <cover.1598283719.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1598283719.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-rc2-tag
X-PR-Tracked-Commit-Id: a84d5d429f9eb56f81b388609841ed993f0ddfca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9907ab371426da8b3cffa6cc3e4ae54829559207
Message-Id: <159829691929.31349.7697841057318029219.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Aug 2020 19:21:59 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Aug 2020 18:43:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.9-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9907ab371426da8b3cffa6cc3e4ae54829559207

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
