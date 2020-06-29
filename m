Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582FDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3594B20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbIxwA8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgF2Sws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgF2Swm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D98C02E2CF
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f139so16235430wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xnIhP+BLJCkXHxO9I8vb7t4ZYrl34I7GGa9NV7vqaQI=;
        b=PbIxwA8vy7vWwp3PD1xYvC/boLvJezju8OhuIn1WM5qPXlK2MdHIieYvhn934I/UGA
         OURRy4f4bR0e0ymv4gSsOjdvPt+GDIeqZW65pRyK3+1U3jg+H4I2SGTL5572ec1SsDNz
         N+VMvXp2ig6KCBI/kKZM7CZ0OLIimgEUoYBfBhg8GeUjawTAJC3doOiPq6oJOzVJ/12U
         dMXCjVQc6LifoAl9uBJ8pFrHlHAMFF5aB10GKWdxKort9tIty0y2pSIcGpIivF9NIPmn
         nOQycVd1S4Orevvtr0YBONdbpszrq0tUfl6hfN8a9UI2cpYPDvBQcA+vULw12+lFAIZP
         5OxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xnIhP+BLJCkXHxO9I8vb7t4ZYrl34I7GGa9NV7vqaQI=;
        b=rjXebj7YDA5D04dB5LbZeHHIqKJOwzmD3MsED9R4urdTdb6e5aW6fscN/2+UMsUkcf
         1R6MRF4WZxcasuNJG9am8bUWjaKX9czySLRtYi1zsZ2AJqY2dB9vtwSmjdndaEzoEvYa
         teTBy5UzzZYR9LZZ97YjGu2zvg3t2Yx0jJKy0F35JFZQJsHa/afzMyzNf8+B6qJ8PQPs
         GLJKiDN3pdt0igRu6dpYfermhxV98M2LK4bnTraH5w45ZlDYs1q2QcbM0KUPd6tBVX7+
         Xdpp9AmQVzblbSu0HOefthU/jb2yCV09CZYORxCsrbiZD/XeY/l2c7tEI7S5+gRDUpyT
         GZoQ==
X-Gm-Message-State: AOAM533Dv7KW2xlR/4AvM/3vPUxgZgbdfOamVsMz4k4VL77AeCMSbKPj
        +ka7Ow+o8mjIod32DncE+StlnA==
X-Google-Smtp-Source: ABdhPJzOeMnbeszmHXXVmi9cS1WP+C6v+N9/fl+FfYjF90m7DrLtS9Wxsh//Et3QXAUgw7l8F9buNA==
X-Received: by 2002:a1c:e908:: with SMTP id q8mr6088247wmc.59.1593439494664;
        Mon, 29 Jun 2020 07:04:54 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:04:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 07/20] misc: habanalabs: pci: Scrub documentation for non-present function argument
Date:   Mon, 29 Jun 2020 15:04:29 +0100
Message-Id: <20200629140442.1043957-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'dma_mask' is not passed directly into hl_pci_set_dma_mask() as
an argument.  Instead, it is pulled from struct hl_device *hdev.

Fixed the following W=1 warning:

 drivers/misc/habanalabs/pci.c:328: warning: Excess function parameter 'dma_mask' description in 'hl_pci_set_dma_mask

Cc: Oded Gabbay <oded.gabbay@gmail.com>
Cc: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/habanalabs/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/habanalabs/pci.c b/drivers/misc/habanalabs/pci.c
index 24073e8eb8df9..61a8bb07262cf 100644
--- a/drivers/misc/habanalabs/pci.c
+++ b/drivers/misc/habanalabs/pci.c
@@ -317,7 +317,6 @@ int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
 /**
  * hl_pci_set_dma_mask() - Set DMA masks for the device.
  * @hdev: Pointer to hl_device structure.
- * @dma_mask: number of bits for the requested dma mask.
  *
  * This function sets the DMA masks (regular and consistent) for a specified
  * value. If it doesn't succeed, it tries to set it to a fall-back value
-- 
2.25.1

