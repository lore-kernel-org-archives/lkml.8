Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36938C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC6B205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589573720;
	bh=tmkkfb5RlgiolGotuwMjHh51nDR1N6E8SzFTI3GSFeQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QcCaILUGQKpQKcZiYAQQtzQ5Icf4ZF9hSCeGRUpjw1SM33fDA+w5mM3uX29w0RO6c
	 MuoY4AII+c4w0LP/SSvC71ckoX2pW+OC558VYhtxbb1QN0qQTMgQ6rIcrS2JGPkdbF
	 LsEAzCfl8pIpoAiTKiTFqGw2VF5Kp0/TqjeOIR2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgEOUPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 16:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgEOUPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:15:04 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589573704;
        bh=tmkkfb5RlgiolGotuwMjHh51nDR1N6E8SzFTI3GSFeQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tXOSpJjkfNs2y1D1BhBs2SndCSbVK63wjYNsrqUoCLDIwqmsbpicJhaqiVFxwHIYY
         eswxt2uT5ke2kbecUTPr3wl7lsNW1Eppm5TkqUCT7+wF+jbVy8aHggiaOaqpNXMVMH
         7op84PIaivZylRCDAd608OEaBK3eIs7vb6iGh9e8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200515191354.GA17053@ziepe.ca>
References: <20200515191354.GA17053@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200515191354.GA17053@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: ccfdbaa5cf4601b9b71601893029dcc9245c002b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5dfe4f1b44ed532653c2335267ad9599c8a698e
Message-Id: <158957370400.26450.6291646987244577141.pr-tracker-bot@kernel.org>
Date:   Fri, 15 May 2020 20:15:04 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 May 2020 16:13:54 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5dfe4f1b44ed532653c2335267ad9599c8a698e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
