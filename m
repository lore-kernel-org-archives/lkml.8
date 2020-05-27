Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D822C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E132075A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590603004;
	bh=QUqohlm8KN3umlLeteXMo3gWgS+dxh6N8qhOeJ/COQA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BfQ9mbmmXIdtggUMsIpPhtQitpM5+OOpV3Tw0um6T109IdAUCNk4891JeClPzmQlj
	 il96J2h6UaJs2KkX7IQOfZ0JBWmwijveJGSX4AksatcQnx3xv9a2KG4QdGm4kAWefJ
	 /OJWjmxEk9lnv2hOCGBpr2avAeLNOWcedlqQg9cM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391913AbgE0SKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388404AbgE0SKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:10:03 -0400
Subject: Re: [GIT PULL] Please pull exec fix for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590603002;
        bh=QUqohlm8KN3umlLeteXMo3gWgS+dxh6N8qhOeJ/COQA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gIsUgybUjVU/Rr7S9YRl3Yjdw9Z8Cb57g4ka70ZiyTtINosx/DGd6kugGMtVqfbAT
         qP2B6Oyee1i3x+Na5W3eMZG6y13FI95yJagZHLB8CflDBgCAxuFRvSeGeFae6TM8NQ
         L4wpBBzMgp21SS7oiA+Vv2tc9wqDrOKNt0S2+kXg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <871rn6a6e5.fsf@x220.int.ebiederm.org>
References: <871rn6a6e5.fsf@x220.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <871rn6a6e5.fsf@x220.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 exec-linus
X-PR-Tracked-Commit-Id: a4ae32c71fe90794127b32d26d7ad795813b502e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 006f38a1c3dcbe237a75e725fe457bd59cb489c4
Message-Id: <159060300272.13466.15556895013101860046.pr-tracker-bot@kernel.org>
Date:   Wed, 27 May 2020 18:10:02 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 May 2020 13:38:26 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/006f38a1c3dcbe237a75e725fe457bd59cb489c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
