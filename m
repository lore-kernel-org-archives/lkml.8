Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ABEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F16206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoWk5+P4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387789AbgF2Uqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731543AbgF2TNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:52 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666C2C0A8936;
        Mon, 29 Jun 2020 00:37:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b184so1127823pfa.6;
        Mon, 29 Jun 2020 00:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M1eWlmJknPlaq4iBEb26E6JSPq8jyG2XC9mR0Df08JE=;
        b=ZoWk5+P4rjcM0P7NJzK7080uXsU6qIIS3avQ6XYyaJJKtaWZpbT29DeSJXZg5qoR7M
         7CBFX08H84xXbjEGQVj6g57MZ8Cv8uyNbXonrVuHNLgqF46jAdpvi8ocxy8GjNWjC4C3
         +3LmIIy6TrhWf7m4KllNP6crK/ELeX+2vuDlJ6p25HiG2GP1/1jN7IIqnxQNMeQJmdT4
         rK6u/59MNeUV7ciVPBV5i83zSsn3/dv35xyVBBysuH/83LhOfG9qZjpZbpoAw28Gd9c4
         dIvKeEOEaOcc3dE7y8kaqkdzAAFVsqgbX4fAUTWcXu5rX3K4YkPkqmFwx9x8iA+yXOD4
         uvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M1eWlmJknPlaq4iBEb26E6JSPq8jyG2XC9mR0Df08JE=;
        b=kmO/NnxZvTjBFJS+hKlLmmguUALrAi+OY9em7n5DFXRLhx4I9WqYBVZcBDCKBvp6ZA
         gslv3IqoUTmNmE0SW34OxtMW2CMOfTtRzlNWH5aRI/AiuLvqHCI5BvWLqZzMncgz8ist
         hQ5WJVli7uP+YVOLFpkeD4L0pl6XfY8J1EjXBYMXVycOTGIRu57r1rbK/c1tvOOWE13n
         pxeW/mwCh2Rebi29hSiXXOC3u1gL/dayy6NxUySsDcN9cr8GCW9qjJKfSVJ5mmSI11ct
         hfam/LC7T4/b8SJMha0H2s4u00o888Nk0CEcnUgXgWrz7fqCr63W+/RpMjQqK9UXfxu9
         139Q==
X-Gm-Message-State: AOAM5300lAfpI9/RXlK5gsITuF9WE+kIZ8/N3MZ/4z1WFVimfQ/KUmBs
        PPhLHi0HL79Qh/nex37PlLQ=
X-Google-Smtp-Source: ABdhPJydYwb6IghBaB9/JJLG0sM0hcusmh3mXrqhfkRKFx43w7QdBeZoPsQYEN6Kw++x7HYyl1rBYw==
X-Received: by 2002:a63:5c55:: with SMTP id n21mr8836754pgm.27.1593416253909;
        Mon, 29 Jun 2020 00:37:33 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.57])
        by smtp.gmail.com with ESMTPSA id q10sm34673004pfk.86.2020.06.29.00.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 00:37:33 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v1 3/6] [media] cx25821: use generic power management
Date:   Mon, 29 Jun 2020 13:06:01 +0530
Message-Id: <20200629073604.205478-4-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629073604.205478-1-vaibhavgupta40@gmail.com>
References: <20200629073604.205478-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .suspend() and .resume() callbacks are not defined for this driver.
Still, their power managemgement stucture can be easily upgraded to
gemeric, without affecting its normal behaviour.

Hence, define them NULL and use struct dev_pm_ops type to bind them.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/media/pci/cx25821/cx25821-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/cx25821/cx25821-core.c b/drivers/media/pci/cx25821/cx25821-core.c
index 41be22ce66f3..59501939d741 100644
--- a/drivers/media/pci/cx25821/cx25821-core.c
+++ b/drivers/media/pci/cx25821/cx25821-core.c
@@ -1369,14 +1369,18 @@ static const struct pci_device_id cx25821_pci_tbl[] = {
 
 MODULE_DEVICE_TABLE(pci, cx25821_pci_tbl);
 
+#define cx25821_suspend NULL
+#define cx25821_resume NULL
+
+static SIMPLE_DEV_PM_OPS(cx25821_pm_ops, cx25821_suspend, cx25821_resume);
+
 static struct pci_driver cx25821_pci_driver = {
 	.name = "cx25821",
 	.id_table = cx25821_pci_tbl,
 	.probe = cx25821_initdev,
 	.remove = cx25821_finidev,
 	/* TODO */
-	.suspend = NULL,
-	.resume = NULL,
+	.driver.pm = &cx25821_pm_ops,
 };
 
 static int __init cx25821_init(void)
-- 
2.27.0

