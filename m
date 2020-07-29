Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF9CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2074E20829
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="Q5NcUbxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgG2PIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgG2PIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:08:00 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CB2C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:08:00 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t6so14402842pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLWyfEUhKxXNKJFrSYCE0dME2LhnACi7EQ1AP/MIj5Q=;
        b=Q5NcUbxbJL2tzk4NSOjxEP86/y7iXE/BKfpf4R8r781lbtlWBGEPj8Go7eRSvqg/tX
         668V1XwkzjMmAAZ4KArwoDV4Emv0KSCP+FL/fJtMnxwBt2fl+340li9mMpuCJqTlkZua
         gE5Jy4w4JyB5B207TNc9VX+pBmHiiysKdiy2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLWyfEUhKxXNKJFrSYCE0dME2LhnACi7EQ1AP/MIj5Q=;
        b=Tu+dmBDn8Y0CujL4SdyhDCSLH20F3EKMHSV81vbo6QU9ccdiiJ0kbVQaATv1ePekIa
         /dnCeKtW1jgwOQ9E3LDv33rBPuFPHWWiai4wTy5j1/wKFB3d7KsOrAeGGJtSwQyFqGYX
         RdVyNdWqOTBHDr7cJghaeijlCFZN4BNH4LbHtdHnAQQU72kyFj4NmD3vDASbKlksxRK5
         j1qfl/iY/z22y/5P3H/YAyObOi3nJqXV0IXe5THsBA2OxKpwCcLm4XS+Xh/qG9qVFbnt
         O7J1bCCK42HgU9+ZAh1tFkRrRcgNPwbM5X0djmQF6RVW9GS9SvaTR/3eCvQ3XIdVQS0o
         AURA==
X-Gm-Message-State: AOAM532G79tSEOLyibOxcU/bI+F+oUYiIWwxlEyfkGHHIjQQa2Nfy84Z
        DJl14+AIyL4EQ+73wAOuJddnFuTSG7E=
X-Google-Smtp-Source: ABdhPJz/66JXRSWGtpeKrp5Yo0ZHqUK71S6otyWtJitmYVlxgEiPcuU9A7VikImtfuUpkv5uI2XYMA==
X-Received: by 2002:aa7:810c:: with SMTP id b12mr30728293pfi.69.1596035279685;
        Wed, 29 Jul 2020 08:07:59 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id q11sm2688058pgr.69.2020.07.29.08.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 08:07:58 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 1/3] dt-bindings: mfd: syscon: add compatible string for mstar,msc313-pmsleep
Date:   Thu, 30 Jul 2020 00:07:46 +0900
Message-Id: <20200729150748.1945589-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200729150748.1945589-1-daniel@0x0f.com>
References: <20200729150748.1945589-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for the pmsleep register region in the
MStar MSC313 SoC.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index f3fba860d3cc..614e58bb5d7d 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -39,6 +39,7 @@ properties:
               - allwinner,sun8i-v3s-system-controller
               - allwinner,sun50i-a64-system-controller
               - microchip,sparx5-cpu-syscon
+              - mstar,msc313-pmsleep
 
           - const: syscon
 
-- 
2.27.0

