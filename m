Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA03C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A993420656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwN+lBp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgHXVUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgHXVT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:19:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46DBC061755;
        Mon, 24 Aug 2020 14:19:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z18so100330pjr.2;
        Mon, 24 Aug 2020 14:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W2l7UoscXIifQg354sjUGWVyjUs++4hJIZtN+5bO26Q=;
        b=AwN+lBp5YsUpDBOj31SIlycJw84KHGr7mdo/Y986K37htcjz1W1pNYqd4FkAM/MbpH
         MtvOoY/0GnAOkEU7Zsl9gDBQ7kGqmLa1J2mKRzZGqQHIP8D+ksG3H2JEV+dMUYBCD40U
         FlSxRfJbcjPJAbu9/Q31bdslC4UeN5dK++u7e5Qi43TPMw2w+WoE38oF3OmVi99eop4r
         P6PjAfjh3bTnr70mmJmnt+Non7eZVn72rbu0UYg+9kz7PT1/p6vUanDuQAw0qwEzwdn6
         jGecwSdsQz6rP4kzFp4CYBdmG6HvPI2by51PA82/noVUSVcC3opX0z/CWTpMypj9HtVB
         EZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W2l7UoscXIifQg354sjUGWVyjUs++4hJIZtN+5bO26Q=;
        b=mD+kIUfEna/MFhn9U4eDp5SO0EinlDUdVwPVTHG2NO1GvEPh1m93XnCruvQch8/CJ0
         VI8d/EEj9XMtUztKkfx9pk/jBFVrjMtnexvKPG2cIXhZYA6hSEfuqKyFZEcF2+xgE8M8
         4Hrm2u+lRll5pxRJFO7qckFPO7IWUkNjjuv4TFRAtXWSxSca7aZRsPqmo5IUb3BtPBnE
         GmRDLEninWCd8G3/U+dzXHSVsQZ0BVIWUstdz09FEshjo6iRtnLXLD+H0FtqSC/+jG9r
         9kX/6JSDQXQvTx3/p+rSSRUfYasKQqSHSI1m2HabNubEsCofb9gFlnHkIrIl01pgxCRE
         g9Fw==
X-Gm-Message-State: AOAM531XSwscNghkl7GGPvSCmrgApxUf4y13FzcRnPyj8+KbO/AWTG8M
        d+Z92Q2edDFWAcvcjLLi5oc=
X-Google-Smtp-Source: ABdhPJwo8WNCDBMzCSUOKapnFrQwwyMyGv6jhXvAm/1kcZJwzHCe3jnqJGLxwQhx1P/DBPwu9DILsQ==
X-Received: by 2002:a17:90b:3509:: with SMTP id ls9mr923847pjb.230.1598303996962;
        Mon, 24 Aug 2020 14:19:56 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id t10sm97788pfq.77.2020.08.24.14.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:19:56 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 1/5] ARM: dts: aspeed: Remove flash layout from Facebook AST2500 Common dtsi
Date:   Mon, 24 Aug 2020 14:19:44 -0700
Message-Id: <20200824211948.12852-2-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824211948.12852-1-rentao.bupt@gmail.com>
References: <20200824211948.12852-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Remove FMC flash layout from ast2500-facebook-netbmc-common.dtsi because
flash size and layout varies across different Facebook AST2500 OpenBMC
platforms.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 .../boot/dts/ast2500-facebook-netbmc-common.dtsi    | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi
index 7468f102bd76..c0c43b8644ee 100644
--- a/arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi
@@ -47,25 +47,12 @@
 		status = "okay";
 		m25p,fast-read;
 		label = "spi0.0";
-
-#include "facebook-bmc-flash-layout.dtsi"
 	};
 
 	fmc_flash1: flash@1 {
 		status = "okay";
 		m25p,fast-read;
 		label = "spi0.1";
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			flash1@0 {
-				reg = <0x0 0x2000000>;
-				label = "flash1";
-			};
-		};
 	};
 };
 
-- 
2.17.1

