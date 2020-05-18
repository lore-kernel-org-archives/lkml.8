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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED555C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDCDF20758
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAHG98Va"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgERCZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 22:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgERCZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 22:25:44 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6219C061A0C;
        Sun, 17 May 2020 19:25:43 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a4so6621852lfh.12;
        Sun, 17 May 2020 19:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EZcwl+FdQQdIuROk/dCH6r22SPirYIaGMlA5OOst7lo=;
        b=iAHG98VaJgzyHr4TazcEbw/DTb4yVWv29sNpFRnPZHWerKfGq82Qz7+cnjA1q0o7ns
         xWMp04x7z+e1dzKS/atiBfEAagelFJREYtIp+Qe4our3RrCWPI3LHk4X+BXRGVbLUZiQ
         8e6/luO3w9QehGASre10BZvnKVBJZ/IWiY4e108V73EP7FZeEZj4hWtKit1zzTV7aauc
         U2exa0G0acHjHhL1Tzp1hvxOhaPXgktqkFsAw4mfQ4LxbPzqi6lPITYTxboAeH/iII1l
         deUaui/u/yaZZI2Ar3v12mRjDxi8CKMeJsKYR3rUEt7RJJvBKGUI4WM/wVg1o4pVVvdc
         I6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EZcwl+FdQQdIuROk/dCH6r22SPirYIaGMlA5OOst7lo=;
        b=HlXhGx8myU/b13KS9D0cMdwIMToXoaUl/9d/PKsFiv5T74m/bPp6vrVABO8KFNtE8E
         hMJuI/U5QQOXuSW+OnUGgZMyIMzhDnV2Y1VkhbAHOWxOVA9sVyWRjuAYYgPtYwn+D2hm
         SVoK1Rp6fuSbQAc7TtBfljYvjGxipRcTelRAGq2ii8gnfgqqJRTdRA5LUQTAopMbFD6U
         UFnuHBYqB/j2orsw/qFPxBlweIHOQKUV4Tq1fbHUkNx5upf8PVvJlkmPECbAY6AYHdzU
         jsWwDrcFfZevIW7dEJllCmSPvm005bHKsLfVTU8d/Jv/YivoveH031asXgMJT4ARyoqB
         qlNQ==
X-Gm-Message-State: AOAM532UXo+VI4SCoswsjzCSdpasHe5TZ5U8+/LX/cP0vr0vrbWSweA9
        xwcDWKySAl2Th9UcOeJr/5A=
X-Google-Smtp-Source: ABdhPJw+LU+/IwFw9MKHSFiOcLRwo+BVGtENw7Ju5BSQXs5NlQRrp4bjWvb2d2sG1i15BI8bqOb9Hw==
X-Received: by 2002:a05:6512:62:: with SMTP id i2mr1031616lfo.152.1589768742405;
        Sun, 17 May 2020 19:25:42 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m13sm5997306lfk.12.2020.05.17.19.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 19:25:41 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 2/5] dt-bindings: arm: amlogic: add support for the Beelink GT-King
Date:   Mon, 18 May 2020 02:25:28 +0000
Message-Id: <20200518022531.14739-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518022531.14739-1-christianshewitt@gmail.com>
References: <20200518022531.14739-1-christianshewitt@gmail.com>
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

