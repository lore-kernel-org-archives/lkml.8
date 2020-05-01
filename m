Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23784C47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F013721835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8YxeKow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgEAWdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 18:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgEAWdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 18:33:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A613C061A0C;
        Fri,  1 May 2020 15:33:07 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x18so13419673wrq.2;
        Fri, 01 May 2020 15:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PpsHhU0SIZ/znnjv1B1lxEbVrbiH03IPfJBbSjteEyU=;
        b=W8YxeKowqSJ/ecn9+U19e5QY0n3C+lmV8b7B8oO7LE65F6HG+2T5irzmzl78yYXu24
         hxInpZYqHAmvL1CH9tZelNq/jIoBuRgi7ZCapSnIzTkpYY4N4ZnhXTn9g5VW4jxUlK38
         TTD7ePgqXSHPmWiA4jiSCMqP35ADc/S7q3ZcCkAkVyThYd5axY0cnJHKkmuzJ+brV74u
         /PeKLs2OMVJiwW3l/kC/9VFAga0F3I5RpGRVy2yyCudDGrBkaOAq0SPXpDl3kb91qjVv
         eYbwTxLn+8CRr7QxdKn0D52Eqojz84StFkUN5bKYBrMPeLguignOaci9fQoBdeLl+GKC
         Uiaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PpsHhU0SIZ/znnjv1B1lxEbVrbiH03IPfJBbSjteEyU=;
        b=BqUIZEzqyQbfcEbWLGh7zq9B747Ez+UfzhvDG7PK9nMTht4Wy1LErfwukcjicwo489
         hp5dE4a8zimMrfTpKeCBHWsu0pVMqrP14UACQwwGUL2lJOxTuqYpcEOkoSrsC3Z2W+u1
         ncCEtUkLW8Dh++Rz6xYFMiuRypf6gBXtE6beAH2Yw3qhcmuCiIIXUCnKZBtRehsu3wKM
         EtWiF/cXTQGN9hiCzfkX21eiOkNPpgmrGL9UDYOTIZTNmA7J8svxNDATgQLvX7OLu9Ht
         ghQrwin7Lxv7Xleyz1a/g3Ah3q2wDJzVFXHM8tXZh3Tv+VLu+4bYjy1EXr58qGBft6ik
         l90A==
X-Gm-Message-State: AGi0PuaNI809Ob0kO0ewswXHk7TYSVoXcI8MIF9uhPC6OgqoTxjZGWv/
        0NzWhp8uAj9/f0fM6kxcHqg=
X-Google-Smtp-Source: APiQypKTiMZxHf2OaMphivwaa00Ln7MHIyM+IQfTraGLdmpsY1CAA/180QQKI/uDm3JxIUdwLPZqQg==
X-Received: by 2002:adf:9f11:: with SMTP id l17mr6339741wrf.202.1588372386412;
        Fri, 01 May 2020 15:33:06 -0700 (PDT)
Received: from localhost.localdomain (abag125.neoplus.adsl.tpnet.pl. [83.6.170.125])
        by smtp.googlemail.com with ESMTPSA id n9sm6237750wrx.61.2020.05.01.15.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 15:33:06 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH 2/4] dt-bindings: clock: rpmcc: Document MSM8936 compatible
Date:   Sat,  2 May 2020 00:32:30 +0200
Message-Id: <20200501223232.275800-3-konradybcio@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200501223232.275800-1-konradybcio@gmail.com>
References: <20200501223232.275800-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Knecht <vincent.knecht@mailoo.org>

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 Documentation/devicetree/bindings/clock/qcom,rpmcc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
index 90a1349bc7135..51d1ef62c7450 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
@@ -13,6 +13,7 @@ Required properties :
 			"qcom,rpmcc-msm8660", "qcom,rpmcc"
 			"qcom,rpmcc-apq8060", "qcom,rpmcc"
 			"qcom,rpmcc-msm8916", "qcom,rpmcc"
+			"qcom,rpmcc-msm8936", "qcom,rpmcc"
 			"qcom,rpmcc-msm8974", "qcom,rpmcc"
 			"qcom,rpmcc-msm8976", "qcom,rpmcc"
 			"qcom,rpmcc-apq8064", "qcom,rpmcc"
-- 
2.26.1

