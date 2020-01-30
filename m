Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FDFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD76E22522
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580428219;
	bh=q9mn1FfMiKVKZPXSs9GnfDX4utx5V83YBgWvfVNNg9Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mX5cMelt0bhEHCW2Bf6y6tIyavMaV6tVTm63dkl9IqNgVw6cXY2GDjnAZ3P08jYRu
	 pWtrNbxF6nfXjR04GoRqAkuNK76MHtHRFolPqHOkmwfm8Daywtn61ZDoRx/htFMkvf
	 unruRMxWRyq4BSVJoLCiiqzXkJb3gmDeA2ZhmSGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgA3XuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:50:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbgA3XuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 18:50:17 -0500
Subject: Re: [GIT PULL] ext4 changes for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580428216;
        bh=q9mn1FfMiKVKZPXSs9GnfDX4utx5V83YBgWvfVNNg9Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ABXFMiwwgpBEjY8xx5OM4hzzbs4qbXIUzu+7FNz0l+4LJ7rzRkt6l7rZNtikxvHH/
         EWLbUjDXe9xbDiQZG16GBEuhTSbUSrYOT7K+NSE9wY2ieejnQKmKVeOrODLTCtDRAj
         P7RWl15bJGqvJr9bFz74+z+iQpbErvU8YslAVLA8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200130005817.GA331314@mit.edu>
References: <20200130005817.GA331314@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200130005817.GA331314@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 tags/ext4_for_linus
X-PR-Tracked-Commit-Id: 7f6225e446cc8dfa4c3c7959a4de3dd03ec277bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5da4c933c50d98d7990a7c1ca0bbf8946e80c4a
Message-Id: <158042821678.30792.14650350060155285879.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 23:50:16 +0000
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 19:58:17 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5da4c933c50d98d7990a7c1ca0bbf8946e80c4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
