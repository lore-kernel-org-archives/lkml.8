Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD47CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53A420775
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jqFRszdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgGHMEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbgGHMC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:02:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99599C08E6DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:02:28 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a6so3831700wmm.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oudq2oeculi6K4POMA0xfQMiSgZLhEbNGoOFwG0ADmE=;
        b=jqFRszdpAMk/WEosA8vCIRplw1s1iZVrYBQi444fVIoA249wMXPC1qA438UH/pbuQP
         Y10ZiE8f7eoJFYP7Cg3TfSow5vMIIKrfp4BoWdH+JPlXnbdl81a5gGetvj1SYKBgNf4F
         D35LtipJgz5JBrVEq+XnPNNiOHGzFPmjAwzdsQDMSptzo/0L1uaqMjWCMQSk2NEpk//M
         dZDsHlJINjfzhUqIRcSIdEAIWl/KwTxs3zuFSFQIS6xfqMoPsiLbmJS8520VaOUnJdPl
         7iYbyatQKg/SdPNXYUQKn0Efp4F0tDOkI3pFXy8P79jDnb/eHuubmfN6cdgpM2dB5H3d
         FF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oudq2oeculi6K4POMA0xfQMiSgZLhEbNGoOFwG0ADmE=;
        b=BMwyWkcGOxu4k1UkBSjoVvAwFT5yMELf7nHd/oExkCDNEK/4w3+8fjP/FxXB8eG62m
         mvmEyfv6OsIHfaHOIdb5+5rJcXg0dMKXjY/xnUIZLw/HMkrgRiyNdTwT6WFEtpn0SHot
         YwYgVFEo4LelcwVBZSBuws4W1mOQxIwFnr77iMxdO3ulVJPtvC1BjM8EL1A0F0dTsRiR
         X5UL1N1VP5s4i23Tnnl4k4PlsMs2k5NHltIQiC1XOFmLmOBO5Tim/KDLf0ZTq5XShW3F
         YzbsMdRrGxVwPG4uj1Tpa1ws5LZ17ZyxHreEztAiaOV2Sn24WwYfhyTcix0Lav1KPUVT
         otJw==
X-Gm-Message-State: AOAM530jr0R99pWvmfg3bVLiQ7wkgukqZtbQBQplksw6XROdyDJbaL77
        NyOxjrWHTrs9uHWD9HOXAyYy8Q==
X-Google-Smtp-Source: ABdhPJzYNIcclovtnQ3AJIvggPGf90KHk3jlI7m3GaG1Us2M/TmmiUx/g/jjRI1O0K985J5D3nwqIQ==
X-Received: by 2002:a1c:2842:: with SMTP id o63mr8902604wmo.169.1594209747310;
        Wed, 08 Jul 2020 05:02:27 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id m62sm3964997wmm.42.2020.07.08.05.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:02:26 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 02/30] include: scsi: scsi_transport_fc: Match HBA Attribute Length with HBAAPI V2.0 definitions
Date:   Wed,  8 Jul 2020 13:01:53 +0100
Message-Id: <20200708120221.3386672-3-lee.jones@linaro.org>
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

