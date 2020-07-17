Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79A8C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 850C62076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lnb0CtVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgGQNyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGQNyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:54:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DEAC0619D6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so11160571wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q0v3MpsT0EiR8b5Jx0N89c4SZ6k9ifhqdf8ekF4nSQ4=;
        b=Lnb0CtVbWRFsYcq4I5p0F1kPtzqlpb6+B4HmHr3H+ScjOsj6hVQKmo+YIsjT/9/1Wb
         Yy2UgzVEDRWavrWMKex3LUCcFe52iG62z/WvSEZ3zI6juSVZPj/pEqEXhfaMh3gIozlj
         t7HNZjapNynHgojy1h7+YTFwv7Qum3LB6AZh/SMfJecVuhCDb/bMSGw8ZfBrXf59OnzV
         lZiGC+oV1HLtzifxh7cQfiIOF4+ng7vsehMXUj6Q9InmFvkFup9vjes56JwEP1rkc5bM
         WAUuYaXko7tWKb7ZE114QTBu1M2OSz72GYWTnkhCU/cozXoZHojS11ZFxsEZ3fmtGekd
         nM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0v3MpsT0EiR8b5Jx0N89c4SZ6k9ifhqdf8ekF4nSQ4=;
        b=r+uJSoH5YR8lzOmD3TsGE9xAuRZuqPQsw22KaLsW/KWTuyl6sewUX5cCJXK2YUXuQR
         VBfzP2iIl19Ry2DRQE5vibzrdHkQ+u4DtrlNj3ef+Of7L8zJA1Qcw+4NSFYnj6ANQ7B9
         KBZsmnCXNlXUnft/WlET94qXKVwK3z/eDpyVFxJKnCWGSuXqp59oQl0HKBFDrhS+Q1qa
         d7FBcR2pI2h/zPoQP9Re4fCb1UXHk0hOcFv3kOMtVOv5uL1lwx1lOFDNOpFtvUFgnEXx
         GlN2W9Ks/9HmBz6Xh8L4o+aA1Pwh1Q3kXSP+5UgRpjLWpWOKWAXQPeZXUnZCpodqzwDf
         IlOg==
X-Gm-Message-State: AOAM530l/ln9XngV/KoGubkD0BHmSBJLVf33t5bfxOxsJIgGVkg5oFFr
        9oBgN4QZhPbTv6a8hDWo68lLVA==
X-Google-Smtp-Source: ABdhPJyWncy34Npy4rilSJUIpPISij8gKpvR0Ke699A8H9i1pMrCUYIxVOaCspw8BGlBJb6OzBknuw==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr9770503wru.147.1594994070888;
        Fri, 17 Jul 2020 06:54:30 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:30 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Mika Westerberg <mika.westerberg@iki.fi>
Subject: [PATCH v2 04/14] spi: spi-ep93xx: Fix API slippage
Date:   Fri, 17 Jul 2020 14:54:14 +0100
Message-Id: <20200717135424.2442271-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ep93xx_spi_read_write() changed is parameters, but the function
documentation was left unchanged.  Let's realign.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-ep93xx.c:227: warning: Function parameter or member 'master' not described in 'ep93xx_spi_read_write'
 drivers/spi/spi-ep93xx.c:227: warning: Excess function parameter 'espi' description in 'ep93xx_spi_read_write'

Cc: Mika Westerberg <mika.westerberg@iki.fi>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-ep93xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index ae7c79a062084..aa676559d2738 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -214,7 +214,7 @@ static void ep93xx_do_read(struct spi_master *master)
 
 /**
  * ep93xx_spi_read_write() - perform next RX/TX transfer
- * @espi: ep93xx SPI controller struct
+ * @master: SPI master
  *
  * This function transfers next bytes (or half-words) to/from RX/TX FIFOs. If
  * called several times, the whole transfer will be completed. Returns
-- 
2.25.1

