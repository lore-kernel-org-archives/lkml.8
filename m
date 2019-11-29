Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE8EC2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2E52082D
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgC1Qnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:43:33 -0400
Received: from mx.sdf.org ([205.166.94.20]:50199 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbgC1QnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:21 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhHan022954
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:17 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhHN7015213;
        Sat, 28 Mar 2020 16:43:17 GMT
Message-Id: <202003281643.02SGhHN7015213@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Fri, 29 Nov 2019 15:39:41 -0500
Subject: [RFC PATCH v1 27/50] drivers/s390/scsi/zcsp_fc.c: Use
 prandom_u32_max() for backoff
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need crypto-grade random numbers for randomized backoffs.

(We could skip the if() if we wanted to rely on the undocumented fact
that prandom_u32_max(0) always returns 0.  That would be a net time
saving it port_scan_backoff == 0 is rare; if it's common, the if()
is false often enough to pay for itself. Not sure which applies here.)

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/scsi/zfcp_fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index b018b61bd168e..d24cafe02708f 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -48,7 +48,7 @@ unsigned int zfcp_fc_port_scan_backoff(void)
 {
 	if (!port_scan_backoff)
 		return 0;
-	return get_random_int() % port_scan_backoff;
+	return prandom_u32_max(port_scan_backoff);
 }
 
 static void zfcp_fc_port_scan_time(struct zfcp_adapter *adapter)
-- 
2.26.0

