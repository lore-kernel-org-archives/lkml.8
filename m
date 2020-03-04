Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C23C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 22:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD12B20870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 22:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulM5wJLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388469AbgCDWCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 17:02:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51121 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbgCDWB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 17:01:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so3980920wmb.0;
        Wed, 04 Mar 2020 14:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/fbHFCqGXzp5zp7EAhxlHDhB9irMcSYp+XI5eaxN2Bc=;
        b=ulM5wJLASu5uzGjV3eFR7KitNjjq/IKzwyJdEpOWHVcbsO2RLPvuHys5fjt77qMUc2
         tOnlCf/SwWLppIJEWrRtqwHpqwuFcpPXg66LYNCmH6+apq0ao5dLADOjsGb/2ILnjAcE
         vDpeAltPaHGocWSkAjMZuhoI6CXGHd8wp/R6xBcB+78n/6gs/Izqme6Jj8GgTHNYGKPa
         pgdZNYOo/wMKG+51t9r+8hR9H5ylrZfawOEeIjcxPj1CAvde57KOga1Grl4hkh29vWNm
         SNvV44kjKr2tdG5CNARzWJ6QRUqeZhrJfuLzPxf4Q3WvseDmdL0kOd95lQCh5rQKeh9e
         0oLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/fbHFCqGXzp5zp7EAhxlHDhB9irMcSYp+XI5eaxN2Bc=;
        b=rAWtj5CJmQXv1p6VLNFhJPi4tP+iDKmaBvd3YXTxA5x35eCR2NQhEQghy0I1DTsenJ
         XDAti+ruxmFkO4XgVjoKBcRG1Su5QwbCpJS8Cwsfv08ZngZr4X97BpfvkdKq7PowQczA
         EhIaWbELZzJLdG4yBQOBpAPxb8bGDJntXJX9FB5nPqQ9vbeg0jLZU+esJw/26HTOPM/f
         4PyfLFmRI0uB9CJ2juNAST5mrRfJ+QyLzq3nm4nR6m2zX4+jg++yiAaYtnALwAAHkUEa
         4LY/VJ3BNhtOXfBJ7J+HqW9pBl1Nq4qtgPh4nYjz/HuG7R0GOptTus+yw/E9M393csFt
         dtng==
X-Gm-Message-State: ANhLgQ2j4sDUw3onw+Jlqq12J8y+qY9IN+v/elhLwj3/rTOq/D2jBXV4
        oIgHkvdx34pxsO6PLNwoVcPVsqDj
X-Google-Smtp-Source: ADFU+vv7HXNEhxsKZL9MYuxGEIhX/uXOWEpZ/tKRyn9GLAiHdrxsaUqW6Clz8SnIkQrUtKnR/HHuxA==
X-Received: by 2002:a1c:5457:: with SMTP id p23mr5604944wmi.45.1583359318093;
        Wed, 04 Mar 2020 14:01:58 -0800 (PST)
Received: from localhost.localdomain ([79.115.60.40])
        by smtp.gmail.com with ESMTPSA id z2sm36776402wrq.95.2020.03.04.14.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:01:57 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        eha@deif.com, angelo@sysam.it, andrew.smirnov@gmail.com,
        gustavo@embeddedor.com, weic@nvidia.com, mhosny@nvidia.com
Subject: [PATCH 03/12] spi: spi-fsl-dspi: Don't mask off undefined bits
Date:   Thu,  5 Mar 2020 00:00:35 +0200
Message-Id: <20200304220044.11193-4-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304220044.11193-1-olteanv@gmail.com>
References: <20200304220044.11193-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This is a useless operation, and if the driver needs to do that, there's
something deeply wrong going on.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 63ec1d634d08..b92c2b84a94b 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -274,9 +274,6 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
 	if (!dspi->rx)
 		return;
 
-	/* Mask off undefined bits */
-	rxdata &= (1 << dspi->bits_per_word) - 1;
-
 	memcpy(dspi->rx, &rxdata, dspi->bytes_per_word);
 	dspi->rx += dspi->bytes_per_word;
 }
-- 
2.17.1

