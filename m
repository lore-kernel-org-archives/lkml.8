Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F538C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26CC920829
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRNHQA0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgESSXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgESSXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:23:22 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EF1C08C5C0;
        Tue, 19 May 2020 11:23:22 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id f4so206295pgi.10;
        Tue, 19 May 2020 11:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pY6IgznDxAaGRWUcar2fz3AD/53JsyaALJvf9wFhAgA=;
        b=gRNHQA0pz607JvoqVJm2IubjGeiiTMeCPMpCFYHAinmY57/Ye9rysGC8K7QZ+rN+G/
         hkphW2IdOQ7s5iJ0GowVQio/7C7mdVwfUJ1iHDaZ78h/vETXXl6h6vnc9tT/sgv+85GA
         EpNGqaENTkYZ8HnMMbEu3XWswu2H171+FqWAH2ahAxdN0GQM9fDAu692SE00SK2RpO95
         YWAzA7Z/tl71Fp9l3ddsH4XquvZhhYTy/Ym4IBKtIeQ7hfmVCVEvBQaBRb/3rremveIZ
         OzERoM2/yAHU6kMO1yaMjeZBSXS1nk5DW5Ueiq2E7CaQgtfr+m/X0t871vqpPKgKjq6T
         NmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pY6IgznDxAaGRWUcar2fz3AD/53JsyaALJvf9wFhAgA=;
        b=SYZaHTFF7VCejfBPdu/lY6fHCrt7gZZtyrLgvrU2xXAkZGMJRHGc5vLX6Q8hKKs5Qy
         ypGVWL/6tnnYa2SNJiY7Gt9z9hnBPd/0YIq6lSVll8UO9vw5H+vCGxBp0q4Ntty7DhO1
         W4MqSGenKOk3uBMPDuATgzUxNDo+nN/e/mEViHoW/NUd6tgu/HpwXnNQsKSYeaIY4NUN
         7e56Z4IjNwiCi8RuPSIYgORogF1ZuLhPEXyaWBsCCNlni4XWaKW9BOOFmoZ5mlkTh26S
         TjxxYVc2gHIicLH3HfeG5bxfc4cVbmlFONWBOyfYs0bE4/sEKAFdHHqldnvzJ1QcLnYz
         vQng==
X-Gm-Message-State: AOAM533oRvXFEIPR64R+/iCmQAGCX4bPpm3uSXQaf2qyvPiJSSfZeY0l
        yHxV5hnAI2kz2ZTXgrgUFP0=
X-Google-Smtp-Source: ABdhPJyCz2MwrtoM6b5u4yUidSGcJSh42+g9tYF/KmB0+iSaq7zg5FJPzcLtmzRh8bRdziIxxGyq+A==
X-Received: by 2002:a63:1c04:: with SMTP id c4mr509936pgc.128.1589912601748;
        Tue, 19 May 2020 11:23:21 -0700 (PDT)
Received: from localhost.localdomain ([223.235.145.232])
        by smtp.gmail.com with ESMTPSA id p2sm148399pgh.25.2020.05.19.11.23.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 11:23:21 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 07/10] dt-bindings: reset: s700: Add binding constants for mmc
Date:   Tue, 19 May 2020 23:49:25 +0530
Message-Id: <1589912368-480-8-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589912368-480-1-git-send-email-amittomer25@gmail.com>
References: <1589912368-480-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds device tree binding reset constants for mmc controller
present on Actions S700 Soc.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v1:
	* No change.
Changes since RFC:
        * added Rob's acked-by tag
---
 include/dt-bindings/reset/actions,s700-reset.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/reset/actions,s700-reset.h b/include/dt-bindings/reset/actions,s700-reset.h
index 5e3b16b8ef53..a3118de6d7aa 100644
--- a/include/dt-bindings/reset/actions,s700-reset.h
+++ b/include/dt-bindings/reset/actions,s700-reset.h
@@ -30,5 +30,8 @@
 #define RESET_UART4				20
 #define RESET_UART5				21
 #define RESET_UART6				22
+#define RESET_SD0				23
+#define RESET_SD1				24
+#define RESET_SD2				25
 
 #endif /* __DT_BINDINGS_ACTIONS_S700_RESET_H */
-- 
2.7.4

