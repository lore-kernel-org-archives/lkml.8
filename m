Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD0EC33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00030206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NnpfF2ML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbgAQDiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 22:38:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33743 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730100AbgAQDiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 22:38:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so10980208pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 19:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wUKL7anK2VMZt2D/L2kwFyqgWv6/GSNMYRnjYd65PE0=;
        b=NnpfF2MLFTvbGaAnhIIe+UgRA4YZvtzhQgTmCjVzzsS2lK4pkLEDcM4uX19C2q7Jsu
         3gPDrtYqjZvQHtmsh/wTaM1BCoUox0scJPy4CcfosRpQbJzj1jDbj4cuVtW1w7m0Zd//
         z3+A6z+8S3cmIcLu2P3ExnGOFZnxriABD2A6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wUKL7anK2VMZt2D/L2kwFyqgWv6/GSNMYRnjYd65PE0=;
        b=S1B10TCapoqXq3mTpDxMEeZ5KA+3qHS/mHZFlN1xCJzWkNiy/0L2VHJPSNpD22xi6/
         FwvFJqJFh3qBcI+zqy8FocaaaMo+BaN6W7vBXAjefyFCUeeUxC/9rWgX/tngKLpRGcvh
         BMRhfvNxZJyAo6KsxOopeo9aQlugZ/vX917QV8yX4S+SPuvEWO/tiUhcQ0vQFW0lgUr6
         hWphRRjQ4Wo10CeDcMtlS52rJUl/D0jIistMmxcoi9Mt6PIjMWXujSlgYSV3yySzu5Jn
         ZnK5qj+90B6EwH802ISBZAS3l+oo77TXBefmBzleUQbLliOS2FGhPStUEXEaH5qPfzcK
         RbJA==
X-Gm-Message-State: APjAAAU0B6cR5CZRAmPLjJtbMi6HkQQl7YoHGCQFE8A7oUlBD5NCB09C
        vczhA1Sfkf63PgVyoMp0NMW80Q==
X-Google-Smtp-Source: APXvYqz1iwhj0OogQfDaYFTpD4TqMlb4k5bUlrDqndHj3nE2Trjh5/+S2MJfNPZXlLkQ/QY0Qb2AtQ==
X-Received: by 2002:a62:446:: with SMTP id 67mr844511pfe.109.1579232284594;
        Thu, 16 Jan 2020 19:38:04 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id j38sm25940259pgj.27.2020.01.16.19.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 19:38:04 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH v4 2/3] arm64: dts: mt8173: add uart aliases
Date:   Fri, 17 Jan 2020 11:37:48 +0800
Message-Id: <20200117033749.137420-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200117033749.137420-1-hsinyi@chromium.org>
References: <20200117033749.137420-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add serial as uart aliases in mt8173.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 8b4e806d5119..790cd64aa447 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -50,6 +50,10 @@ aliases {
 		mdp_wdma0 = &mdp_wdma0;
 		mdp_wrot0 = &mdp_wrot0;
 		mdp_wrot1 = &mdp_wrot1;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
 	};
 
 	cluster0_opp: opp_table0 {
-- 
2.25.0.rc1.283.g88dfdc4193-goog

