Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4A5C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D46222C2
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580750417;
	bh=rMK1EB724GJHlKb/vqFEgz1ZizJiacEp0xYAjBmY6PU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tF9lf5t08DLGuTpesfYhcz//+Dckhcb/tI9T+JgAPZqWa7cvBJwPXXt0HR3xIVxD8
	 Y13bfrqam+Fk872ALwcMuJlNjblhknpO0W5ytH4ZocnHIUC8eVrdq5vpf7fSvZdHxI
	 BsyTIaGNOsUq/X4JK7gLiDQD9SvoToh50aNJU4UI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgBCRUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:20:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbgBCRUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:20:14 -0500
Subject: Re: [GIT PULL] kgdb changes v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580750414;
        bh=rMK1EB724GJHlKb/vqFEgz1ZizJiacEp0xYAjBmY6PU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mZ+pKtcdwz+pdb72EfCYbWtF1twflhjKLZ2MFpublqwxXTSz1JnBap5ZnRfsytsi6
         FsYsgGNCCghejnS6yOHneEEhr/JpABjiB0UxodBmaqrZVsmLspQwI0uX1u11ouLH4i
         Dd2/iWIE1Incg6n/MeQaQZK6qVjR6q0q7rJz/bHo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200203150029.ogdtk5ep7fd3m3hg@holly.lan>
References: <20200203150029.ogdtk5ep7fd3m3hg@holly.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200203150029.ogdtk5ep7fd3m3hg@holly.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/
 tags/kgdb-5.6-rc1
X-PR-Tracked-Commit-Id: dc2c733e65848b1df8d55c83eea79fc4a868c800
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e17ac02b18c61f0d5f85c6ec9e49f3ff00b2b3cd
Message-Id: <158075041434.16129.5649006968327740051.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Feb 2020 17:20:14 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Colin Ian King <colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Feb 2020 15:00:29 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e17ac02b18c61f0d5f85c6ec9e49f3ff00b2b3cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
