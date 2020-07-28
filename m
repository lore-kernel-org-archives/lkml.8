Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32857C433FB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 23:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C80207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 23:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FEh+/Fwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgG1XFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730125AbgG1XFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 19:05:49 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2964C0619D9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 16:05:47 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p16so6944737ile.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 16:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AM59jIQYU2CvWOeFM3ngOpDG1QHH1+7BTtSJzp1GFow=;
        b=FEh+/FwgUzqP+c5bzHLYHINr+d192UCaIZiMxxT67ECRBXi+JBTwyim6DMlrKBPLdM
         zyC8o+DppB6BHO2L4XRveDASnVzPOsbTxgLMwbhEHigBwLC0H1tvUJ+wNlRxLkBa4Ctw
         SmMveWRwhdCahFGFdsifE4Eqse1/dkEAvyq1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AM59jIQYU2CvWOeFM3ngOpDG1QHH1+7BTtSJzp1GFow=;
        b=b6+8PPNrZ44Xl6JalFbOHNDgN8+CTAqgrcU4RfqXmRch8V8FUuOfPYN7YA4nCUhfcD
         vhHdRfrtBEVBtrAJM3Xm/2t9O5cByZqxtD6fyORwQo8DgE/q7fztZ/lwQHS1jWfkoUWm
         Qwo/moWwxxHSQLinzjiGDnFofpkLsnR+F+R9MVVOZraIbWazUPxHIvZnaf1/MVyXf7VG
         Qo0Eb+in/hAGWsXeI3A/S63epxJF5CaTTy3jxxa+tFgQmngg4eXH2Jj/uBhtipZFzFbM
         F1cubY/+eLU5F3df6l56LvUz5hEjwadE/xmzZMr2p5/j9nKi96PcQhxqbPV7GJlNgexd
         3m1A==
X-Gm-Message-State: AOAM531aK4sAZAO0/Rn7hyNKzIsEMon8Fv+9qA/uLGjI99kDyk43vVUE
        pZKUYDBYUg8Y8yWzMTseoiHHpA==
X-Google-Smtp-Source: ABdhPJxvRCgWq7gqc0hnPFB/W3nKDK5a7ATpFyEVwGjnraxwV/R33ljGYEyoojjknLpWN3J8FIqn9w==
X-Received: by 2002:a92:89c9:: with SMTP id w70mr23431764ilk.250.1595977547204;
        Tue, 28 Jul 2020 16:05:47 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id w10sm148945ilo.10.2020.07.28.16.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 16:05:46 -0700 (PDT)
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
Subject: [PATCH v2 13/14] iio: sx9310: Drop channel_users[]
Date:   Tue, 28 Jul 2020 17:05:19 -0600
Message-Id: <20200728170317.v2.13.Ia5c5fdbdfff576ab5d034cde46c25cc66a4baf50@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200728230520.2011240-1-campello@chromium.org>
References: <20200728151258.1222876-1-campello@chromium.org>
 <20200728230520.2011240-1-campello@chromium.org>
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

Changes in v2: None

 drivers/iio/proximity/sx9310.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index b15ace422862ff..6607732edd034a 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -132,7 +132,6 @@ struct sx9310_data {
 	struct completion completion;
 	unsigned long chan_read;
 	unsigned long chan_event;
-	int channel_users[SX9310_NUM_CHANNELS];
 	unsigned int whoami;
 };
 
-- 
2.28.0.163.g6104cc2f0b6-goog

