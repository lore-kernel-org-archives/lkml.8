Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5318C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F380206D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583528403;
	bh=DQxCSRBY0YnfvZFBLyVMkqDoLgd1HJCY15OWxm+cCUo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nA4NpRIdrCWmPSv20ommDzBu5Gcg3RuY5as6vuoOa5QuojXeR2ufhgSerQkvteczK
	 p92SaNdE5Zc+37CvjjNINSBw3YAMGAJeHaTTcE6dFclxwu/ILpy4+RA5nWmqtky2lb
	 YSyPkY4n5f9hyF/9RcnS5WdtKEcS2FY+avE7Ktdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCFVAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 16:00:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:48494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgCFVAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 16:00:02 -0500
Subject: Re: [GIT PULL] file locking changes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583528401;
        bh=DQxCSRBY0YnfvZFBLyVMkqDoLgd1HJCY15OWxm+cCUo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MoWrhNmnVOioCuK5NzjoX9rpLZ0KuKzr5mhm7QAYWFfn84gcGknuD6WOidjkVs5pH
         5GC83ZMs7VAcMoTiWKqg81deKed+D7xZN0v91Kuj8Eq6Ub4GOe3M148tXA6mrVXZSS
         3NWcDAh/Ah2iE6IzCggI7n3hmjI17bgrzJ6WxTgg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a14229cc7aabebfdffd405018d939d7a0ae1f1cd.camel@kernel.org>
References: <a14229cc7aabebfdffd405018d939d7a0ae1f1cd.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a14229cc7aabebfdffd405018d939d7a0ae1f1cd.camel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
 tags/filelock-v5.6-1
X-PR-Tracked-Commit-Id: 6d390e4b5d48ec03bb87e63cf0a2bff5f4e116da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b25d458035d0ca6502e678874e2ccb2fa2ddc23
Message-Id: <158352840153.8472.9432123978920324502.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Mar 2020 21:00:01 +0000
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 06 Mar 2020 12:18:15 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/filelock-v5.6-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b25d458035d0ca6502e678874e2ccb2fa2ddc23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
