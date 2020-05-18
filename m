Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9D2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA582067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg/p6Gay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgERCZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 22:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgERCZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 22:25:50 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F41C061A0C;
        Sun, 17 May 2020 19:25:49 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 82so6663066lfh.2;
        Sun, 17 May 2020 19:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JIjdRX9A90RloyzWddQMSNfv9XohduT/lwJH2Xd4NPE=;
        b=hg/p6GayJFU+ZVAwJYdVWfyBACACu4dR7Hi4P+BWc9bzx7eXm8Ef5zA3AMtPFZweeE
         9PJ03qZ8pcJ3Goyx6bDhaS0qjSO5vzhdM+LJDEmV3uRVYuVKUYTCDmJTa2dEPn+XMf+Q
         Blncly+LimtWzaO9H8zge7bUYAXoVvBLgwq5iZV64EUY21FB03yuwmg77nn6mCVm3Fzy
         vMsAdhzKphnLPvhpShDpajPjQJXYzl9pxiwZ1al73/Iw3grDXFDvuINc6SDRPydd3qrM
         ZMxfFZ2zmVbIjDoa7URpJbckZ4jGWVsC6Rp60FMWloICMEoHRHClv/wgbUq/Hvsq7oUc
         2FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JIjdRX9A90RloyzWddQMSNfv9XohduT/lwJH2Xd4NPE=;
        b=idGw5roLS4652jzX2fjC9LJbO84n+TsO63/+UOBSsqb/6dEvFJRBfC7qzJdKvFeK/u
         FaA34nmr2wDQByOEizZWHw8c2Sl03FvxzUAbd9MmIkmqRUy8rVQzuyk7Pxt/P6XE/JBt
         0RUaiBeiP15Epjtdvh75kSRF3NuDwT3qrZ8waErhra1rd9qMBi1W4/TT44puwsRAR379
         dbhYTT4semteuhBCKPJHIYbFuQ2Pah4I73943nxsmbuCJ8/EHue1y8W+LvYYnN6VEeso
         WnjxS1y9+BGElFAWBOpng1KUmnptmWQ7yFXTOzPvY1y00dx8BxIZHdRx1H0ajSnC1CvY
         v59A==
X-Gm-Message-State: AOAM530/2s39Z62SVWPpjqyJFAguSarYPIrQrZTS4l3T3MEfyr3JQNKp
        FmxQWWLYa0swO948OOrLwCA=
X-Google-Smtp-Source: ABdhPJxas+MEYizfzoXy8rTxcFyX8DDflGkqsjaLHe97SIOwVyVAqTtXEHKVJvYMbEAv0FEk756ljg==
X-Received: by 2002:a19:6141:: with SMTP id m1mr10214988lfk.7.1589768747784;
        Sun, 17 May 2020 19:25:47 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m13sm5997306lfk.12.2020.05.17.19.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 19:25:47 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 4/5] dt-bindings: arm: amlogic: add support for the Beelink GT-King Pro
Date:   Mon, 18 May 2020 02:25:30 +0000
Message-Id: <20200518022531.14739-5-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518022531.14739-1-christianshewitt@gmail.com>
References: <20200518022531.14739-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chewitt <christianshewitt@gmail.com>

The Shenzen AZW (Beelink) GT-King Pro is based on the Amlogic W400 reference
board with an S922X chip.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 25e118b8a97b..46cb6359f530 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -152,6 +152,7 @@ properties:
         items:
           - enum:
               - azw,gtking
+              - azw,gtking-pro
               - hardkernel,odroid-n2
               - khadas,vim3
               - ugoos,am6
-- 
2.17.1

