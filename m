Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476D4C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 07:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A0A72071E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 07:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="VO56o3I6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="tKVbXkZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgHAHFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 03:05:36 -0400
Received: from relay2.mymailcheap.com ([217.182.66.162]:40590 "EHLO
        relay2.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgHAHFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 03:05:36 -0400
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id B62023EDEC;
        Sat,  1 Aug 2020 09:05:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id E6A082A3A4;
        Sat,  1 Aug 2020 03:05:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1596265532;
        bh=oQuwBKqpUCehpdbwhNUhgNZ31wH764R4ENJaODiI7CA=;
        h=From:To:Cc:Subject:Date:From;
        b=VO56o3I6sX1I7NIFvGVx4/h6nxX2btgtPNlCAEFke0V89Mo+mJnGDBHRs/OB7I9zr
         cukQI0N0pWZ/hZq8N0t64ww0xQrKh9Vfk67BkiFxfhuNQRE41PWfE5gBGFAZcpAFnG
         1fZDphOEc3654V1lVabNLMRiA4N4hrP0do5Lu6Fg=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gciJMM2V8glU; Sat,  1 Aug 2020 03:05:32 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Sat,  1 Aug 2020 03:05:32 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id AD7AD40840;
        Sat,  1 Aug 2020 07:05:30 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="tKVbXkZt";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.163.253])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id C5251419D0;
        Sat,  1 Aug 2020 07:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1596265307; bh=oQuwBKqpUCehpdbwhNUhgNZ31wH764R4ENJaODiI7CA=;
        h=From:To:Cc:Subject:Date:From;
        b=tKVbXkZte9DHrL1bO5I2qNsyYp6cEgzwbmbl0NXLaKXVOW5xlfLUAsxEDiTxVD1Gl
         uOgW9HNFyfW3eMEBH5VOxzP/Q+UvpA9ryhG4i9M5RHNhsiF3jp4vb85g7ERZwckiL4
         kOsoIlLI811LBaKIcHvBa82+kdHe+9bsyBdoL65o=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] mfd: core: Fix handle of OF disabled MFD cells
Date:   Sat,  1 Aug 2020 15:01:30 +0800
Message-Id: <20200801070130.3323112-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AD7AD40840
X-Spamd-Result: default: False [4.90 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.163.253:received];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         BROKEN_CONTENT_TYPE(1.50)[];
         TO_DN_SOME(0.00)[];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When rewriting the OF match code of MFD core, addition of cells disabled
in OF will result in a failure with error -ENODEV. This is an unexpected
behavior, as the previous behavior is silently ignore the cell. On
SBCs with AXP20x PMICs, this leads to boot failure if AXP20x PMIC
support is built-in and some cells (especially power supply ones) are
disabled.

Silently ignore the cell when -ENODEV occurs.

Fixes: e49aa9a9bd22 ("mfd: core: Make a best effort attempt to match devices with the correct of_nodes")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/mfd/mfd-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index c3ef58a802bee..31b363c64f4b4 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -215,8 +215,13 @@ static int mfd_add_device(struct device *parent, int id,
 				ret = mfd_match_of_node_to_dev(pdev, np, cell);
 				if (ret == -EAGAIN)
 					continue;
-				if (ret)
+				if (ret) {
+					if (ret == -ENODEV) {
+						/* Ignore disabled devices error free */
+						ret = 0;
+					}
 					goto fail_alias;
+				}
 
 				break;
 			}
-- 
2.27.0
