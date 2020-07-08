Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D515C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA942065C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYVP4yTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgGHMCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgGHMCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:02:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FDAC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:02:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f2so20692313wrp.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sZwSMA5UIb7oM9+D5j+l12KsCqeP4op1hhjOFtyL2ps=;
        b=wYVP4yTrdIb3gPXKLBwSIe8aCHTr6bqSOLL6eZHfT2SvX4q7eX66ukJezKlb3lJqzz
         CMDoawaoFMDHzHmDGUCKQ6z7g/1iBWboIw+C6XhatxXuamWkI+POzEoQS8TVmKkIoHjn
         lDqKVIY9a1/orsCpupEsEuTM39RugV8ru6SmhANSET57A7VpxrvkQJ+SE2M2lcl2jD0b
         n2EXTHaIJfjG7vIhxcWdJTpZqeBDEtlI96662m8C4+2T7wWh/+pZOhrRQB1snq6rGvuy
         ldFuM1a634U11GCgiL8GLL8ONxQ1GezKf3CdyRcJet9PeWu1yxrI1x04pzhr6hv//mrS
         SmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sZwSMA5UIb7oM9+D5j+l12KsCqeP4op1hhjOFtyL2ps=;
        b=aHmPLGdpxKMuJKog+6EtOQAvfNAyFUfR+RNT11THAV6aM26e5K3eKGBARF8Av1CBku
         JN5iU7dBPB+sWhq0OgrJb0HdtCdqCPknN1kPDA3Liot3OpGdmj23io5gIkPCOgIxIHJf
         yyiU3G1AZoMypbGQrxYrgt+dVly2O0WGHXTcFnao8nvCDN2QQBVvkWZa9byjWt32VDI0
         RSMH+ubC5y3n05vSCVX3pkJIhhFXo0XmrlO5dpFfrkeR6VnTeXBsgpjkGCGJG48BI3HZ
         J7iPV1bdlrRYdHQmNj5rs/4Bi/YS8+CEuNEywtNXBQcd+X8wOEFnMtVFQZPE7kdgARhT
         IFoA==
X-Gm-Message-State: AOAM533v3BTOm0NNGSpmP0AgYSlVqboabpqOupu5Vf+/8/iMqp8UgQXc
        HeTfhhSrmccVZy+mu+styObRPg==
X-Google-Smtp-Source: ABdhPJzUhN5+/7ZGY9cHq+7oMDlNaKPxbiI8XirtTADjCEmOj88jT3VDHFhh0FBXmjOTu9U+a4GNVg==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr56966206wru.310.1594209767822;
        Wed, 08 Jul 2020 05:02:47 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id m62sm3964997wmm.42.2020.07.08.05.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:02:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, support@areca.com.tw
Subject: [PATCH 16/30] scsi: arcmsr: arcmsr_hba: Make room for the trailing NULL, even if it is over-written
Date:   Wed,  8 Jul 2020 13:02:07 +0100
Message-Id: <20200708120221.3386672-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708120221.3386672-1-lee.jones@linaro.org>
References: <20200708120221.3386672-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure we do not copy the final one (which is not overwitten).

Fixes the following W=1 kernel build warning(s):

 In file included from include/linux/bitmap.h:9,
 from include/linux/nodemask.h:95,
 from include/linux/mmzone.h:17,
 from include/linux/gfp.h:6,
 from include/linux/umh.h:4,
 from include/linux/kmod.h:9,
 from include/linux/module.h:16,
 from drivers/scsi/arcmsr/arcmsr_hba.c:47:
 In function ‘strncpy’,
 inlined from ‘arcmsr_handle_virtual_command’ at drivers/scsi/arcmsr/arcmsr_hba.c:3055:3:
 include/linux/string.h:297:30: warning: ‘__builtin_strncpy’ output truncated before terminating nul copying 4 bytes from a string of the same length [-Wstringop-truncation]
 297 | #define __underlying_strncpy __builtin_strncpy
 | ^
 include/linux/string.h:307:9: note: in expansion of macro ‘__underlying_strncpy’
 307 | return __underlying_strncpy(p, q, size);
 | ^~~~~~~~~~~~~~~~~~~~
 In function ‘strncpy’,
 inlined from ‘arcmsr_handle_virtual_command’ at drivers/scsi/arcmsr/arcmsr_hba.c:3053:3:
 include/linux/string.h:297:30: warning: ‘__builtin_strncpy’ output truncated before terminating nul copying 16 bytes from a string of the same length [-Wstringop-truncation]
 297 | #define __underlying_strncpy __builtin_strncpy
 | ^
 include/linux/string.h:307:9: note: in expansion of macro ‘__underlying_strncpy’
 307 | return __underlying_strncpy(p, q, size);
 | ^~~~~~~~~~~~~~~~~~~~
 In function ‘strncpy’,
 inlined from ‘arcmsr_handle_virtual_command’ at drivers/scsi/arcmsr/arcmsr_hba.c:3051:3:
 include/linux/string.h:297:30: warning: ‘__builtin_strncpy’ output truncated before terminating nul copying 8 bytes from a string of the same length [-Wstringop-truncation]
 297 | #define __underlying_strncpy __builtin_strncpy
 | ^
 include/linux/string.h:307:9: note: in expansion of macro ‘__underlying_strncpy’
 307 | return __underlying_strncpy(p, q, size);
 | ^~~~~~~~~~~~~~~~~~~~

Cc: support@areca.com.tw
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/arcmsr/arcmsr_hba.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 1c252934409c7..5feed135eb26c 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -3031,7 +3031,7 @@ static void arcmsr_handle_virtual_command(struct AdapterControlBlock *acb,
 {
 	switch (cmd->cmnd[0]) {
 	case INQUIRY: {
-		unsigned char inqdata[36];
+		unsigned char inqdata[37];
 		char *buffer;
 		struct scatterlist *sg;
 
@@ -3048,16 +3048,16 @@ static void arcmsr_handle_virtual_command(struct AdapterControlBlock *acb,
 		/* ISO, ECMA, & ANSI versions */
 		inqdata[4] = 31;
 		/* length of additional data */
-		strncpy(&inqdata[8], "Areca   ", 8);
+		strncpy(&inqdata[8], "Areca   ", 9);
 		/* Vendor Identification */
-		strncpy(&inqdata[16], "RAID controller ", 16);
+		strncpy(&inqdata[16], "RAID controller ", 17);
 		/* Product Identification */
-		strncpy(&inqdata[32], "R001", 4); /* Product Revision */
+		strncpy(&inqdata[32], "R001", 5); /* Product Revision */
 
 		sg = scsi_sglist(cmd);
 		buffer = kmap_atomic(sg_page(sg)) + sg->offset;
 
-		memcpy(buffer, inqdata, sizeof(inqdata));
+		memcpy(buffer, inqdata, sizeof(inqdata) - 1);
 		sg = scsi_sglist(cmd);
 		kunmap_atomic(buffer - sg->offset);
 
-- 
2.25.1

