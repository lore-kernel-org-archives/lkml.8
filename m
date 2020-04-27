Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C503FC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A80020775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="AeU7CXrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgD0TUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:20:39 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.196]:20772 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726364AbgD0TUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:20:39 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id CFE79B152
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:56:05 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id T8vFjA5J4EfyqT8vFj05SX; Mon, 27 Apr 2020 13:56:05 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MkwcCR3lst8/B7n+4ulIUXVmvitCgG29H/hIsQNGTwQ=; b=AeU7CXrxhdg9fpvzHvSe2zoXvw
        eyL94sVa/mqO6UoWJcna3+3WJgMcMSp+rWmLFi3KJjN+D17t5e0HI5BSf7RVCz9+SQgmt8SR4Klfh
        cgQ7pSm6LV64O5i5YZ9QJwkpLTyGZQAqGkyQvX5a9Ueivthd3XzVSZqTO3/U8nriuffjsO70i4WEa
        ia9E8VNkhvzxoUHPzvTW/NLs5sp2Ju/g16I5qmFgVM0jHkhUH0xQQJFit/fb5ow7hxJcFz9mljXjk
        66OgOi0/9pQmfERp0iMEy+xzEKB8YOhGn6xDgSQI0GvlMhZNR85khKUeXU35Nip0nRmH/xArBbmxc
        lEPNmwkw==;
Received: from [201.162.241.110] (port=27793 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jT8vF-000Yrj-Dk; Mon, 27 Apr 2020 13:56:05 -0500
Date:   Mon, 27 Apr 2020 14:00:23 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 0/3] mtd: lpddr: Fix bad logic bug in print_drs_error
Message-ID: <cover.1588013366.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1jT8vF-000Yrj-Dk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.241.110]:27793
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
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

Gustavo A. R. Silva (3):
  mtd: lpddr: Fix bad logic in print_drs_error
  mtd: lpddr: Replace printk with pr_notice
  mtd: lpddr: Move function print_drs_error to lpddr_cmds.c

 drivers/mtd/lpddr/lpddr_cmds.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/mtd/pfow.h       | 32 --------------------------------
 2 files changed, 33 insertions(+), 32 deletions(-)

-- 
2.26.0

