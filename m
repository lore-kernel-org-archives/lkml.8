Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20A9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6352207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVrVYDIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgE3WMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 18:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgE3WLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 18:11:45 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8315AC03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:45 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id d1so5918328ila.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9V3uAtmsq/h0ubP+/MybwndD7z4sK/wWxjhl/xTDgts=;
        b=tVrVYDIU6w3SB67yl+L7KkwONC86HX9knQBOEmey51JrQVi/Io9C+aH19RP/Eip++Q
         vSHT3O4Kcmxz9XbrklY8JLpc8dyW7/MQnWpBt64IKS+btLK4CjjWu2CU5H57a2mI2/2u
         p79TOj9QLWsbtX1oEb+b7RBrMmOSw/TW6oYvw33kbpKs5/mKqtzoG43OIyHlVtDRg7OA
         V6JEDPY0nj1excN/0UdPByv3CLE2p0bqWN6e2nIxI/HfoUvyrLP2bKV12IVCXPdjE1Ie
         wcONLFCtPDuGvgiW3hJAp3UUusV+ks9acs6WVQLJlCExB41phhjVrfzj245+FhZpI4Iq
         oPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9V3uAtmsq/h0ubP+/MybwndD7z4sK/wWxjhl/xTDgts=;
        b=i+Dzpe2GgTrFK4sHr6jn7NCAM2wtuWfHDOoV1NDRlZ7cJ43r+Cp5MqpZETOCQUXCt/
         ImrMl6rOXiMBQIUPOMNLs1Oiui9gch4FKjkSn2Sb6Yb/g7VVb4qCRgBqK5uVVNQAjd3K
         ZJRMQdCndisS6eKgg5+QB+xeTBN17o7wbc6IXUDu6MM7Mn96oP84i+RLG8+UrXpe2I7y
         GtPL8jEBLfhdp+LO2XcgKBaXi57lcvefDWgMc9cHD8e1rwnofwQnwNzjztF8DbZ6SBmM
         guDMK6CoogJvHT7m81uGWdJ+CoTTUunzZIgXoRPW2XKrndHV87HiAh30fP8Mq6uJav4q
         tdxw==
X-Gm-Message-State: AOAM530QpnzljyFFJJwn0dzbIDuMDRawOc4lYnE6KChMjfozTAoL6Ftr
        +LOoRpczhMPxi7JoZGK9WmLziqJgkg==
X-Google-Smtp-Source: ABdhPJxtXAt2ucB0iCP/Pdg5brnglPh5LWWrnH0mSo9foHncQbGzke0Wp04ae3c/WIWvAeJwUUiW+g==
X-Received: by 2002:a92:850c:: with SMTP id f12mr14495929ilh.86.1590876704870;
        Sat, 30 May 2020 15:11:44 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id w78sm2735698ilk.14.2020.05.30.15.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 15:11:44 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 05/10] x86/percpu: Remove "e" constraint from XADD
Date:   Sat, 30 May 2020 18:11:22 -0400
Message-Id: <20200530221127.459704-6-brgerst@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200530221127.459704-1-brgerst@gmail.com>
References: <20200530221127.459704-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "e" constraint represents a constant, but the XADD instruction doesn't
accept immediate operands.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/percpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 2a24f3c795eb..9bb5440d98d3 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -220,7 +220,7 @@ do {									\
 		break;							\
 	case 8:								\
 		asm qual ("xaddq %0, "__percpu_arg(1)			\
-			    : "+re" (paro_ret__), "+m" (var)		\
+			    : "+r" (paro_ret__), "+m" (var)		\
 			    : : "memory");				\
 		break;							\
 	default: __bad_percpu_size();					\
-- 
2.25.4

