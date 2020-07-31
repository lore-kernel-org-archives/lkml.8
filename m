Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FB0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7826421744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C+UdcSQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387491AbgGaQtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733273AbgGaQtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:49:11 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DCFC0617AB
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:49:11 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g19so20212077ioh.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNO8JDVb/SFk+MZRQqz5iQK8yjAhcQOAAqpSPIcW0Ic=;
        b=C+UdcSQ0iy59AKiSH7cnKdOWjWflQPoNxLtMMYkz74eaK+aBTfCoFNCUH/f1m1HoY6
         r+Jgcgg29/0TPKYe3rZJiTqbMrWU1H0MJn/wsYZX2PrjVP1dv/XokPV0BfD5Z56Ub8qk
         mzgQmXKBCWymJwXPDZJFs0upDNEoaulOSUfPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNO8JDVb/SFk+MZRQqz5iQK8yjAhcQOAAqpSPIcW0Ic=;
        b=VWBP+kmcwC3ZiMmo+mMXBTHFOQWK+Y+LVGsZizlr4NGdKTnd/8Uc16gakiEcYH6FkM
         NEWk1P7WH0w0vGFaVwdFQXS/TRc0BDDs4msP0FM/U2ZSLcs6LoSTO3l49q9EgUUGIybK
         DvASaFrdlwex3oiTiwj0Qv8TWo2AS8vR4OTsVApkpOlF8cTIOFz21z0AgGc1XW61vRw9
         RSs5XssFdFR1aGfIlGHshq8PFueDdxiQ/asyoi+XW3/UwvNLm381L07Z8kmvIbfJhYYv
         pqM+dwK7vylgUk3Vt47uOotjj01FKx27Bs3oBHth++z3aEUGHlvJrYfYvI8FssSMDzkG
         GMtw==
X-Gm-Message-State: AOAM531D7cfQqfy3gfEbqC1Q4MNXgrfbUo5GhYndpM8xl0edfBe+98Qg
        cnZrc1rpWlP8s1OD/0vES9UxNw==
X-Google-Smtp-Source: ABdhPJyDHx/DoVZfetBIrsHM9jFPgEOZ4dOXkmAYl7/UibvQxkW79QxjrjhXFar/WE+tm5T1r0xFJQ==
X-Received: by 2002:a05:6602:1587:: with SMTP id e7mr4442835iow.203.1596214150868;
        Fri, 31 Jul 2020 09:49:10 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id e84sm5122083ill.60.2020.07.31.09.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:49:10 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 13/15] iio: sx9310: Drop channel_users[]
Date:   Fri, 31 Jul 2020 10:48:50 -0600
Message-Id: <20200731104555.v3.13.Ia5c5fdbdfff576ab5d034cde46c25cc66a4baf50@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200731164853.3020946-1-campello@chromium.org>
References: <20200731164853.3020946-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

This struct member isn't used. Drop it.

Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Daniel Campello <campello@chromium.org>
Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v3: None
Changes in v2: None

 drivers/iio/proximity/sx9310.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 886fcbd52703c5..aa21f6f1a58e3c 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -136,7 +136,6 @@ struct sx9310_data {
 	struct completion completion;
 	unsigned long chan_read;
 	unsigned long chan_event;
-	int channel_users[SX9310_NUM_CHANNELS];
 	unsigned int whoami;
 };
 
-- 
2.28.0.163.g6104cc2f0b6-goog

