Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CADDC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EAA220736
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BJ0XuBYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgCLNbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:31:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45036 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgCLNbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:31:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id l18so7444944wru.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MQB/nJ2X838Fvt+sBkmGr/0pMCoouvYo1EdeUXM4YMQ=;
        b=BJ0XuBYV3ToSPW3UIl6Isc2lumsrYzXzC9pIKP6HzoLx2m5H8VgaPnkaYEyU3nSSyY
         1tLzCAypjVjCczuqqKDKV1kSM0jlkColhbhQeyFQVhbrpWHVd+cqIdpfBucm5Cs8CUNT
         g2JsfKMI1p2KNINJQGW/uTtMsJczcoyPXXZnlpjb8lmdv/EKBNzm0oLEWDR+wc3cC7Qf
         DMCctXTjXci5kB54gBeQKBFgYHiFdJuJ8DwI2USTDOz+pcXtLVEBQNuo9vJANXAlIU0c
         /cnYnC4QN9G/AkoiOE6XME3Ja/GQJj1cvbdw9h8QOh351jbLfIus+wLy4M2iFBemZPwy
         BIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MQB/nJ2X838Fvt+sBkmGr/0pMCoouvYo1EdeUXM4YMQ=;
        b=MgGMTMLsr8T1AHYDW5/Ttiu2Vu0HNT0B9NAPwo0KI0sWDMFyduU57gjPzch3tc2RtG
         Z43n2thxSMQ4OCTMPsCH0VJyaptZWdwNS87I7SNaYt6dJLNn/B1AUcINS1NLIMwZ/P65
         trykx+IC/CRRqDBUmLN2RVjWsxdseT/8d0qxuGHaCyVRN0YFVbalykJVB8O+7QCzbd6j
         lnZYE+qjggTHAbN3+xRxu6A7S8uTMBbq6JlIoVnhr2JE6Y8SjIiJI4svf1MB814W/OFP
         gdAYkKX2mkSsCFk3hSkqfCLm8YGU2mmPlt0qIg552LhAV746BBAdhxaSOxfcePE76v62
         xJFA==
X-Gm-Message-State: ANhLgQ2E3aKz2KNSBSZ9SQVFA7Eiaa4id1yJxGBuVqguVViuML39rsFM
        td6Kwqha0MpYSvoj+SJRyou2XgWMhmM7oQ==
X-Google-Smtp-Source: ADFU+vttYTaI+DCiNmB1UvQy1EL7nMlpTXWyEiRnY5WHDphDcEObnDSPJFvd3uSrVxGbrKBpFiiYCQ==
X-Received: by 2002:a5d:6703:: with SMTP id o3mr101991wru.137.1584019895265;
        Thu, 12 Mar 2020 06:31:35 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m21sm12242885wmi.27.2020.03.12.06.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 06:31:34 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     broonie@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] spi: meson-spicc: remove unused variables
Date:   Thu, 12 Mar 2020 14:31:23 +0100
Message-Id: <20200312133131.26430-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200312133131.26430-1-narmstrong@baylibre.com>
References: <20200312133131.26430-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variables from spicc data struct.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/spi/spi-meson-spicc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 7f5680fe2568..8425e5ae1273 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -130,9 +130,7 @@ struct meson_spicc_device {
 	u8				*rx_buf;
 	unsigned int			bytes_per_word;
 	unsigned long			tx_remain;
-	unsigned long			txb_remain;
 	unsigned long			rx_remain;
-	unsigned long			rxb_remain;
 	unsigned long			xfer_remain;
 	bool				is_burst_end;
 	bool				is_last_burst;
-- 
2.22.0

