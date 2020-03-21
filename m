Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8D7C4332E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 09:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8B520739
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 09:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0+w9r+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgCUJBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:01:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43221 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbgCUJBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 05:01:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id b2so10200801wrj.10
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 02:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YohStPVsw3Erx7ZEmjh2wgjlDgrcVBxuvPTzUFp9k2g=;
        b=G0+w9r+8OCERU4wGlgdAv6EGMbik8XmmeW4mbc+DnLjCsSm69HM29Cj8ucvm/dzJZu
         3cjtzhedeWCcuGQur5yyutIfAEC9dNUpGDeFDxRlc+6E/Yw++wACd+534kOYYlAGaEMU
         H1wyKoyCvsg8KyNXN2tHUw7FLkiZgFxT+XjKS0hbWb85h1XztfddQ3JbpjrkA2crvyAV
         hTytSaqSLGBjIQnNO0pdGkcgF5ZFe3a01UY3bWydMoT+Fv7dWYDsOhsiIPvAsy7TaPlZ
         uKz9RTAnjNhVq/U+vFxXMpUnznShO2Kx6ONyTUGfBbX1yBdVrj6QmLp2Uppc8LAa28Yl
         uKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YohStPVsw3Erx7ZEmjh2wgjlDgrcVBxuvPTzUFp9k2g=;
        b=e/iU2kJ9zuulLJkQ5lxosfVRYR/cS+BTi1Zw9ud926YWJcxuTpeDInvQ/h6Fw/cKQn
         sVNmAH1nQoOy0nJOlu19pnKHou1YJx9TvG2/SOK1FaDNUG/W+qIvTt3ikjVc6PiNz1Xw
         RxDpTdhCDL+8T3BBc0HyJBwSvJYBqGXRPP9uEXsZDpQx9mlMgobSRK0rA+PY0uOgK1Uf
         NoxEHo6AJIg5Ot0v/9/XQb84p4EonSjCRcKQJC4HY2f4QJagCSESG80e5DcMTk83NF8Z
         rtYrYmy5IdnYn69zn7k62adozBWNynS5q2CCAeTPiDKHQYp7k0ladANkr5c5TZxvDCQj
         kztw==
X-Gm-Message-State: ANhLgQ3DQ7jqfEnaYKurFBMdmGg2mJqtAhKDmEAvubw9wrUgqvWY0db9
        ETe+6p51E/KURzXod79Z1/ZwMC9B
X-Google-Smtp-Source: ADFU+vs8cWgvAHUISxwDdbvsD9+XZHHmWwA4TEE2qcDc4yPwL4Roild1fd7EP5kuHixrFj6JVypIbQ==
X-Received: by 2002:adf:bb45:: with SMTP id x5mr14907079wrg.388.1584781262770;
        Sat, 21 Mar 2020 02:01:02 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c7sm1825421wrn.49.2020.03.21.02.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:01:01 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: show unsupported message for GAUDI
Date:   Sat, 21 Mar 2020 11:00:59 +0200
Message-Id: <20200321090059.21960-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a GAUDI device is present in the system, display an error message that
it is not supported by the current kernel.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs.h     |  4 +++-
 drivers/misc/habanalabs/habanalabs_drv.c | 11 ++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 9472da3ef847..31ebcf9458fe 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -424,10 +424,12 @@ struct hl_eq {
  * enum hl_asic_type - supported ASIC types.
  * @ASIC_INVALID: Invalid ASIC type.
  * @ASIC_GOYA: Goya device.
+ * @ASIC_GAUDI: Gaudi device.
  */
 enum hl_asic_type {
 	ASIC_INVALID,
-	ASIC_GOYA
+	ASIC_GOYA,
+	ASIC_GAUDI
 };
 
 struct hl_cs_parser;
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 8c342fb499ca..b670859c677a 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -40,12 +40,13 @@ MODULE_PARM_DESC(reset_on_lockup,
 #define PCI_VENDOR_ID_HABANALABS	0x1da3
 
 #define PCI_IDS_GOYA			0x0001
+#define PCI_IDS_GAUDI			0x1000
 
 static const struct pci_device_id ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HABANALABS, PCI_IDS_GOYA), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HABANALABS, PCI_IDS_GAUDI), },
 	{ 0, }
 };
-MODULE_DEVICE_TABLE(pci, ids);
 
 /*
  * get_asic_type - translate device id to asic type
@@ -63,6 +64,9 @@ static enum hl_asic_type get_asic_type(u16 device)
 	case PCI_IDS_GOYA:
 		asic_type = ASIC_GOYA;
 		break;
+	case PCI_IDS_GAUDI:
+		asic_type = ASIC_GAUDI;
+		break;
 	default:
 		asic_type = ASIC_INVALID;
 		break;
@@ -263,6 +267,11 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 			dev_err(&pdev->dev, "Unsupported ASIC\n");
 			rc = -ENODEV;
 			goto free_hdev;
+		} else if (hdev->asic_type == ASIC_GAUDI) {
+			dev_err(&pdev->dev,
+				"GAUDI is not supported by the current kernel\n");
+			rc = -ENODEV;
+			goto free_hdev;
 		}
 	} else {
 		hdev->asic_type = asic_type;
-- 
2.17.1

