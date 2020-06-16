Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C89C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4D62074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxiUvWl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgFPGOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgFPGNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:13:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F31C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l10so19383769wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6mpvPq9LvxOPLoQsBoTj25U6plJEiyM73+Tb9BB7RNE=;
        b=PxiUvWl6HJcJqUfGhCkE2MTdSHLpRyXF10WKIR5wM/tWE9ayQpWDK5+QsLgjLHEZtS
         Q4CZyz9GV2Rm7JvMWhSDpAj6RI5lRaDJw7tE16OXXegh3PEkWE4LDS6iZDtRLS3MAsJj
         jPhkf+eOXNwP5e3ORbU5jFaerl2ZRKrVFoYP9R5Ler5Qikycz2CQsMHYEcu42SUuUhQ7
         2+eStlEH9tgH3PrsfcCDL5BYUaBwAAiLRgaWddWO50jd25VKjeVAJBzmlxPhyKI27J8j
         ILyAp6Mea3zRlABTrCF7h5PraxOkeyOoTvsqdaFNveeCG3TpIFuABCTFuDfSSQcPtlym
         uiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6mpvPq9LvxOPLoQsBoTj25U6plJEiyM73+Tb9BB7RNE=;
        b=etlZFklUdDI2QADiUmJyYi9rWwW38onz2rpmy2TotOKOhKfgmzeVdlI91gLTzrCdPS
         suyprjj7XigdY92k4LGva3TOLwM2wAxddiDCynTj7BPeuHyyUz4J9NkWBJDA/3Wmi3Lc
         rWqFZ5APdRA+coGa+rurXJFodA0ksnq/8qRgUnL77JLC2hd6255Zeiu9l5w7a6r+P/Ri
         4sjf+Pk1AepWasjQLHZ8IOHTGLY7jZjSAY7bsqGydFXSW6Z8lfvA1uN15YT4s9j7hVxM
         vmype61ea3G42d7XxRIPfMzYUOqv775mkPBp6oF9NYH5twX5gC29IdkXeenSLFP5PuPe
         qJmw==
X-Gm-Message-State: AOAM5315p5kH4rnx2T43V+kksKjoMb6EPzqhqi8zsO7wIpkErB0xNsfx
        WPmyB8U+eTA59c1iEYXzu2DlQRKy2j0=
X-Google-Smtp-Source: ABdhPJyXr+exHYzgTsT//mRndtyEIrrG1KiVetfcizvzB5A3q7Zbz5pUQESE22z+WdI5olw3gYC+TQ==
X-Received: by 2002:adf:97d3:: with SMTP id t19mr1336341wrb.116.1592288021582;
        Mon, 15 Jun 2020 23:13:41 -0700 (PDT)
Received: from ODED-MAIN.localdomain ([87.71.142.251])
        by smtp.gmail.com with ESMTPSA id s2sm2354963wmh.15.2020.06.15.23.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 23:13:40 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 5/7] uapi/habanalabs: fix some comments
Date:   Tue, 16 Jun 2020 09:13:25 +0300
Message-Id: <20200616061327.12006-5-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616061327.12006-1-oded.gabbay@gmail.com>
References: <20200616061327.12006-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAP/UNMAP are done also for device memory.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 include/uapi/misc/habanalabs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index f6267a8d7416..f218d1c62c62 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -530,13 +530,13 @@ union hl_wait_cs_args {
 	struct hl_wait_cs_out out;
 };
 
-/* Opcode to alloc device memory */
+/* Opcode to allocate device memory */
 #define HL_MEM_OP_ALLOC			0
 /* Opcode to free previously allocated device memory */
 #define HL_MEM_OP_FREE			1
-/* Opcode to map host memory */
+/* Opcode to map host and device memory */
 #define HL_MEM_OP_MAP			2
-/* Opcode to unmap previously mapped host memory */
+/* Opcode to unmap previously mapped host and device memory */
 #define HL_MEM_OP_UNMAP			3
 
 /* Memory flags */
-- 
2.17.1

