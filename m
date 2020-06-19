Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A766DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7712221556
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=superboring.dev header.i=@superboring.dev header.b="EIibVB0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389520AbgFSTeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389134AbgFSTeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:34:12 -0400
Received: from mail.halogenos.org (halogenos.org [IPv6:2a02:c207:2037:5246::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C14C061795
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:34:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB5D51500CE3;
        Fri, 19 Jun 2020 21:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=superboring.dev;
        s=dkim; t=1592595250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n3C5MzC9qhDPXLhVz5/798mE4wtojox08uKVID90Ezk=;
        b=EIibVB0KxsP0ww/IA8PByfzFR9wGLYM+z2ah/SJuqr49B6SvO6T0SfwsyIbnB/WoyS84kq
        SKt2mSMqcAeWCmOD8GYKTFUdz6wBue2Ai9y3VXjvpn6zI1r3sZwwh8qjspQ+ikjTKuYp3H
        DDmdig3C5gGaoY+8heuot4f9CDNdObteRasMBVL/T3KiW/yN+EViy1EKyH9wSFTA0NgOuP
        qwKLRdiIyrtAvLf5saleZDiJ2BXqIEoy23v5URo6vXvm0m4HRL8gNkKA9itNdcSZDuVCOr
        58gvc44KtHxLw3dr9swwEfCwhptG2zbYYNtpFm/9PXOCITKVOdnXuRHa4q4StQ==
From:   Simao Gomes Viana <devel@superboring.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Simao Gomes Viana <devel@superboring.dev>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 9/9] drivers: cdrom: fix spacing and wrapping
Date:   Fri, 19 Jun 2020 21:33:41 +0200
Message-Id: <20200619193341.51209-9-devel@superboring.dev>
In-Reply-To: <20200619193341.51209-1-devel@superboring.dev>
References: <20200619180834.8032-1-devel@superboring.dev>
 <20200619193341.51209-1-devel@superboring.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was reported by scripts/checkpatch.pl

Signed-off-by: Simao Gomes Viana <devel@superboring.dev>
---
 drivers/cdrom/cdrom.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index d96458de1cb3..da8d26901b42 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2166,10 +2166,17 @@ static int cdrom_read_block(struct cdrom_device_info *cdi,
 
 	/* set the header info returned */
 	switch (blksize) {
-	case CD_FRAMESIZE_RAW0	: cgc->cmd[9] = 0x58; break;
-	case CD_FRAMESIZE_RAW1	: cgc->cmd[9] = 0x78; break;
-	case CD_FRAMESIZE_RAW	: cgc->cmd[9] = 0xf8; break;
-	default			: cgc->cmd[9] = 0x10;
+	case CD_FRAMESIZE_RAW0:
+		cgc->cmd[9] = 0x58;
+		break;
+	case CD_FRAMESIZE_RAW1:
+		cgc->cmd[9] = 0x78;
+		break;
+	case CD_FRAMESIZE_RAW:
+		cgc->cmd[9] = 0xf8;
+		break;
+	default:
+		cgc->cmd[9] = 0x10;
 	}
 
 	return cdo->generic_packet(cdi, cgc);
-- 
2.27.0

