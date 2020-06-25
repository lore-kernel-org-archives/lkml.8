Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C43C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A6020706
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ua7P+YZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404918AbgFYNOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404884AbgFYNOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:14:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD16C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:14:32 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a6so6715451wmm.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wraev6ZBkvjCXqVdZoeks0aAoF06EDUQslGWSfcwelE=;
        b=ua7P+YZJwVqfWDyuPBaOjCABX1tSBuIIGIhiG1M2l3I9pUVwlIpIaLg4tk1vR6DAEh
         xQUnQ2orukTjqBWFut7xqaSuDXy3DXYDlYGhTELnZtsUvD/Cd3xIEN/CKH74JI9PA6Nd
         rKmturGSVa/8/WsP6oa76tKofsgGbvmi2qPtMaPE9UnhUkfeIXrHGwoUuXQLnVbgGfCp
         ucEEpOl318TFEhm1s0ykC4Twr8wGoZHtkpkL58rV/Y3cfXmvJcJiWP/Ry9azYYe//N5v
         mJmJzCEebK98IQhJoPjkGbS7E29bK4nED+seNPErBGhKnMyITD3dUnEHtjk8780W46ud
         Motg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wraev6ZBkvjCXqVdZoeks0aAoF06EDUQslGWSfcwelE=;
        b=gTEtCvZmy2V488ooiTKj6HAwfxG4/HLqz5aSXWeC4FTLCQ0feeu1qpHp3CoUBhDmRs
         t3tVRFFWVG/s1L9Q5IMplL5JlTG38nlYXcdkpjUxanYyHN5qWgXUSPJdx3CTcUb9grUx
         W7qiSh7iw102LIGRhIM+M5UopKM7HfustZ05GA1dEdtHSen5LBkC1XwTIC+6xell2UT/
         FeE3bv5qjfHl/gS9zpVusD/4HcPMcb2JFSz9mtwGddc23LzkZWWHomIJzV3b7BAbRV79
         kQKI74NBBfU89Rc0V3ysiGpiDaBLsfWNkze5HX5sPqXtEVKj+ipAujZ3Gii/fMyHUXZg
         q0lg==
X-Gm-Message-State: AOAM53329WX5YxeUoy7Ieir57SdSa2NE74qqYGdu9r3BPYriy4dwwlmH
        v38sWTrmcYvMZITaqz312Pobxg==
X-Google-Smtp-Source: ABdhPJwSD6tTR4A51iFYqmD+o4uh7mMxnCrC2utrSiSA099BJejStzsjCmFzuSX9rIPS1ekV3bn+rQ==
X-Received: by 2002:a1c:a3c5:: with SMTP id m188mr3259403wme.152.1593090871469;
        Thu, 25 Jun 2020 06:14:31 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:c126:6748:7a9d:2d])
        by smtp.gmail.com with ESMTPSA id 30sm28006922wrm.74.2020.06.25.06.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 06:14:30 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v4 04/15] arm64: kvm: Use build-time defines in has_vhe()
Date:   Thu, 25 Jun 2020 14:14:09 +0100
Message-Id: <20200625131420.71444-5-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200625131420.71444-1-dbrazdil@google.com>
References: <20200625131420.71444-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build system compiles hyp code with macros specifying if the code belongs
to VHE or nVHE. Use these macros to evaluate has_vhe() at compile time.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/virt.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 5051b388c654..09977acc007d 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -85,10 +85,17 @@ static inline bool is_kernel_in_hyp_mode(void)
 
 static __always_inline bool has_vhe(void)
 {
-	if (cpus_have_final_cap(ARM64_HAS_VIRT_HOST_EXTN))
+	/*
+	 * The following macros are defined for code specic to VHE/nVHE.
+	 * If has_vhe() is inlined into those compilation units, it can
+	 * be determined statically. Otherwise fall back to caps.
+	 */
+	if (__is_defined(__KVM_VHE_HYPERVISOR__))
 		return true;
-
-	return false;
+	else if (__is_defined(__KVM_NVHE_HYPERVISOR__))
+		return false;
+	else
+		return cpus_have_final_cap(ARM64_HAS_VIRT_HOST_EXTN);
 }
 
 #endif /* __ASSEMBLY__ */
-- 
2.27.0

