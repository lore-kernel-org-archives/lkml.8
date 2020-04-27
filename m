Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E76C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7C92072D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="mckb55iH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgD0UdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:33:15 -0400
Received: from gateway20.websitewelcome.com ([192.185.4.169]:16200 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726230AbgD0UdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:33:14 -0400
X-Greylist: delayed 1498 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Apr 2020 16:33:13 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 67B87400CCA53
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:27:11 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id T9gGjU1aN8vkBT9gGjDwSk; Mon, 27 Apr 2020 14:44:40 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VRUZQhEnPk469+Qwnk58nua2haaBvdA4SRE7j9QA81c=; b=mckb55iH5NRVNCVctN5DRl+9Mf
        CN8qAKs3P777km2hJ8XBPpntvs4o7qMdb23jU+h41krAYNBeSqo7xby8FemDIYARfRZSAeZkXhDrI
        Srm1G2IeOAbTRkGrNvXlMLwlqgRhwGrEeimiOtw1b8FpG3DqoB6I1iTVtiTSnWMavlVzv0PxaJcSE
        K+z0EH+DP1PWgzMOqv28B/xsgi8UtOvUhAWHG1LpP4+wukMfG8/SCdR5/Mk+Tgcp7AglvA81omr2v
        zrDN1aYCXwzK9wNkV5WdFTFXfCWx0pmUgOVPB5pqsKAxz5dz6Hr09iqlRVWeqfD4+YRSco8YzpK9J
        vGPma7nQ==;
Received: from [201.162.241.110] (port=19065 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jT9gF-000xYF-SV; Mon, 27 Apr 2020 14:44:39 -0500
Date:   Mon, 27 Apr 2020 14:48:58 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2 0/3] mtd: lpddr: Fix bad logic bug in print_drs_error
Message-ID: <cover.1588016644.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.241.110
X-Source-L: No
X-Exim-ID: 1jT9gF-000xYF-SV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.241.110]:19065
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 19
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series aims to fix a bad logic bug in print_drs_error, which is
tagged for -stable.  The series also include some formatting fixups.

Thanks

Changes in v2:
 - Coalesce formats in Patch 2.
 - Remove inline from print_drs_error in Patch 3.
 - Update changelog texts according to the last
   changes.

Gustavo A. R. Silva (3):
  mtd: lpddr: Fix bad logic in print_drs_error
  mtd: lpddr: Replace printk with pr_notice
  mtd: lpddr: Move function print_drs_error to lpddr_cmds.c

 drivers/mtd/lpddr/lpddr_cmds.c | 28 ++++++++++++++++++++++++++++
 include/linux/mtd/pfow.h       | 33 ---------------------------------
 2 files changed, 28 insertions(+), 33 deletions(-)

-- 
2.26.0

