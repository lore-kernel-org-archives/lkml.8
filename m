Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF49EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFD11206F6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kS6kSvUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgHCXmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbgHCXmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:42:09 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0599FC061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:42:09 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id j8so28009907ioe.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/skwDGOu2nehnv18qT3IFvoLq0QiOWOte/D4orwDVqQ=;
        b=kS6kSvUWuhPB6rHlgXKENziRqn8Xb+cvstktJgAj55sFgsPTsKaaID8UgizpA2plTv
         2HSTbhdM+R7emETz84X8vU5jWlVsPQ6VrJ9oUFW65kKuNdmfi8UNLYXzxtSUWTmuWtBw
         EQPNO84AVaBO6qoCPs0USYGXM0iRCMi50JM0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/skwDGOu2nehnv18qT3IFvoLq0QiOWOte/D4orwDVqQ=;
        b=Lomf4pvMT8cteXJGEB61aOCW7zP07Os3bFwKdlMQEdncG1LYjdw+zdhXh6EcS2h0t6
         7aiShP2g2k1BzZZ7SMSJYdBNMO75S3OlRnUnC/bmtQZ7o4sj3RLVFwCbcyaMTSC+Xv5L
         ytCwiXhk7hz/1JAydHuywEP5IM/o8OB/HzFxi+VcSSlIP5+LvNOp5NhLUiQy/HHPi1iL
         rs82pdbLiCEwk/4ajLm3LrMNnNEDJBXZEkmP4rSzboEC5ymwvDn+EHz3w18GNsr8s8Eu
         WiGuz+i/pvOFaJyuPzP8yZXMEjQFojWna0Y5y0icO3SUMe+gKLOOPaHf6AoH1sBMWRfw
         Hrzw==
X-Gm-Message-State: AOAM532zPsarE3KEIJzfFM1PSNk4YEWqytgvjGVBP/JdplbmEu5eSHPT
        RiQc1Mk4dUrDrxNTU/SawJbrcw==
X-Google-Smtp-Source: ABdhPJyyzjip/hI2kd2WW3oXWVJy1Fk6QaKzYFBTkNRk51qp4ji3wfF3zEwqRMQEYDGmU+zdqbsziQ==
X-Received: by 2002:a02:cc53:: with SMTP id i19mr2551216jaq.33.1596498128403;
        Mon, 03 Aug 2020 16:42:08 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id g2sm5468435ioe.4.2020.08.03.16.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:42:08 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH v4 09/15] iio: sx9310: Update copyright
Date:   Mon,  3 Aug 2020 17:41:48 -0600
Message-Id: <20200803131544.v4.9.If88afce92bbc1e97a532874cca35e642a9566172@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803234154.320400-1-campello@chromium.org>
References: <20200803234154.320400-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes wrong copyright year.

Signed-off-by: Daniel Campello <campello@chromium.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/iio/proximity/sx9310.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 9636a3beabeb36..fa5009e39605ca 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -1,13 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2018 Google LLC.
+ * Copyright 2020 Google LLC.
  *
  * Driver for Semtech's SX9310/SX9311 capacitive proximity/button solution.
  * Based on SX9500 driver and Semtech driver using the input framework
  * <https://my.syncplicity.com/share/teouwsim8niiaud/
  *          linux-driver-SX9310_NoSmartHSensing>.
- * Reworked April 2019 by Evan Green <evgreen@chromium.org>
- * and January 2020 by Daniel Campello <campello@chromium.org>
+ * Reworked in April 2019 by Evan Green <evgreen@chromium.org>
+ * and in January 2020 by Daniel Campello <campello@chromium.org>.
  */
 
 #include <linux/acpi.h>
-- 
2.28.0.163.g6104cc2f0b6-goog

