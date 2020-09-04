Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28317C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8B9D2067C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599185368;
	bh=0SQTrPqaETtsx26pY6baic68APqmXzTLQK62VPbIZC8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qJsuD9CHdpSLI3gLUKG3LWb4yhEMVj9BWYsYXps0OR7xdiZbA4mWXlFOnZRo7tajj
	 ftr4H+NGmzyeqwJHbVvPzkilAb0E8Z+ppsZIEWdwi3XPpdqbHhpPiMTvmPpWRzGWPV
	 +rcNTFz7Ntmaz0UapGui8itDwRlOY8vHHyXBnfJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgIDCJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 22:09:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728484AbgIDCJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 22:09:27 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599185366;
        bh=0SQTrPqaETtsx26pY6baic68APqmXzTLQK62VPbIZC8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hgd5nRKYQ2q6N+3DlSxfuEZ033PjE5QE1K5YqmJ/ScN++DTVtKbdvb14JM22ReFMW
         iTQdrnlSSvQOwFMZU+XMCnoziT8FMbJzNrkujFGl+cEXdrKsLirsDw17kcdlhsIvsd
         gkktNvoy9tC1Fgp0IT2Kh4SnTM+aflBpfn/Btp5E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200903.170319.1154686215820482016.davem@davemloft.net>
References: <20200903.170319.1154686215820482016.davem@davemloft.net>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200903.170319.1154686215820482016.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master
X-PR-Tracked-Commit-Id: b61ac5bb420adce0c9b79c6b9e1c854af083e33f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e8d3bdc2a757cc6be5470297947799a7df445cc
Message-Id: <159918536675.12725.8036407456847792468.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Sep 2020 02:09:26 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 03 Sep 2020 17:03:19 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e8d3bdc2a757cc6be5470297947799a7df445cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
