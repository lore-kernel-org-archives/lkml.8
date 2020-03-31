Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732D0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD21208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585692914;
	bh=NtdLU3V9TUcGLarMoAmP0PMYd/Teo7aDfgP9KXpyr8E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ea9VeW2cmOod1I+1xNglm+OY5EJQKgPRuPztGIx+/z6oWPHRUF8Xys0x226T8wG7z
	 QcaaE3DmmX0AQ6hJ7X33/jIYw5rXlAOViO+DYzs8iLQRqMyKhhAwPfHlWDAFdL4y1a
	 jWKPbXQHFn4R7CquRVA9SgPO85B86vlGFEXbilmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbgCaWPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731259AbgCaWPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:15:12 -0400
Subject: Re: [GIT PULL] Audit patches for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585692912;
        bh=NtdLU3V9TUcGLarMoAmP0PMYd/Teo7aDfgP9KXpyr8E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VjJskU0MG31z9QRqJoU2imauG4gsG3YEGBaV0affUVPk0vlVDQxIx8ReKD3RcWDOB
         1gYCHJ+Yk+u2GnTWam8La+GkjCnOFyC769Kh9otFpeGWjvn5XK+/mosj/vnt/x6YsH
         EUe20ECjKRXSVer+ea2gJZkvhHh7HYZWUSzoe7Jk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhS2y33mA4jnLUx_39H59JS+7wdOHPw41ffiFJFM7zgAGA@mail.gmail.com>
References: <CAHC9VhS2y33mA4jnLUx_39H59JS+7wdOHPw41ffiFJFM7zgAGA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhS2y33mA4jnLUx_39H59JS+7wdOHPw41ffiFJFM7zgAGA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
 tags/audit-pr-20200330
X-PR-Tracked-Commit-Id: 1320a4052ea11eb2879eb7361da15a106a780972
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 674d85eb2d7dc6ef436f46f770f7ab3f1b9c6669
Message-Id: <158569291211.4579.7254041151873733677.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 22:15:12 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 17:53:45 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20200330

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/674d85eb2d7dc6ef436f46f770f7ab3f1b9c6669

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
