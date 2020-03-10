Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97615C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4603B208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vuq4Ru/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgCJWHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:07:06 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43475 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgCJWHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:07:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id a6so6895544otb.10;
        Tue, 10 Mar 2020 15:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y38QgXkGtAvFVzU6lmPevVw9h1a8jj9S/o6E0neojR0=;
        b=Vuq4Ru/chaBTV5bK5P9R6PTUUPO5c1Y4m16RmeyU8np+PbJx+gCZqNJWn2AxRzxyER
         Rfyyx7Gi9fvGV/18TiBrakd3ULy4I+JSkmgPXhotljFq5uwdeBqhbr61mc/RKciXTKlR
         +/BbWJmlTNrtUmlgbrsFAPJBAyzZLXL823MAMqBHIi3yAUQ+jxYZ+1vJYOx/ZJOgl7te
         rMli4wtsR5MVpZUUDozqZqeq11Qi+SuBRqvFCqI2YOV88wNrJBMwhpWPjizubRDHIvgE
         e5l64jjHxRXs2cJkhui+3NyviK++wVnF77rzttuFkNP48NONDjCdR6Gh9OYeDwYWweat
         Bkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y38QgXkGtAvFVzU6lmPevVw9h1a8jj9S/o6E0neojR0=;
        b=TulU7jqwLWB/C5LtmT4QvgIEQiXrJxzEklRq80EKavrCdlwR5JkD0TpMZNYT1n6aTo
         hOOnUrWRCB84pQfMYrkG7IKHHy6lfewa5pnUKgbQM8tNzwj81lcnHxj4H3Texo9FXjY6
         +WCrCP4igB+Dy7StS2IJblC+2QI7Z1JxG8av1kEVaS0H4PBbNWprUTp/DwrWsxzifIO0
         edKL79peWNKd2ZSm14lAy+LWi4/ToHWXWpTCudmX5t/GDxoSrcZSgCeyxLjNgwVpp2sO
         +O4tCmSS/SqeGko/I7RqXcYeETCHEASoEwsQutoiwZdVR0LfFXMNneC0ZyHzq7fVqQXy
         9eQg==
X-Gm-Message-State: ANhLgQ0zv0GSR4B9JLTrC1/V/1gEvHdjq0qRMy1yMI4V05uesk5jXoOv
        G9+HYCw3ZmcHnC7biTfwh3g=
X-Google-Smtp-Source: ADFU+vtgsOmS2yywudR+6sQc6SY06BcWaxpEyL9aLg300DTDPxUYArvV/9MuDr8Hwc2RAwrOyxCozQ==
X-Received: by 2002:a05:6830:23a3:: with SMTP id m3mr7323386ots.265.1583878025091;
        Tue, 10 Mar 2020 15:07:05 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id c12sm4733153oic.27.2020.03.10.15.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 15:07:04 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Madalin Bucur <madalin.bucur@nxp.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] dpaa_eth: Remove unnecessary boolean expression in dpaa_get_headroom
Date:   Tue, 10 Mar 2020 15:06:54 -0700
Message-Id: <20200310220654.1987-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:2860:9: warning:
converting the result of '?:' with integer constants to a boolean always
evaluates to 'true' [-Wtautological-constant-compare]
        return DPAA_FD_DATA_ALIGNMENT ? ALIGN(headroom,
               ^
drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:131:34: note: expanded
from macro 'DPAA_FD_DATA_ALIGNMENT'
\#define DPAA_FD_DATA_ALIGNMENT  (fman_has_errata_a050385() ? 64 : 16)
                                 ^
1 warning generated.

This was exposed by commit 3c68b8fffb48 ("dpaa_eth: FMan erratum A050385
workaround") even though it appears to have been an issue since the
introductory commit 9ad1a3749333 ("dpaa_eth: add support for DPAA
Ethernet") since DPAA_FD_DATA_ALIGNMENT has never been able to be zero.

Just replace the whole boolean expression with the true branch, as it is
always been true.

Link: https://github.com/ClangBuiltLinux/linux/issues/928
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 190e4478128a..46039d80bb43 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2857,9 +2857,7 @@ static inline u16 dpaa_get_headroom(struct dpaa_buffer_layout *bl)
 	headroom = (u16)(bl->priv_data_size + DPAA_PARSE_RESULTS_SIZE +
 		DPAA_TIME_STAMP_SIZE + DPAA_HASH_RESULTS_SIZE);
 
-	return DPAA_FD_DATA_ALIGNMENT ? ALIGN(headroom,
-					      DPAA_FD_DATA_ALIGNMENT) :
-					headroom;
+	return ALIGN(headroom, DPAA_FD_DATA_ALIGNMENT);
 }
 
 static int dpaa_eth_probe(struct platform_device *pdev)
-- 
2.26.0.rc1

