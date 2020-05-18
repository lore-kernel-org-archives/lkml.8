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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574ECC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3299A20758
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp8NHPcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgERCe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 22:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgERCeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 22:34:22 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81907C05BD09;
        Sun, 17 May 2020 19:34:21 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h26so6658622lfg.6;
        Sun, 17 May 2020 19:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xl1nvwDloC5SGyJGluG2bly0970Vlb/BB3rsowSf9jg=;
        b=Vp8NHPcUwpw8zYnWA8mTeUG+3McE8IfMPpfoMHJfWLwK8BY1J4U+IssULg3zjBUU0A
         AXxrxx0pwnASo3ENkTOZIdDTrbuEzkGiVTFM7+GLqxAvk3jNSylzzwFaKRZYE2mCWWI5
         71PdpGqhKQF7pJ702HGH3EOnn9un+gIwRc55ZjCvE5tbfvFATs9rcr2UsnlMrrTL09GK
         Y//YlllpkcafLoRnsbM4shqCDTjmd3BXQeA9ymHgXHHi1qWPj+VilpwKrVAEOorEqvCZ
         14097X6MtNZVF6jDqwU2+KzBqed3WQhtCOG4gAn8kO8WSCVP6EwJEZfrbeH4fYEVTpc8
         eCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xl1nvwDloC5SGyJGluG2bly0970Vlb/BB3rsowSf9jg=;
        b=m5QXR5BpFxz56IU4d/YLIiHdjApUMBaIkq3VuyZw45JSuoK4f787R91yYUnpDBwcgw
         dwBBNg6ZfPlpoVNICyZjftTZks+xmEBsvl4eARzsfk1LMSBvufsMSDlYFmhRq6BZGA0j
         mPYRm6GEoymKkhTL3A7phHXgLXWp4aS4AWlJdVUE+2vjStaAPqhgQ3NV+Dv0I6cit9Yt
         OpiQuqEKV3dnXsShQAx2smijah2xi+zEbd2lb8eXn8/cRLoMwWaAN8Hkcr2X3mfqr421
         e0PzhPnoDo5zLVgIbkJTWMdUpIJ8ryzCYCNrHmCMSgDrUglFR1RBzTEkzN1efAjPVRJj
         WkNw==
X-Gm-Message-State: AOAM533LrXLte3OQmFdFYWyB4vPaW/HfGeaFZfv5xdRA1hsxo4KgYgbh
        R4F8ze8MEd0pVtXB0qhV88A=
X-Google-Smtp-Source: ABdhPJyDKiLHGZ0GOOXmaKBS9PeMnLagvUEr271z/x0uzFEC4LwRMky2e2bGIHIRXSQQA9+KvZFZeA==
X-Received: by 2002:a19:d57:: with SMTP id 84mr9997952lfn.112.1589769260032;
        Sun, 17 May 2020 19:34:20 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id l25sm5937498lfh.71.2020.05.17.19.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 19:34:19 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 4/5] dt-bindings: arm: amlogic: add support for the Beelink GT-King Pro
Date:   Mon, 18 May 2020 02:34:03 +0000
Message-Id: <20200518023404.15166-5-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518023404.15166-1-christianshewitt@gmail.com>
References: <20200518023404.15166-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

