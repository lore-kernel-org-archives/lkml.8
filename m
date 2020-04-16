Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82D2C38A29
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E26221F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587075326;
	bh=HOqPb2Qq8e5yW7Jlud99HTRS62wgavXqv2O8zf4R+io=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TI0YDYjCbI6N2GTyjI484ORzoXWirKOUfj1fdxmuv0/xDuMHzI4Q2ioYXEJdZsoL6
	 eDqCxC0gEmr9FWjE4VLd5Bndm+TZJQgpqNCnrPMjMsvsPZrb+Gh0QMjxOiko68r09z
	 tpOcVG+tQib81/cBX3elQDzXmcnOFu7Xy5TKMFT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgDPWPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729205AbgDPWPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:15:22 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587075322;
        bh=HOqPb2Qq8e5yW7Jlud99HTRS62wgavXqv2O8zf4R+io=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2d0Y6r1PfdUwFvnMNIwdttt5Ucro/FTLyg0R7OIheqwM4lfiSASrM8W6GX01ZURm9
         Xo9Umbh0Ku/DjHw2KEqTQXlfgmJECfF0He8rZFSq7AVVH49aUJBk/iwlwdZFM2CHCi
         s7m5eHkiZYSLTZPxAmnr5r76irxfpyKScGr+oVJk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200416.141936.727995804019732370.davem@davemloft.net>
References: <20200416.141936.727995804019732370.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200416.141936.727995804019732370.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: d518691cbd3be3dae218e05cca3f3fc9b2f1aa77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8372665b4b96d6a818b2693dd49236d5f9c8bc2
Message-Id: <158707532201.2733.5261507215167344130.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Apr 2020 22:15:22 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Apr 2020 14:19:36 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8372665b4b96d6a818b2693dd49236d5f9c8bc2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
