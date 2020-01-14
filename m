Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4046C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8403D2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579026303;
	bh=GhelCozmoOvzdAm+79QDaXuEsB22I9mgI/ivW7JwT+s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vjIKP4Gd2QVMNrQUY6LUyA7yg8q236WnYgjLO1w98Udh15+9KUEAupL5kKExNoBEc
	 8N5tW1+QoEYLsjXXd8sQknRjhaHL0U3oelGQJtSSIhGFWCLcNIKLPpHhsDzuwVBvPP
	 hXXwoX5jjEejgehY37MkH1Czinu/4bqYXpxje8h0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgANSZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:25:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANSZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:25:02 -0500
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579026301;
        bh=GhelCozmoOvzdAm+79QDaXuEsB22I9mgI/ivW7JwT+s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jNTUIa1V/qTH6rgwG0XJGA50NZFkkIQX1LrWqdXc4HOK39MR2h5u0KA8dLFR5xc6h
         i4zZiTVSRagXMNlFw7mdlc+3zg7Wt92CyRAjgwe/yEfGzuVEYKHDJfkViH7yhUnZnC
         KZfEHqEwSVhzdI/B0zRsdGcwarX5UCr6wV7QiM/w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200114181912.GA30159@ls3530.fritz.box>
References: <20200114181912.GA30159@ls3530.fritz.box>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200114181912.GA30159@ls3530.fritz.box>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.5-3
X-PR-Tracked-Commit-Id: 8b7f938e0a03776124781f19fb22443dfb519cff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 452424cdcbcaf6a2ebaae4301da5a4e1850a941a
Message-Id: <157902630173.24051.6409474907657354162.pr-tracker-bot@kernel.org>
Date:   Tue, 14 Jan 2020 18:25:01 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 14 Jan 2020 19:19:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.5-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/452424cdcbcaf6a2ebaae4301da5a4e1850a941a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
