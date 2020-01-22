Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8063C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9180424683
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="v+JqGgoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgAVKFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:05:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35471 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbgAVKE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:04:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so6598536wro.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 02:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yw/4NLYEuxJ4fKq4pCM6ugotTNyG68OGT/ZIT0URmH4=;
        b=v+JqGgoJMtQE0pUX58ConDISFTmQqt6UPkNAzux0NzKoSfnD0mJKZd9bbeiH3o0I+g
         9DQ1pWa3AuGN7EmtAkOnbWmwHuTYsTVf+s1BMzs4wer644CfyoyS0kwhXDz5bP9Ug+/X
         iYdz2mRqESoQP3J9VE6u707i7BYGsUtNyqtNgPA204jK18X7JZAO9ue26q14GWFYfC87
         towBTY8iUOCx8G2xwTz7P6G2+kxoxIH4V5QXvcpOegxQA2FZ841nR2KC9XK26LshiX1H
         XmS/vkDvMvtuB8X+FfKduw0rlawm9n9/pPW2liRlgF/ed39P308pq9v/4QTS3UW5dGBU
         rv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yw/4NLYEuxJ4fKq4pCM6ugotTNyG68OGT/ZIT0URmH4=;
        b=AYVSIlwZD5n3wNJtKmQdtUlcC+8G9YOTm9foAPPljydzx2SlVa+sb+WSYkqooEZHYM
         tntkA2gRJy2DFC7F3DVenjS/rpyzc2WZ4eDJKTN3HMi5gzj7z1tHqYVlseiurYBIbIY+
         g6knv0rRRpJQy5h/MdSZU2r1Ld0WxnQ5HiHS+6FYJJVZe8A2WqFERxB6j14PCP2I5nMb
         twH/hpNaIXqVhaZ7cLFdvlgpj8EoGyJKbGy6byMbCt/l1tiq34cB6Ku1QoFvdbh4pM0D
         PFUUkXrNmEh26h4l3IJDj6uJpq7OkYCsxOWDuJWavnG4XaN1I4M/oIBrmwhWduYjmgEM
         ptVw==
X-Gm-Message-State: APjAAAWkRNFs73biSd86WRBvhaatDJTvW2JkxB7nr3SDfhH4YuWgxCfi
        7WBthkqMJlD8h1XVIhfh45kGKw==
X-Google-Smtp-Source: APXvYqwJXta7jmEApeIzjvflSF8Ln/f2IlsILY2IcIhiWwi7NvQ9mp+urqVjtg/E7wk5iecmCBOj/g==
X-Received: by 2002:adf:8297:: with SMTP id 23mr9875680wrc.379.1579687495519;
        Wed, 22 Jan 2020 02:04:55 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l3sm52237648wrt.29.2020.01.22.02.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 02:04:54 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, linux-clk@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: clk: meson: add the gxl internal dac gate
Date:   Wed, 22 Jan 2020 11:04:49 +0100
Message-Id: <20200122100451.2443153-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122100451.2443153-1-jbrunet@baylibre.com>
References: <20200122100451.2443153-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the gxl ACODEC clock id to the gxbb clock controller bindings

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 include/dt-bindings/clock/gxbb-clkc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
index db0763e96173..4073eb7a9da1 100644
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ b/include/dt-bindings/clock/gxbb-clkc.h
@@ -146,5 +146,6 @@
 #define CLKID_CTS_VDAC		201
 #define CLKID_HDMI_TX		202
 #define CLKID_HDMI		205
+#define CLKID_ACODEC		206
 
 #endif /* __GXBB_CLKC_H */
-- 
2.24.1

