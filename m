Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78133C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52DDC20758
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrzlipXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgERCeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 22:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgERCeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 22:34:16 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BF0C061A0C;
        Sun, 17 May 2020 19:34:16 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v16so4094168ljc.8;
        Sun, 17 May 2020 19:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EZcwl+FdQQdIuROk/dCH6r22SPirYIaGMlA5OOst7lo=;
        b=rrzlipXa2K7omWhOTmRpk/EgvaqeDyypAs7x8yHyRFzkXzbpZTG+lEFkK6OD60Lbrw
         ddoXH15XFID6+pdMewajt4A+vRvYFo7dG4zRDaPOb96WYSoW4Cv12bDECYczX2BCr86b
         ALhatq1cFdrlWxxjRt41Kyc3b4GZfRmkDOHPuNrpQQol0fZYRgmISJ57zDjH9Nf3xSyk
         bb1ePzhw7osMwIPyTmrBev/VmsDo522Tgx5IDHSB7y06mWm+8/tLLSjHC2+bRp+DjvIs
         JUB9rxrAWNaBf90IIu+B0bwlqavwLEzUx3G2BuWUJ0dNNW0WT6eSlZuhwuGkjaEJDqX6
         uNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EZcwl+FdQQdIuROk/dCH6r22SPirYIaGMlA5OOst7lo=;
        b=j7hk/QiUdNUKV8v4pVmbNO0hstSR7ueoj/VldFOKmFOHFpotoKDeNkwDvHqTMzB/lO
         xS2CxplzGTIHPhEyNj1vPzBuShbs086oBx0Xj/ecaALmmDrr/e87i+EhdEG91TvfPjFm
         6FyDdfZwuE2tFnd7qSV49uPTdJBTsSi9keCtQY8RIvmbAgDBAG8z8p0qcLcnP/KVqMr0
         eb7M8dp8mMHczsBdNmP+s9jE6ndXwrgAyJPjIDJPLxiFWk3ZNZxIWtHDQKCIEbwLUTbP
         xQVQtvBIaYS0DWlSK30elQXbv9s7s4tIsdaWdgafyJp3yejrPifLMB8kPRas9pUI0/9H
         AfMA==
X-Gm-Message-State: AOAM531lVGmzqteqiHgDL09FmVsBOD2hCWcnwDEuXBZ6/x0d/WmIgzYf
        ZUCr0gHVtwGc810mKyifxOY=
X-Google-Smtp-Source: ABdhPJz6smy/yVMyNfXPejFCiaF062ms2vqavL/yRgfrz/8Hw6RAK0xwN76ZoOGpbWnM/spekQ3gWQ==
X-Received: by 2002:a2e:958d:: with SMTP id w13mr2615763ljh.207.1589769254850;
        Sun, 17 May 2020 19:34:14 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id l25sm5937498lfh.71.2020.05.17.19.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 19:34:13 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 2/5] dt-bindings: arm: amlogic: add support for the Beelink GT-King
Date:   Mon, 18 May 2020 02:34:01 +0000
Message-Id: <20200518023404.15166-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518023404.15166-1-christianshewitt@gmail.com>
References: <20200518023404.15166-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Shenzen AZW (Beelink) GT-King is based on the Amlogic W400 reference
board with an S922X chip.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 5180a548bd94..25e118b8a97b 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -151,6 +151,7 @@ properties:
       - description: Boards with the Amlogic Meson G12B S922X SoC
         items:
           - enum:
+              - azw,gtking
               - hardkernel,odroid-n2
               - khadas,vim3
               - ugoos,am6
-- 
2.17.1

