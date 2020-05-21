Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B9AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5892065F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzsDwStf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgEUHCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbgEUHCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:02:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216BAC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 00:02:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i15so5539682wrx.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 00:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oUnYKu/3iizm/QlwVQUY4HWuKK9oYLkhrBthK4Mvo+c=;
        b=AzsDwStfIHoOws1PA+tdH/h2UZmFIFRBZLgWpBoTs+uIQHcRiTC81sVkZuI7CNqT92
         Ua1tLfJxmFKTd3F1FumxEVctKnR3MULnnmj72/DprSfA/rFWvKDmChGVuQshF95tPvLb
         MTn8FjO6i9nPVB22nP3gc2EKzRhowcfXmJ28cRhHX2w/9955JTn7KZLF51SVyzLQQpA4
         ppcSdjOOEQ2rOjvXpiQf/YetqeZK6HCKPKa78KJERMn5vqrfcVaPIdXdLSiSwG858GKs
         CxjYBFT+ojsVG7tekeLnJLuMvWu9RwmsSqY3wbUXMa/USlfbbU+8ZG34KsqWi9XwnWsD
         9hBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oUnYKu/3iizm/QlwVQUY4HWuKK9oYLkhrBthK4Mvo+c=;
        b=HnvtPe+EuGhkvSmhHjxCUgKnbFyZ6CmLfWuM9KgxK56lt9LgSL+5SzJ2yqf2sHa/zm
         EL5/wY1bw7nslbpGuAccwvFC0Ko2OGKgj0QW2sG7TKVc+Czi9v59E5Zyz+DI6KS148Vu
         Bn0LaJQbouNpD8ZydO0fDAUnXZHhZ+xI0udDeK/l3ZOovyuPm0qMmK6nX//loDBseicp
         3sb36vzz7T3NQnnph6h1wBliEczOpRPCu66+K4sSd9QKsQqw1VtRSALIFdhDR34NVLs9
         aKiql2R9vGyUUseKtuGMDq6QoPG/121g+xnMA2DG77MbAmKze2ez7x8BHrorx8pNF/RG
         6Wsg==
X-Gm-Message-State: AOAM532g9YVra2+Js+JIwsrMN24aGCA2GAYBjvgZ+38cMIESLNS3tEVK
        atpEczDS44OvsK/MqYFEr8mBgvcd
X-Google-Smtp-Source: ABdhPJwYSlSuVFRMAJ/VVjnu7V5hkrNfuEOEodsMOfzDeGfsPGZvxkeFCYB96sPwy3IJwH5AehEpUQ==
X-Received: by 2002:a5d:608f:: with SMTP id w15mr6268172wrt.223.1590044534531;
        Thu, 21 May 2020 00:02:14 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id w20sm5448205wmk.25.2020.05.21.00.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 00:02:13 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 2/4] habanalabs: add print for soft reset due to event
Date:   Thu, 21 May 2020 10:02:03 +0300
Message-Id: <20200521070205.26673-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521070205.26673-1-oded.gabbay@gmail.com>
References: <20200521070205.26673-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

Print the event name that caused the soft reset.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 093384731f0d..3d4a569914d3 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5843,8 +5843,12 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 		soft_reset_required = gaudi_tpc_read_interrupts(hdev,
 					tpc_dec_event_to_tpc_id(event_type),
 					"AXI_SLV_DEC_Error");
-		if (soft_reset_required)
+		if (soft_reset_required) {
+			dev_err_ratelimited(hdev->dev,
+					"soft reset required due to %s\n",
+					gaudi_irq_map_table[event_type].name);
 			hl_device_reset(hdev, false, false);
+		}
 		hl_fw_unmask_irq(hdev, event_type);
 		break;
 
@@ -5860,8 +5864,12 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 		soft_reset_required = gaudi_tpc_read_interrupts(hdev,
 					tpc_krn_event_to_tpc_id(event_type),
 					"KRN_ERR");
-		if (soft_reset_required)
+		if (soft_reset_required) {
+			dev_err_ratelimited(hdev->dev,
+					"soft reset required due to %s\n",
+					gaudi_irq_map_table[event_type].name);
 			hl_device_reset(hdev, false, false);
+		}
 		hl_fw_unmask_irq(hdev, event_type);
 		break;
 
-- 
2.17.1

