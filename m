Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9694DC2D0EE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2D020771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iRUVjpwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgC3Xpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:45:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45679 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgC3Xpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:45:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id t7so23731636wrw.12;
        Mon, 30 Mar 2020 16:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DxK6o0d762Zl57HAnhWXL/U279uSuVK4xM7r8LkbtfU=;
        b=iRUVjpwzhUgZWdAu9OhKc2QrrebME/a6PvPbBtwpO/QXWfNUP1cSPkUM8V1DPCppIt
         Z0CsUnSr4EEZfJad+Btd6XHnDBMRP0GI8ZTpVMapuFzv5XRwEEIU8okXXnQAIoQdKHTN
         duUcuETE1GDEw9Nn502Kkhi6wH0qt1RwFhCwRHDtTc2gzJjwnJmkea/Da0961UmhzFgA
         y5f4Cf0DpkYBQ38YboNqsrC+1nAJHojyvjbzoPmKhCsSj+NICy/l0vSgyNMCc4jI/k1b
         UR59ucu7S1ftnBnyzj5iz64c7qaPFhta83VUfxkG3KsUDL1Qyot2jVqBY8ubtcm7/kwD
         yAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DxK6o0d762Zl57HAnhWXL/U279uSuVK4xM7r8LkbtfU=;
        b=YlRZUURfuNwrMwgGirfhFrIGrzj+TQiWXeIJCxOGj26RBERerqtYAaF0Scx612pFtB
         TSz6q9Vx0fpS36K8w/eZvWuJyqadHG+UYgrUE4jDfKT9JX5t3sP1hRPXznNRhpShkpnZ
         bB761td5mk/TTdmXzGAqCgmYqLm1icLalPu5dCxYazEqsxDNbBKU15ZRsBcIsPo3KkIm
         tTq5afK/Fa4jyMiUJWIHAUKQ3ZqiFl9UtiknipEgaRCADQeumieGHeUo7L8btV7l8VH8
         VTDl9dIRVNrjlgdOA+9Q7qQN1MuoNoo0wyli5rp8fWn7Sn3MqqVNcmzyQWgP46Lr8TGd
         Xqdw==
X-Gm-Message-State: ANhLgQ1mx828oC8VxIUCF06Lowe6WH4NNNPUd0ZYJ7yC165OWH8T2tZr
        FT1YQboutyBp9GbE7kHIyVO9qKL1
X-Google-Smtp-Source: ADFU+vviGdVjMK+SeAP3YtjOZuI2rOV6Ly+eqgrfC2ttV2VBMynT39e3PrONu63IHkoumJXpawRGWA==
X-Received: by 2002:a5d:4d07:: with SMTP id z7mr17767249wrt.92.1585611948819;
        Mon, 30 Mar 2020 16:45:48 -0700 (PDT)
Received: from localhost.localdomain (p200300F13710ED00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3710:ed00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id v186sm1392953wme.24.2020.03.30.16.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:45:48 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        narmstrong@baylibre.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] clk: meson8b: export the HDMI system clock
Date:   Tue, 31 Mar 2020 01:45:34 +0200
Message-Id: <20200330234535.3327513-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200330234535.3327513-1-martin.blumenstingl@googlemail.com>
References: <20200330234535.3327513-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the HDMI system clock (used by the HDMI transmitter) so it can be
used in the dt-bindings.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.h              | 1 -
 include/dt-bindings/clock/meson8b-clkc.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index c889fbeec30f..94ce3ef0c1d5 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -146,7 +146,6 @@
 #define CLKID_CTS_VDAC0		171
 #define CLKID_HDMI_SYS_SEL	172
 #define CLKID_HDMI_SYS_DIV	173
-#define CLKID_HDMI_SYS		174
 #define CLKID_MALI_0_SEL	175
 #define CLKID_MALI_0_DIV	176
 #define CLKID_MALI_0		177
diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
index 68862aaf977e..4c5965ae1df4 100644
--- a/include/dt-bindings/clock/meson8b-clkc.h
+++ b/include/dt-bindings/clock/meson8b-clkc.h
@@ -107,6 +107,7 @@
 #define CLKID_PERIPH		126
 #define CLKID_AXI		128
 #define CLKID_L2_DRAM		130
+#define CLKID_HDMI_SYS		174
 #define CLKID_VPU		190
 #define CLKID_VDEC_1		196
 #define CLKID_VDEC_HCODEC	199
-- 
2.26.0

