Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E500C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B442070B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgDUL4v convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 07:56:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:14306 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgDUL4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:56:50 -0400
IronPort-SDR: z+CsqIZzFRQqE4/qgUnDcKoUaDmzQCGRPDobaunAQ2JQfnK8de4q8toiIvzWJwhUOL82Z0skz+
 LjqAnxSNAiew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 04:56:50 -0700
IronPort-SDR: ss5gZPH9RFXb/mbTaVOM9KDF+8qBwsRimZ4nsKZ+Y39bb7azaHnyps5sn0NKG2EhdwxYfnEFlp
 Lfm+8sEUlcJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,410,1580803200"; 
   d="scan'208";a="279611530"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga004.fm.intel.com with ESMTP; 21 Apr 2020 04:56:50 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Apr 2020 04:56:50 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.129]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.89]) with mapi id 14.03.0439.000;
 Tue, 21 Apr 2020 19:48:09 +0800
From:   "Ma, Jianpeng" <jianpeng.ma@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RESEND]block: remove unused header
Thread-Topic: [RESEND]block: remove unused header
Thread-Index: AdYX0rl3DxU1LQC5RfqOTHbWaoDw/w==
Date:   Tue, 21 Apr 2020 11:48:08 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C73C54781@SHSMSX101.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dax related code already removed from this file.

Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
---
 fs/block_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 52b6f646cdbd..4163435dc231 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -19,7 +19,6 @@
 #include <linux/module.h>
 #include <linux/blkpg.h>
 #include <linux/magic.h>
-#include <linux/dax.h>
 #include <linux/buffer_head.h>
 #include <linux/swap.h>
 #include <linux/pagevec.h>
-- 
2.17.1

> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Tuesday, April 21, 2020 7:33 PM
> To: Ma, Jianpeng <jianpeng.ma@intel.com>
> Cc: axboe@kernel.dk; Williams, Dan J <dan.j.williams@intel.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: block: remove unused header
> 
> On Tue, Apr 21, 2020 at 05:48:46AM +0000, Ma, Jianpeng wrote:
> > >From 95218bc1d79f2bcbdd8819be26efa698868a34ca Mon Sep 17 00:00:00
> 2001
> > From: Jianpeng Ma <jianpeng.ma@intel.com>
> > Date: Tue, 21 Apr 2020 01:15:24 -0400
> > Subject: [PATCH] block: remove unused header.
> >
> > Dax related code already removed from this file.
> >
> > Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
> 
> Except for the mangled patch format this looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Can you resend it with proper patch headers?
