Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23018C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA86B206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9Ge2o+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgIDSrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 14:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgIDSqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:46:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EF4C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 11:46:41 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w2so7105577wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 11:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ULH42GEwNi9hzlhhK8pYlc6jFqUJoh0KSWLzC2sUdhI=;
        b=o9Ge2o+WoojlRDRN2u1Fz77V88b5XJlFIg2UAFL0ximPlnlVR7dL4sVIUBVAaQrY5b
         up8tpykJessES5r1VtJrjyyUurLOh+sK6bsdT/y2WPxBknDq6hja7Ptt51SnH9rMKG+q
         z7B7rkLKFUbLngZdey4bTIqC6UNaw3j9XII/cKIlilitl4Gb+2wDa7Jnb6j1CWAGU5D1
         /KtFw7JG0tcGY7q7oZCSYjH2zI+IorOFSW009HyllEWnb2VHxwATCRHATAIctO3IhpT9
         Xnq+6YxBP2MdBb2hRGHGv7C1cIvpKZnQPOckaw7YJ9pSt4KiPMvNp2kr3hcSDqr8pxeq
         y2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ULH42GEwNi9hzlhhK8pYlc6jFqUJoh0KSWLzC2sUdhI=;
        b=t2E1G8ISrXkK9G/EE3FHBbT2yN4cJVPnbweMyPArmNc0rtNyZNdzS2aTj2ZV8CP4Rs
         /LF34d30TtsrNO3fmlSGZk06DPKf8qeZ9Dl51667lKvqSb0x9/uURWjZbreSedqil5iG
         4TxqOK/OPVrB/yz2Yx8PoDEs4xUfCiUNWVJvRFyBnYc4GnONAmwMUN+0B2Uv8bjtnGqf
         38TSv3cVIY80BK7eLzOklcgwP87i5POEZ1dM1gb0jFb4EERBj4xHf3P+O8dCnGtV1N6V
         54xHyMG7hX0n5nsRjPCGOktAERlrCZyQjd5YfRmrM/07tKqxcpybKWddluM5rJSu8MoP
         vJ6A==
X-Gm-Message-State: AOAM531008LbHxWOwPZOvfhgB44fC/SXHinLOg/7nWc94JaHgAK50Djk
        gxVOYPSZP5bBPQrowm/LRMpiDjYQS2M=
X-Google-Smtp-Source: ABdhPJw0LPW9piVH1fLvADKVf95bvirrDE3JJ+uWX2Ds02eAs//m9Uzm4lTTSj388r65K7tTwN8ROA==
X-Received: by 2002:a1c:2742:: with SMTP id n63mr8732306wmn.24.1599245197721;
        Fri, 04 Sep 2020 11:46:37 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id q186sm14111670wma.45.2020.09.04.11.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 11:46:36 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 6/6] habanalabs: check flag before reset because of f/w event
Date:   Fri,  4 Sep 2020 21:46:23 +0300
Message-Id: <20200904184623.13478-6-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904184623.13478-1-oded.gabbay@gmail.com>
References: <20200904184623.13478-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For consistency with GAUDI code, add check of the relevant flag in the
device structure before resetting the GOYA device in case of firmware
event.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 804c83eb12b7..46a900fb3ef8 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4644,7 +4644,8 @@ void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 	case GOYA_ASYNC_EVENT_ID_L2_RAM_ECC:
 	case GOYA_ASYNC_EVENT_ID_PSOC_GPIO_05_SW_RESET:
 		goya_print_irq_info(hdev, event_type, false);
-		hl_device_reset(hdev, true, false);
+		if (hdev->hard_reset_on_fw_events)
+			hl_device_reset(hdev, true, false);
 		break;
 
 	case GOYA_ASYNC_EVENT_ID_PCIE_DEC:
-- 
2.17.1

