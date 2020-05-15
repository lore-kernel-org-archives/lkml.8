Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49057C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18DFF20787
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589573709;
	bh=psEOaF8nRViEXr3vqL2+yxlMTvVEzrbSOKsUZE/DMNw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0GBAHgg5ZNXJi3+bY4+msYkf0qZ+VAhelPgCBqFVUqZP76EFuT/MIsIFU+b58QmTY
	 +NtZt2+7ivuWWbuHOtUhIktYcL0bQ29eqJjOMgGz0EgqHkwTGYjq2PViJTZrUq5rgq
	 +gY21fvUmlOtASBv+4mB7t+PrCg/S9gdjWsS6/9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgEOUPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 16:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgEOUPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:15:04 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589573704;
        bh=psEOaF8nRViEXr3vqL2+yxlMTvVEzrbSOKsUZE/DMNw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iq9npIQjBDSw9Hcd3pdtkZ8oMIXBHhiNfB8/k/P2O7w9sM+W9btAozSq2e986D9UK
         CWPLx2TYLrkjQgSC/zjjDZuCpfQPUWOcehMIERX/FgsGpXMKCOkiR3a9xnVz5juiTZ
         oqCOlnyHrWMIIUHacmMFtK/hKb0gra413qAxirdA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200515.123900.727024514724458944.davem@davemloft.net>
References: <20200515.123900.727024514724458944.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200515.123900.727024514724458944.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
 refs/heads/master
X-PR-Tracked-Commit-Id: 8e1381049ed5d213e7a1a7f95bbff83af8c59234
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f85c1598ddfe83f61d0656bd1d2025fa3b148b99
Message-Id: <158957370419.26450.7540009470931421936.pr-tracker-bot@kernel.org>
Date:   Fri, 15 May 2020 20:15:04 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 May 2020 12:39:00 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f85c1598ddfe83f61d0656bd1d2025fa3b148b99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
