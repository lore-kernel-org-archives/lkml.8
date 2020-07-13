Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE7DC433F8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F3820720
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VLiZTK1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbgGMHsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbgGMHqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:46:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34061C08C5DD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:46:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so12301150wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oudq2oeculi6K4POMA0xfQMiSgZLhEbNGoOFwG0ADmE=;
        b=VLiZTK1YdPounijVnkxQ3ZjJXAksw6WHoLAGOcJ3PPwwLBAgKzsO6C68bpRtW2oM8l
         P23zcEDL2q+LbLvngUYT6ZEFO7pKZl7Sl1hb8WA9PtC+MBlZViu3jYskVRT8pEhii/rA
         tV+xAXEneOWp4sRcXUk2nE9UUDl6b6sYd/KiRLeEDlJ81hehGArRGwNbA4NyHz3zCFqH
         tfE0GL0v7JUnk1UakZgNbPJy2wlhfqHB95cb8DXF1OJn4bVgYFRygsN/fEKxc3w7QUFP
         Xdsjd76DNvdjJGLL0aHhfKkP13hnEqjI/fB9oeAOTc13rdVgfP6fz5eoFK4fU/FTsCoB
         ZjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oudq2oeculi6K4POMA0xfQMiSgZLhEbNGoOFwG0ADmE=;
        b=O3psfVEW0V/ZCwQnOLJJybA7PcGU8ffkNRUbATXfJgnuVq/So0/VQ23DSW1WuUESru
         jsKVhorBZ5dmmbTFKq92L/B9AjBNdTV24WTL9NSl09GLHV5o0XQizTchlyG5jEjlHt5V
         do069FNpeE08Yb/GRh4SSnjrD20NJbfxwOTdrjTt/V51bbkRgWksSDyfxq788f1EJLLd
         ke3W9TJAGePktxaHNLGi4wBUrB6qvbTp+PRQPb8tMWTnJx3bDcc+8h6Ur22149Su8H2V
         zQr+/xhLy7NyBpILiN2EW/LciHIwJbn1Pm5CuCamlZ2RTeUPkfYYnz/iGEASx92/z0go
         /MuQ==
X-Gm-Message-State: AOAM533s+Utu6Ur+/0ZQp0SNfAbzBVIFlaoMws1KsYLklWDl7dP+5Q7Z
        aaWgRjyOCbd/gtdxnRhHTgKdIw==
X-Google-Smtp-Source: ABdhPJybRu2H52vwDKAoLc7Wg3gmekkvg4QBs6pwc2WHuHji+ygyeu/Opw5m8U3YkJ1vTDi5KxbB3w==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr17317622wmh.134.1594626409906;
        Mon, 13 Jul 2020 00:46:49 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id k11sm25142488wrd.23.2020.07.13.00.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 00:46:49 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 02/29] include: scsi: scsi_transport_fc: Match HBA Attribute Length with HBAAPI V2.0 definitions
Date:   Mon, 13 Jul 2020 08:46:18 +0100
Message-Id: <20200713074645.126138-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713074645.126138-1-lee.jones@linaro.org>
References: <20200713074645.126138-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to 'include/scsi/scsi_transport_fc.h':

 "Attributes are based on HBAAPI V2.0 definitions"

... so it seems sane to match the 'HBA Attribute Length' to them.

If we don't, the compiler complains that the copied data will be truncated.

Fixes the following W=1 kernel build warning(s):

 In file included from include/linux/bitmap.h:9,
 from include/linux/cpumask.h:12,
 from include/linux/smp.h:13,
 from include/linux/percpu.h:7,
 from include/scsi/libfc.h:13,
 from drivers/scsi/libfc/fc_elsct.c:17:
 In function ‘strncpy’,
 inlined from ‘fc_ct_ms_fill.constprop’ at include/scsi/fc_encode.h:263:3:
 include/linux/string.h:297:30: warning: ‘__builtin_strncpy’ output may be truncated copying 64 bytes from a string of length  79 [-Wstringop-truncation]
 297 | #define __underlying_strncpy __builtin_strncpy
 | ^
 include/linux/string.h:307:9: note: in expansion of macro ‘__underlying_strncpy’
 307 | return __underlying_strncpy(p, q, size);
 | ^~~~~~~~~~~~~~~~~~~~
 In function ‘strncpy’,
 inlined from ‘fc_ct_ms_fill.constprop’ at include/scsi/fc_encode.h:275:3:
 include/linux/string.h:297:30: warning: ‘__builtin_strncpy’ output may be truncated copying 64 bytes from a string of length 79 [-Wstringop-truncation]
 297 | #define __underlying_strncpy __builtin_strncpy
 | ^
 include/linux/string.h:307:9: note: in expansion of macro ‘__underlying_strncpy’
 307 | return __underlying_strncpy(p, q, size);
 | ^~~~~~~~~~~~~~~~~~~~

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/scsi/fc/fc_ms.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/scsi/fc/fc_ms.h b/include/scsi/fc/fc_ms.h
index 800d53dc94705..9e273fed0a85f 100644
--- a/include/scsi/fc/fc_ms.h
+++ b/include/scsi/fc/fc_ms.h
@@ -63,8 +63,8 @@ enum fc_fdmi_hba_attr_type {
  * HBA Attribute Length
  */
 #define FC_FDMI_HBA_ATTR_NODENAME_LEN		8
-#define FC_FDMI_HBA_ATTR_MANUFACTURER_LEN	64
-#define FC_FDMI_HBA_ATTR_SERIALNUMBER_LEN	64
+#define FC_FDMI_HBA_ATTR_MANUFACTURER_LEN	80
+#define FC_FDMI_HBA_ATTR_SERIALNUMBER_LEN	80
 #define FC_FDMI_HBA_ATTR_MODEL_LEN		256
 #define FC_FDMI_HBA_ATTR_MODELDESCR_LEN		256
 #define FC_FDMI_HBA_ATTR_HARDWAREVERSION_LEN	256
-- 
2.25.1

