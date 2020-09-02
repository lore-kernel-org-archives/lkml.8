Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AD7C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A348F20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZHQCfge9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgIBXBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 19:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgIBXBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 19:01:08 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8A4C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 16:01:08 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mm21so513396pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 16:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rckbD9u1Jvs+TO4H1QTBgAqxZmJHaw52NI12SCf1ONE=;
        b=ZHQCfge9W0rq1an4zjkDijL2d94hOEcsp54D7D1XkAj+MpNlBj3TQqpLnSitIdXXv1
         hdS7rRtTpLagXWGJvssRy511yVf2YiGxvh3k6UnOGOr72OCURZmG9PDAxHiOkc3L/FaV
         cYE+BvmQntdfWGfxc3njqOhjaxw4yxOaPLZIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rckbD9u1Jvs+TO4H1QTBgAqxZmJHaw52NI12SCf1ONE=;
        b=MoqokPHa8AKmvrygADt8ZysWPr6E5NGMXkWOHILnSQH9yxPEluX4Usm3if5UvckBMS
         mlioGxnsNfPKyBtrMU6AEScvsBrkEQ8nnJHXQpMs70fwJlBLeST3kmMFgDg6Ykofmp/+
         Qf83gL4f8QKzY0QJtjYA4b8SQA34v6hQVk+ktKwCqEkbpFdHTOOJY9jZusm7Gz8lPSOy
         XRUDBFOAB4tdFq+FzPOfAy3GMjQZYODUMoPdpqOlqYWAVp3eV/q4qbF8NAwrUEv6LuJ3
         d8WkUhbtpOjBefw76zykER2Ib1q1rqpcx+pEKqH1kJv+voB2o8csW/irKji8S7k0D1SM
         kPuQ==
X-Gm-Message-State: AOAM531KQVE/KyfACbYBolrJLEsTovhIAch2fum6OokO/SqpW6oPf5ce
        Y9be8A4/RzyOtNS3qiXqCKIjA59GHLHGnA==
X-Google-Smtp-Source: ABdhPJyszZg/1OfgGHuppP5KPcJIiYoOULZVJ8PzQ7DlaVyEphP0+9pGBgoilk2OjPsVI+o7GUdnrA==
X-Received: by 2002:a17:90b:360a:: with SMTP id ml10mr44063pjb.198.1599087667564;
        Wed, 02 Sep 2020 16:01:07 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id z1sm419825pjn.34.2020.09.02.16.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 16:01:06 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: spi-nor: Prefer asynchronous probe
Date:   Wed,  2 Sep 2020 16:00:40 -0700
Message-Id: <20200902160002.1.I658d1c0db9adfeb9a59bc55e96a19e192c959e55@changeid>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my system the spi_nor_probe() took ~6 ms at bootup.  That's not a
lot, but every little bit adds up to a slow bootup.  While we can get
this out of the boot path by making it a module, there are times where
it is convenient (or even required) for this to be builtin the kernel.
Let's set that we prefer async probe so that we don't block other
drivers from probing while we are probing.

This is a tiny little change that is almost guaranteed to be safe for
anything that is able to run as a module, which SPI_NOR is.
Specifically modules are already probed asynchronously.  Also: since
other things in the system may have enabled asynchronous probe the
system may already be doing other things during our probe.

There is a small possibility that some other driver that was a client
of SPI_NOR didn't handle -EPROBE_DEFER and was relying on probe
ordering and only worked when the SPI_NOR and the SPI bus were
builtin.  In that case the other driver has a bug that's waiting to
hit and the other driver should be fixed.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mtd/spi-nor/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 65eff4ce6ab1..756da93f0f16 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3470,6 +3470,7 @@ static struct spi_mem_driver spi_nor_driver = {
 		.driver = {
 			.name = "spi-nor",
 			.of_match_table = spi_nor_of_table,
+			.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		},
 		.id_table = spi_nor_dev_ids,
 	},
-- 
2.28.0.402.g5ffc5be6b7-goog

