Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FB6C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF0E20730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586289338;
	bh=h+jpQsLavRAbKi+4OpsN0OoieN218w7zKdWTyRmNNYU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ixfaD+sW7XNj1W8wAXkV/C0R1dwICjGjWHSs6EcIc+6S1Sdt+po80nAd6d4l0NFEp
	 bie2YvZBZNOTlbqoa9TVXjJAAYUyDX5UrFMMjoyxxeIjeJ3B3DyM2m5BgbylYEpRTF
	 dLodRZbfRhMuZobtHkZQ4LcGWnAQWs8H1upe9czE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgDGTzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:55:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbgDGTz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:55:27 -0400
Subject: Re: [GIT PULL] UML changes for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586289327;
        bh=h+jpQsLavRAbKi+4OpsN0OoieN218w7zKdWTyRmNNYU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Gb6bOspnHM/6P/mWENtFkhTrC/NSeWQ+Qs1EoMvxF+1xcJDFt4nMu8YhrXgE9nQSu
         yIDvFKwk2FlsnLbcjwlokhSjpniRSvd7WoABuI7hTt6BqYixLLToMx8U4QHRN5Av5I
         3LZY1wq2RGsP4oL2CGvcikqymLLt0oCMKhedQyfw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1397520880.91813.1586263074756.JavaMail.zimbra@nod.at>
References: <1397520880.91813.1586263074756.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1397520880.91813.1586263074756.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
 tags/for-linus-5.7-rc1
X-PR-Tracked-Commit-Id: 4a7c46247f9c620c0390a15cb00b6ef9576b9c23
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 762a9f2f0144246872d61bce60085f62992f4ca0
Message-Id: <158628932697.3792.16683492193078654566.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Apr 2020 19:55:26 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Apr 2020 14:37:54 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/762a9f2f0144246872d61bce60085f62992f4ca0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
