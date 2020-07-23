Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A5CC433F8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B7132065D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tI3Az9ZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgGWNVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgGWNVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:21:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2036C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:21:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 88so5153968wrh.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=G1wnHLd0NRHI729d4RsZZFaMbUry0Mq2KftA3Kfuoh4=;
        b=tI3Az9ZMpNnFPW5uSP6xxaKISSRFfisPbxZgllpsLPPnKHGen0Lu1dOXtTNJVxxBCC
         zpeDUdrEO4W2HkcOR0Ani1izlKqrbGzcW97VSXgAcJ4ht61Nw5nX5J7AwMbgDX7wH71b
         Kpkm0ybWF8/uAnNaBA3REg3oPHafVN3vlDrWNfUu6WybqoCyTlYyKzkAjiiJZZ7d+FSy
         T0QGVzeQYH/lEpaoypo5m4b8xq0wgAP8AJciWl9n2SC2bWLlQjuOJ6g55luw3h+CB+gI
         jT5Se6iz0H9cb9c6JMUfjzJSi+HzwLAjG3+6Bvl4TrCEcWwIw408J3iVRk8v+ESuyHw/
         eC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=G1wnHLd0NRHI729d4RsZZFaMbUry0Mq2KftA3Kfuoh4=;
        b=TTEVxSpbakHdf3FdZB15vhF18THLalKJj3/InfhCbYv8y0aEHBeqy4RbenCCHlr9cB
         60pDB3q38rFPvVRCen4Z4fKpNsaODlp6CVQgQJCkxeScc2jiHUVM0n/n+x3ixCuaWCLa
         W2mzZKCTQUhOz7jK5yIa3LQv0BOMwkmpc7wfIc80TQsf6LDGQakCL2w4ZOb3B5txALnK
         pnJuw1VhFPhWKclIs3PWScTdT6mgEkRHjUGEF1IH0pbmrsDQkDhnGQFYD6YyMKSQY/x1
         7PkoW1o3eVZKetT9ovNXGAaP9kvqiuNkOMc1Yjj88SXtIUy1TFghAwmSsIixxlwUJp1i
         L9gQ==
X-Gm-Message-State: AOAM533YYPu8enS3O5ap6F+LcqQyMAH4qriTVy0HRwIJoB+EGdujzzq5
        wowt+xqbLSU7TCAODUozngkQZt16d4E=
X-Google-Smtp-Source: ABdhPJzSDT/RxzayO8buZtvKbC2a4QDO5UxNg2rY+KEFz/FHWZP+gTCUhlSQe+Sme93qAC+Odes7gQ==
X-Received: by 2002:adf:cd12:: with SMTP id w18mr4144018wrm.352.1595510490724;
        Thu, 23 Jul 2020 06:21:30 -0700 (PDT)
Received: from musamaanjum ([111.119.187.25])
        by smtp.gmail.com with ESMTPSA id q3sm3496182wmq.22.2020.07.23.06.21.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jul 2020 06:21:30 -0700 (PDT)
Date:   Thu, 23 Jul 2020 18:21:23 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     musamaanjum@gmail.com
Subject: [PATCH v2] staging: octeon: Indent with tabs instead of spaces
Message-ID: <20200723132123.GA26221@musamaanjum>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a coding style error. It makes code more readable.

Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
Changes in v2:
  - Aligned more lines with tabs

 drivers/staging/octeon/ethernet-defines.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-defines.h b/drivers/staging/octeon/ethernet-defines.h
index ef9e767b0e2e..c060374a3da2 100644
--- a/drivers/staging/octeon/ethernet-defines.h
+++ b/drivers/staging/octeon/ethernet-defines.h
@@ -22,19 +22,19 @@
 #define __ETHERNET_DEFINES_H__
 
 #ifdef CONFIG_NETFILTER
-#define REUSE_SKBUFFS_WITHOUT_FREE  0
+#define REUSE_SKBUFFS_WITHOUT_FREE	0
 #else
-#define REUSE_SKBUFFS_WITHOUT_FREE  1
+#define REUSE_SKBUFFS_WITHOUT_FREE	1
 #endif
 
-#define USE_ASYNC_IOBDMA            (CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0)
+#define USE_ASYNC_IOBDMA		(CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0)
 
 /* Maximum number of SKBs to try to free per xmit packet. */
-#define MAX_OUT_QUEUE_DEPTH 1000
+#define MAX_OUT_QUEUE_DEPTH		1000
 
 #define FAU_TOTAL_TX_TO_CLEAN (CVMX_FAU_REG_END - sizeof(u32))
 #define FAU_NUM_PACKET_BUFFERS_TO_FREE (FAU_TOTAL_TX_TO_CLEAN - sizeof(u32))
 
-#define TOTAL_NUMBER_OF_PORTS       (CVMX_PIP_NUM_INPUT_PORTS + 1)
+#define TOTAL_NUMBER_OF_PORTS		(CVMX_PIP_NUM_INPUT_PORTS + 1)
 
 #endif /* __ETHERNET_DEFINES_H__ */
-- 
2.17.1

