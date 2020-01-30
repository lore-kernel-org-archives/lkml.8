Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35D2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DC22173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 23:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580428223;
	bh=sMz85wRSjNdz8O+qr3zYIEcgVX0eP8CXjq1rhP/j0cM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Fdng/aV1hp1V57Wn0yG00pMTeDRWTs9dLmQyhDEiu4CHP63etCuI2PAxiWB/qTyvh
	 ZkrziYs1IBo9Q+EtVGxZR573wflYM00ugQTmx8R4xECd33CwedWLyVOrwTuKyidLNb
	 jAElyp8BpSkPBa8cam5hxQ3vQDBi1MDcFiZeyfmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgA3XuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:50:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgA3XuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 18:50:19 -0500
Subject: Re: [GIT PULL] UBIFS changes for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580428219;
        bh=sMz85wRSjNdz8O+qr3zYIEcgVX0eP8CXjq1rhP/j0cM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ludw4atGSqzHGvuJvMsSGqSwiEhjaLYBob8aGDfy5/HUs47VuGVriIHglph/RTIvn
         kGQdtIO+Kj3Qslmckp92OrqqdpSZqNOtUKHmOncjCZz3LpM/GfgDs97CEbRvMf4g2u
         kYL/Oi4Z231YGJ0Zvda3B1XO3asrorvvYbBcMRFI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200130211433.46abdf90@xps13>
References: <20200130211433.46abdf90@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200130211433.46abdf90@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git
 tags/upstream-5.6-rc1
X-PR-Tracked-Commit-Id: 5d3805af279c93ef49a64701f35254676d709622
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e84bcd61f686d65956c9f54872778bb215059519
Message-Id: <158042821932.30792.16094549720157204175.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 23:50:19 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Jan 2020 21:14:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/upstream-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e84bcd61f686d65956c9f54872778bb215059519

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
