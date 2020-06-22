Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EAEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C9B3206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgX4gjHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgFVMNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgFVMM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:12:59 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC729C061794;
        Mon, 22 Jun 2020 05:12:59 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id q22so5211004pgk.2;
        Mon, 22 Jun 2020 05:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I9HlSKQMhzG7oJydL+6eh0up9y5VwqFmL94sToYa/uE=;
        b=lgX4gjHFucnFy5VkHP2WiY0D6XIEbcexKj1KxqJvBC+wiYLIl3kjnY5OiQ1lFBiGEL
         SZV3TvRi8AXTgDSbP1PcCEh22JfsRDXasJvLF7aUyb7UGHlKr6q4SKwLdt7gO2Ll0svi
         Bual2eB0y3TvXX0L8+Vg1km1WXhTjaeetYw4dJrSAxVa566HGLht8BDas3Ilc1JSmuuI
         gzEiuavSKzSdNavT5PNXwQ65afsFpTlWu2jiv8+hIA7cZiZyJvN7pJXOmJUixy8B14up
         y0yBURG+HoEUapcIxVxqS7s0AykmtYzDFVTMtMpkQuUleUQWWnyfZhPNvzcD/IzbyvId
         gHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I9HlSKQMhzG7oJydL+6eh0up9y5VwqFmL94sToYa/uE=;
        b=LrHFKYfjXX61CHs5r9LpNUMCDZ3Nzf/nUXtAHa/mR/kaNi6BsgWPoRYzv+nFPD26/A
         fQaWH7276vDYSIr0rjnkkv2Lv0zVvFRsjTKKDkoGTjCtLdwarfaTgTkywdlrLLxz1poA
         506XgY1k00ZOzpkav1M/v3POnx58PFA1MCkJHyjJoC8QKnpKU2M98l7A8RThLLA/9bg/
         p+a9ETSIXAMLel8Wr65XxvwSp5tAuJfvg0OML4ZV4zD8MUK4ZF7reh1jCS5rTvI1elmB
         2ZSbRfaFQcoeuSA0DMAkGnIZxa3MHh9+B9LRL8EJeTfqdEdXbycAs0AfMdVxfREvNKAC
         nD/g==
X-Gm-Message-State: AOAM532dZzAS2Vxaq8ImtyVelWh6prJWWkORK5/9t4cwXpITjvWc1Yid
        MHt33mJC4f01OX2W5q82kAE=
X-Google-Smtp-Source: ABdhPJzcIKdS55H6Lk+xBsA8lIrAY3wgHsUWpiZth/n3tyJfyRUSFfw91QigIsAGY65JwPVcXZx7Vw==
X-Received: by 2002:a62:ed02:: with SMTP id u2mr19752810pfh.283.1592827979227;
        Mon, 22 Jun 2020 05:12:59 -0700 (PDT)
Received: from varodek.localdomain ([2401:4900:b8b:123e:d7ae:5602:b3d:9c0])
        by smtp.gmail.com with ESMTPSA id z9sm6745565pgh.94.2020.06.22.05.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 05:12:58 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] [media] saa7164: use dev_pm_ops structure for power management
Date:   Mon, 22 Jun 2020 17:39:13 +0530
Message-Id: <20200622120912.92392-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .suspend() and .resume() callbacks are not defined for this driver.
Still, their power managemgement stucture can be easily upgraded to
gemeric, without affecting its normal behaviour.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/media/pci/saa7164/saa7164-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/saa7164/saa7164-core.c b/drivers/media/pci/saa7164/saa7164-core.c
index 126d085be9a7..dba537c11797 100644
--- a/drivers/media/pci/saa7164/saa7164-core.c
+++ b/drivers/media/pci/saa7164/saa7164-core.c
@@ -1534,14 +1534,18 @@ static const struct pci_device_id saa7164_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, saa7164_pci_tbl);
 
+#define saa7164_suspend NULL
+#define saa7164_resume NULL
+
+static SIMPLE_DEV_PM_OPS(saa7164_pm_ops, saa7164_suspend, saa7164_resume);
+
 static struct pci_driver saa7164_pci_driver = {
 	.name     = "saa7164",
 	.id_table = saa7164_pci_tbl,
 	.probe    = saa7164_initdev,
 	.remove   = saa7164_finidev,
 	/* TODO */
-	.suspend  = NULL,
-	.resume   = NULL,
+	.driver.pm = &saa7164_pm_ops,
 };
 
 static int __init saa7164_init(void)
-- 
2.27.0

