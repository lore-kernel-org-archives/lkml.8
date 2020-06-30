Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DD4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72FB12073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v3MS5Ulp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbgF3HF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbgF3HF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:05:57 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADF2C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:05:56 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 94so13508838qtb.21
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hQbCC2Qtr4ZiCu8Gyf8ZErDlr2Im7SfT6dGGEw7uc9s=;
        b=v3MS5UlpyyIOGIgiRkyrMu89BT/RmNLmfvCiTy3zQfQL5chxlg4UNWuuPqWEdHsVkP
         h+MFK3DHpk2T0r7qjo/Y8tef+6qHC3Zrz3maD/Ls2G/URaqS0e65WoGof7TkOTZpouyY
         HGc5oey1D1jZTZ8Z7Bfmw7wBPdPdrLdbq5JmCNIim1n7BFDBG7wcLl9JHtpS+Xv43SRT
         WP1xr3TkS3H3hdQdmzNdarusxOd/r4VUcGckXxvYJ1PeZ2bAa+rLniX36Yu9kg2R1pEO
         qw0q+roZW3oKRI4UvWTNunmMojxDVwo9vU70LYaVgPd6OfsDl8TBAYj3mCjUeOmFafxR
         wiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hQbCC2Qtr4ZiCu8Gyf8ZErDlr2Im7SfT6dGGEw7uc9s=;
        b=Y6xomnolkPVsYc9hrzf9ySq5h/b52K0ipttXLkdjlI1PaU7uo7JD+FJd8R+vTeGijp
         L8Jg8S1umX/WGFd7kUTCoz3DoSpkSfZVhAX5mi+YcsVRPB1Q9Y0P3aTKfgrf3MzfbsLa
         pDcjW7dqxuiB8pG4ujfrf6GsIkLpccC81/URzvzB2wjXsZI1ZE4z8ygbU1Ju+TrwXTvJ
         45C541HUvNCTqK3YyhV/iwrmZ9MUPMWOofL1zmCfJFPnK8CscoJwTchQT1/9DmaPCzS7
         c2tNrUzhCN8CTUwcs4LiAYAkP7gJQcrAhkN1k5uf552vJuaoXDSeluOMdDz7RwYOkywm
         H0Fg==
X-Gm-Message-State: AOAM5318O/pPbYAIo0a8kdGvbel3LByoM9Am7zrmFCh7BsgJvwb/JFUx
        aH6xZxzhq7zdA3osPcu857fZ0F00SqK+og==
X-Google-Smtp-Source: ABdhPJwN7uykbB/bDW1h89wzKPqw2CED5tJDZtdxDVSbRv8kD4qujFvyuDzeIzBDwuH35ErSNiRk9MyWZPBwbg==
X-Received: by 2002:ad4:5042:: with SMTP id m2mr8029298qvq.225.1593500755983;
 Tue, 30 Jun 2020 00:05:55 -0700 (PDT)
Date:   Tue, 30 Jun 2020 00:05:52 -0700
Message-Id: <20200630070552.1110864-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH] iio: adc: Specify IOMEM dependency for adi-axi-adc driver
From:   David Gow <davidgow@google.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Analog Devices AXI ADC driver uses the devm_ioremap_resource
function, but does not specify a dependency on IOMEM in Kconfig. This
causes a build failure on architectures without IOMEM, for example, UML
(notably with make allyesconfig).

Fix this by making CONFIG_ADI_AXI_ADC depend on CONFIG_IOMEM.

Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index ff3569635ce0..f5009b61b80c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -263,6 +263,7 @@ config AD9467
 
 config ADI_AXI_ADC
 	tristate "Analog Devices Generic AXI ADC IP core driver"
+	depends on IOMEM
 	select IIO_BUFFER
 	select IIO_BUFFER_HW_CONSUMER
 	select IIO_BUFFER_DMAENGINE
-- 
2.27.0.212.ge8ba1cc988-goog

