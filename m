Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E799C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D463D20702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izizXlau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBEPy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:54:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44185 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgBEPyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:54:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id g3so1149352pgs.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=38D5H6zWkyahyYYe28XDPgybiJeKYqOpfDcJIda7PSg=;
        b=izizXlauswXltkNcK1UGa/0OKwNkbo9wHpPZu8kEbejQ358/pdXHPJliIcDrfpi/mX
         GtfLUwCEBa/8YsmiDtivLpFie/ZIGYzhG0ohD412C9ymXZYcWmpCwGn8kGJoRp+2VvUU
         dlqMgTK+XE3tLnIt+4BE43qL+KO5SwZoBoWimGmQyoVHKd4LSlrT+72+6PLPnsBu6UE7
         +sv8HKG2GC4JKBQvyyI22pZ/SkPtQcOe+mJ29pKyBG4J0ecLwC2LXvRJgoPW44Dk+4VZ
         ghwjdjKAxaCG7wISY6uFeQMaQlPJdBIuYJLhDTrLGY1zHshe/YRkFiOAapPyATosLEA6
         g6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=38D5H6zWkyahyYYe28XDPgybiJeKYqOpfDcJIda7PSg=;
        b=IQjM7MVqHs67c8Rrb36GvzrNvWXF5YQd9AEtMH93R9ONwQWsXIGRhNgzjF1z/LcATQ
         KNcKOmwH3mZ6QVgeMQAX2C07YQ2o7QQ+BIcZ40JBtL86z1j26DZh5n26pXB023CXdimI
         v+8YA6fj2gP3vyig1D22X5SzvmsYW4x7mgaJ2Tnsj4ci7sVCgBr6YG6IHLpUcXNoQIML
         0msQyc5OWJmnay4JfnCLFOA7hYiK77se3BkMl2ZSwGkRBoJObET0ESzi4v9gF17AT1Un
         BtVYBcx/a2ePxbfTec70nLVlrJwFfp0GN6ePdMMs5AvCCb9vGGeuCBbP49Gj+hpPVcc6
         VmNg==
X-Gm-Message-State: APjAAAWBslBNy4YuxFrVwd5r8sECpNEhOm2qRkm/bxnlOqkOEbzuXHJw
        VSWSUouZUt+RIq28YRTGdRM=
X-Google-Smtp-Source: APXvYqxTsa+Nf87QhcfbdobkQztkFH/ybrIoFW6R15heN9AC41Je5RkUGDhg8TdkcEZVGAzNysXY0Q==
X-Received: by 2002:a63:a411:: with SMTP id c17mr2034288pgf.450.1580918094540;
        Wed, 05 Feb 2020 07:54:54 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id z10sm195678pgz.88.2020.02.05.07.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:54:54 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 02/15] NTB: clear interrupt status register
Date:   Wed,  5 Feb 2020 21:24:19 +0530
Message-Id: <92dbbe6f9b6a54a2169207dbff10e1dfa6f9d3b5.1580914232.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt status register should be cleared
by driver once the particular event is handled.
The patch fixes this.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 9a60f34a37c2..150e4db11485 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -550,6 +550,9 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 		dev_info(dev, "event status = 0x%x.\n", status);
 		break;
 	}
+
+	/* Clear the interrupt status */
+	writel(status, mmio + AMD_INTSTAT_OFFSET);
 }
 
 static irqreturn_t ndev_interrupt(struct amd_ntb_dev *ndev, int vec)
-- 
2.17.1

