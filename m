Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297B9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04A9C206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPdS1l8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404406AbgF2Vtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404387AbgF2Vt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:49:28 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5B8C03E97B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:49:28 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id i25so18911370iog.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x3WsjEvMX2jVlQmLpoImtSBZfw4ruLu125L1QjdLE6c=;
        b=IPdS1l8btarTTx8Pg20WcJKVz5lv3iSeocJNQG5d9q3bXMuLLd80FQTDLn63bBoLEP
         klo0qXxUSVg47JUWi0J2CeJR334hWulsGF71rXX1n8zc+ffWwd7aigAElQ58vXLK/Mru
         4BYlHXde0ZEBJiWEKcxdhR/tLsFYVU4AR3XLOeK6sfe3MO/5l32SUA5w++fyy4HtFLhe
         F8o5vqDYNl7KvkVOXY7f4dtLmeiw+erStlxo2D3xhX1YH3A7ZAHBfAKBIdoDdmbP0dU0
         SrnhiFsnTbfC5vAe3t3UDcOMiPHvr4PJKcQ3axIaFI13/Mciu3bvJGK/ZadCt7oaGPLq
         Wd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x3WsjEvMX2jVlQmLpoImtSBZfw4ruLu125L1QjdLE6c=;
        b=Y8YZ0Gf69FKBqqOFGR2PkBK/aDzeAJi0gauwMhdurXCzw6X8/oBkNPHQ6mYHRx/sqc
         ZPFm6O+1pCVQQtkMIdgaxlTSuYpbjD35QYuIBZMB/dT3FrUoZK2gxHkSCOfm82GpcxU7
         0951Eu2JE3f/as9fuC58LIxni8hm+oetB3gu/CY7Gjlk7YMOfLBnP01B5iFHPYnwWGFT
         SVW+dk8PDsedtwbAyNPXDE0X/mjH7yDQuxw3KnMKDOcmLo+3nysh7lLmjwEPnZpdG12v
         udWbTdTpJv1YjA/6IrynHxremJ2kfCzv6NceK+8nuyUtQ9yUkirMvO75IUgqZf562HZP
         GbvQ==
X-Gm-Message-State: AOAM5320tc6biAsbPJ5Ro8lPv6mGhlL3jfAydnv1+88prPjNWqumrOCs
        rsYlJPLCM6rzfH1Aia+x78H37g==
X-Google-Smtp-Source: ABdhPJxxvMhyvmL6ew9qDBRpHAYYfqbOaQ6QxeQQeIxiwl2aOGKijf6q6PROkEkBA8+tu2Nvld/aVQ==
X-Received: by 2002:a05:6638:d05:: with SMTP id q5mr19477503jaj.2.1593467368176;
        Mon, 29 Jun 2020 14:49:28 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id u10sm555500iow.38.2020.06.29.14.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:49:27 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/5] net: ipa: HOL_BLOCK_EN_FMASK is a 1-bit mask
Date:   Mon, 29 Jun 2020 16:49:19 -0500
Message-Id: <20200629214919.1196017-6-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629214919.1196017-1-elder@linaro.org>
References: <20200629214919.1196017-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention throughout the IPA driver is to directly use
single-bit field mask values, rather than using (for example)
u32_encode_bits() to set or clear them.

Fix the one place that doesn't follow that convention, which sets
HOL_BLOCK_EN_FMASK in ipa_endpoint_init_hol_block_enable().

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index ee8fc22c3abc..447dafab8f18 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -679,7 +679,7 @@ ipa_endpoint_init_hol_block_enable(struct ipa_endpoint *endpoint, bool enable)
 
 	/* assert(!endpoint->toward_ipa); */
 
-	val = u32_encode_bits(enable ? 1 : 0, HOL_BLOCK_EN_FMASK);
+	val = enable ? HOL_BLOCK_EN_FMASK : 0;
 	offset = IPA_REG_ENDP_INIT_HOL_BLOCK_EN_N_OFFSET(endpoint_id);
 	iowrite32(val, endpoint->ipa->reg_virt + offset);
 }
-- 
2.25.1

