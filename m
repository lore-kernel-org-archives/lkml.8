Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF348C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB0C120736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFfXnGm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbgEKLdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729824AbgEKLdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:33:02 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CE4C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:33:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id m12so12774904wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=+WdGFG38vchf7zqZcP+XZNT8zPzw6L2Kr3ch5yLPtTE=;
        b=kFfXnGm6JGT87tjfTOhwLewknmtmGgw70zUVGMURo+23W93dTAzOUbui9d+4evMGAo
         DJnIKcfl3fP3AFxg90NYl6HZgvipVITTow3Ei++TjRLt0RZkPD+3LmQFKjKZyKi+QRvq
         13ZeTu5jHBqdS3I/iYUBeM0uUgDFZB1Ha0iXleS8duBBZiiv1JNSZVsNcnWvSPg3zlHX
         Qwm5UZMWh7/+AgO6Ut8uhtjDTZ3dFBuxpeOPov5SvOPKF2sFcveJAxeDboJrUpSaEv1l
         BWaswPR+Rth3WqYF1TqWKnKDJPjvQ0JEoJOEIyd/vP7iMQp3ndN9ARCdL++FZq7MErIu
         CAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=+WdGFG38vchf7zqZcP+XZNT8zPzw6L2Kr3ch5yLPtTE=;
        b=fCUFRJCkqCG9IQFMZIxLekzv/w7qNwZwc9kFPX8enernQ2AJ4rsbafyg09Jmzn9cin
         AaBSL4qS6TB9qf/NdvaXeLaEvdMRsl2pj92DWwGQngqZWCEQsTAxzWG9AB5bqwvMQS4y
         8yPjdSx8AZKvBUkXKfY07oiszh1WQJeEyB2/cnIFKXiyL2wnrACGK2gRnncA78bd+uZ9
         G1XNf7JkmDOX5QtAL15tXHsAF662jeuimKRVkeIsCnyEMihGEntOc11EyQxrN/vCafcr
         533MLRh/Te5ieTZRQnnBQoWSm7rLLnuGLmUT61NssqI5+aSyYt4RkK8mUyjPqtj0orFd
         oY2A==
X-Gm-Message-State: AGi0PuZZ50VyjpBN/ufBb8HkShH63wup8jcw2uUiLIwlBa1wJIMLCAV9
        NJox9avLikcoSGNfxZ5+ZbR3L7o+
X-Google-Smtp-Source: APiQypKnsnzUBQXKspxGjVN6g5kYDYXKzvdhAJB7OVxAgD+2fDrjbVmjpTLzUdZqTVt1xSEhUUBbJQ==
X-Received: by 2002:a1c:f012:: with SMTP id a18mr29504032wmb.116.1589196780349;
        Mon, 11 May 2020 04:33:00 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id u12sm27830595wmu.25.2020.05.11.04.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:32:59 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 11/11] habanalabs: enable gaudi code in driver
Date:   Mon, 11 May 2020 14:32:32 +0300
Message-Id: <20200511113232.5771-12-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511113232.5771-1-oded.gabbay@gmail.com>
References: <20200511113232.5771-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the GAUDI ASIC code in the pci probe callback of the driver so the
driver will handle GAUDI ASICs.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c         | 4 ++++
 drivers/misc/habanalabs/habanalabs_drv.c | 5 -----
 drivers/misc/habanalabs/sysfs.c          | 3 +++
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 7ce4540648cf..4b6c8de46dd8 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -256,6 +256,10 @@ static int device_early_init(struct hl_device *hdev)
 		goya_set_asic_funcs(hdev);
 		strlcpy(hdev->asic_name, "GOYA", sizeof(hdev->asic_name));
 		break;
+	case ASIC_GAUDI:
+		gaudi_set_asic_funcs(hdev);
+		sprintf(hdev->asic_name, "GAUDI");
+		break;
 	default:
 		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
 			hdev->asic_type);
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 9d009b50aa0d..8652c7e5d7f1 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -276,11 +276,6 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 			dev_err(&pdev->dev, "Unsupported ASIC\n");
 			rc = -ENODEV;
 			goto free_hdev;
-		} else if (hdev->asic_type == ASIC_GAUDI) {
-			dev_err(&pdev->dev,
-				"GAUDI is not supported by the current kernel\n");
-			rc = -ENODEV;
-			goto free_hdev;
 		}
 	} else {
 		hdev->asic_type = asic_type;
diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
index 36f4f68c8cef..e4454414d0e1 100644
--- a/drivers/misc/habanalabs/sysfs.c
+++ b/drivers/misc/habanalabs/sysfs.c
@@ -224,6 +224,9 @@ static ssize_t device_type_show(struct device *dev,
 	case ASIC_GOYA:
 		str = "GOYA";
 		break;
+	case ASIC_GAUDI:
+		str = "GAUDI";
+		break;
 	default:
 		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
 				hdev->asic_type);
-- 
2.17.1

