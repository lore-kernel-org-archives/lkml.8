Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F215EC47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBFBB206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RaJENRHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgEDXaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgEDXaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:30:19 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1329CC061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 16:30:19 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id i14so535092qka.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 16:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7bIhS24ed/K9Y45ptnoyD7XQRKXFAj0Zc+zP7TLV0aE=;
        b=RaJENRHD8glCtDXmAzU5CYZtmSU/awBINIXW9vlLzqXEvPjRSbB2AWARVcFGdNFaoe
         /573W3BAZeuYwREM7gdQEypGxR+SytJhwMwOf4QJCseF7YiFE1pqfnExLDo4HBz1mcA1
         NDAhE6Z8hgm/g0MywMoBoxkqn3m4kyy90SIWTI2ICi066/qMJNcTlj76mr4Gf5X8Gq2m
         3FrDUZI/Il/YospPs/zXPaa7e6g+iEzrfyokabd6t4/7j1hc9vrRMAstDcfP8slC2486
         eMkYbHOEc+KMfSkQZi0yGPo94n7tgnYf79IlvkiXEvE1qhpMOLRnUtJDrzl/RKgNXvnF
         p+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7bIhS24ed/K9Y45ptnoyD7XQRKXFAj0Zc+zP7TLV0aE=;
        b=kLMkhExTdc4xMSpAxhfukm9VwIQpj8o82FrjruKzPC9FbF220M/zHiaDjJGDm0L7WR
         yTMYf0TJKhrebAYMaxFPdk3z+YiVcir6ng1OMH1qNDoPpwbkXQBfFWdJyvC4k7ycz2yx
         58iS/QiUJ45+OXrTNU3yDYAxzn1w7GBobF9dseqtLdOUbg/GWuT4nItGslOppIjCrrZE
         6RntfP9HBFIMOOdsWqapo+urLningtSFd6LvdYBRl6gAAyGJDb6W0kviHoOaFCKsCkKX
         PGcEJRlIQAeXgTYuu6vLqXOcYbLztq04c0uX+ZtN6LHEXJWCQZrFfwAGOOnZ/CzLM/OQ
         K2Tg==
X-Gm-Message-State: AGi0PuaM4f49CEMgtarGac0pgsL2oILC5vHAdVjAw9JUOrt3oFx7HWUK
        6Psl1VSWj8eOlWcs4iJsgbt5Hw==
X-Google-Smtp-Source: APiQypKWvFZPVc0eQ+xlNUFeBzJbVj7gckf/qQZyq+2Kj1xS4vLEgByH3OEWs+cVNxkf+SXNdAy8ag==
X-Received: by 2002:a37:a1c7:: with SMTP id k190mr892633qke.166.1588635018174;
        Mon, 04 May 2020 16:30:18 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id c41sm253033qta.96.2020.05.04.16.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:30:17 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: ipa: only reset channel twice for IPA v3.5.1
Date:   Mon,  4 May 2020 18:30:03 -0500
Message-Id: <20200504233003.16670-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504233003.16670-1-elder@linaro.org>
References: <20200504233003.16670-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gsi_channel_reset(), RX channels are subjected to two consecutive
CHANNEL_RESET commands.  This workaround should only be used for IPA
version 3.5.1, and for newer hardware "can lead to unwanted behavior."

Only issue the second CHANNEL_RESET command for legacy hardware.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index cd5d8045c7e5..8ccbbb920c11 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -840,9 +840,9 @@ void gsi_channel_reset(struct gsi *gsi, u32 channel_id, bool legacy)
 
 	mutex_lock(&gsi->mutex);
 
-	/* Due to a hardware quirk we need to reset RX channels twice. */
 	gsi_channel_reset_command(channel);
-	if (!channel->toward_ipa)
+	/* Due to a hardware quirk we may need to reset RX channels twice. */
+	if (legacy && !channel->toward_ipa)
 		gsi_channel_reset_command(channel);
 
 	gsi_channel_program(channel, legacy);
-- 
2.20.1

