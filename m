Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01685C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D275620792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPE+tWYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgGUESE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 00:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgGUESD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 00:18:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4B1C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:18:03 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a24so10109752pfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=373R9ouGaabWkF9LOu0D0r/ZsTxSFcUlmLnh8I9bY0s=;
        b=RPE+tWYjEq8lfF5Lw3l/T2VT2gCqX3SDMnLPmA7+qFMTTKSKBzKX5ZJj+2qCHprw0X
         zhFj6A9WFsSrz9NAqY5J4gbiqPbJPY8qJRzhfwUq9lyt1Su+mlIO4+W8O1jXJzMvWNZQ
         5uOA2k2a6QWmhZN5ysIsuMEd/nrlVlZBsmd/QDGma0t53aVuYeX9E2zytGNvy22clEmz
         swji83M0Z6BNIBEqYqvPmRvztC/wG/tcV8MVy6ra8iMBzCG8sUQBznsfD1Mynnvru0b0
         TNO3NgvemhHKueBqbtH3AHZ82se4DMGdqjcTcO8iyQkGvM6awUyOp6uosnGYAdWDzPfp
         hQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=373R9ouGaabWkF9LOu0D0r/ZsTxSFcUlmLnh8I9bY0s=;
        b=d0tv4pk6htD/TzBoTHATv7YAWWOISwGhEN2IgGvgosT57dJCUTWhlwV7BsbZ4BGrid
         FqLEsTzYo5j2+DjBnpMg9ElMW3hAzSRfwvL30gJEaVr5/OKezaMW0wrjfeKfPDV5+KA7
         UbJgKLxt1J8Rx/PvOo1KMYHBnRDRhdOH7zn89TLWaajcNa3fwQXlhsgZy4JixDP84fD3
         vnWFNIQUJUfrO4ZIr14wEms5LWXqlKAZVJR30Wa+3hJpL8obz9SZrL+qZlI0FrQoGvaS
         BF28eq4yT+IWWPOvgU9ZKcVqXqTeK23SktvTVEzybv0t4D72RuYav50ioEaA21C9FZYe
         NRXg==
X-Gm-Message-State: AOAM531eremjOrauGKw7EZQ7e3NxwwS/Mn0eY0faZ7K+8QggNO7vKp3o
        pGbmqzAfuvUnZpTMNyIRs+NnPpRw
X-Google-Smtp-Source: ABdhPJwVPnVtk5dh2Lh4fkPP3MVN8SquGMQEFuF8nfcQma0abf59oSZFhiCWcRp1e3eJXlBbB8zm0g==
X-Received: by 2002:a63:417:: with SMTP id 23mr20032006pge.44.1595305083162;
        Mon, 20 Jul 2020 21:18:03 -0700 (PDT)
Received: from localhost.localdomain ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id e28sm18467270pfm.177.2020.07.20.21.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 21:18:02 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     suleiman@google.com, joelaf@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [RFC][PATCH 1/4] arm64:kvm: define pv_state SMCCC HV calls
Date:   Tue, 21 Jul 2020 13:17:39 +0900
Message-Id: <20200721041742.197354-2-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
References: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These will be used later on to configure and enable vCPU
PV-state support, which is needed for vcpu_is_preempted().

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 include/linux/arm-smccc.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 15c706fb0a37..cba054662692 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -99,6 +99,24 @@
 			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
 			   0x21)
 
+#define ARM_SMCCC_HV_PV_STATE_FEATURES				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_64,			\
+			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
+			   0x22)
+
+#define ARM_SMCCC_HV_PV_STATE_INIT				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_64,			\
+			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
+			   0x23)
+
+#define ARM_SMCCC_HV_PV_STATE_RELEASE				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_64,			\
+			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
+			   0x24)
+
 /*
  * Return codes defined in ARM DEN 0070A
  * ARM DEN 0070A is now merged/consolidated into ARM DEN 0028 C
-- 
2.27.0

