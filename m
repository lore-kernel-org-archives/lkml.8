Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716A8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F6FE20786
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eSayUOKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgHCX6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729330AbgHCX6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:58:33 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DB2C06179F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:58:32 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id z3so22456887ilh.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x0P/E9wXylBxFlPI7ObeCRrwNQSFwwnsYpwWvOTzQ68=;
        b=eSayUOKpyEjuoEmY3FnaGAEswN75bWwb5+F7SMrAWkZ4ha1ysyywWEcqob0Jq8u4e/
         vp1UiA+/Ag/Xdak6ETpDNXInq4wKTY2b/f0oFFVPFzmOPDb2MRkcwWwRAiVAqAZfrYCG
         SprKOXNwm4GR0usF7zFS3ihJV85lK/xx2ZQn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x0P/E9wXylBxFlPI7ObeCRrwNQSFwwnsYpwWvOTzQ68=;
        b=gTsiRpQqyf9gKLmN+osZa+hcbWh7+8USla0yBa5KPyE+AmYY+RSCm+kWSB0DpKLGIg
         fB0vy8d6tSiHs9YLFAZCFSzg4qUmYEmM1Qe4s4CJcw84Qd5i2h78Cr3jjPJ83lmoESBH
         wpavsp5UVDRAam5Xo5G3NG1zlM4CGOhTI5VlL4vzUg+Exko1+SM7/gXY0ZpT2tsSgH2I
         VTbmMFXK7pPzeVTzustKMXwbvcBhUQRst0raIgNJyCx4mYfF78l8VjupqpvY77ijpuAX
         0gNgqri+gQYkQkQdV5Mqaz4O8a6WVUZ5WFOXsbp0Xxl/eLlsO7K6ksA05H622l67FjnL
         jMuA==
X-Gm-Message-State: AOAM533ClOLArwuatBcDDM71iaMk9UbLoHirAGs2/e4VbUP233yJkxmQ
        vazJpoPH4qRFPI7AhzcZwxXllQ==
X-Google-Smtp-Source: ABdhPJwMKIXrHNHaa3lv/hs5sbyt3ZtWIIJHJ0trFy+WjiQjbGJuBfzF8Q21t0XkkrvoJjKSmkEoxA==
X-Received: by 2002:a05:6e02:52a:: with SMTP id h10mr2106475ils.259.1596499112322;
        Mon, 03 Aug 2020 16:58:32 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id x185sm11075992iof.41.2020.08.03.16.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:58:31 -0700 (PDT)
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
Subject: [PATCH v5 13/15] iio: sx9310: Drop channel_users[]
Date:   Mon,  3 Aug 2020 17:58:13 -0600
Message-Id: <20200803175559.v5.13.Ia5c5fdbdfff576ab5d034cde46c25cc66a4baf50@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803235815.778997-1-campello@chromium.org>
References: <20200803235815.778997-1-campello@chromium.org>
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

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/iio/proximity/sx9310.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index e92017b51c6def..60ca32885b664b 100644
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

