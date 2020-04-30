Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA18C47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7991C24961
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="llTRbVie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgD3OtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbgD3Os6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:48:58 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF391C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:48:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 188so2189960wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bbHNVTpXzIBH43k7+53bLmR3Osutfa9At2Hme6Sb9BQ=;
        b=llTRbViex/wVjycqDYpppwsQ0xUzk4iAPlw0uNFjdIhsppV/SKrvZbyK35stLuiFrz
         AUBMsiXjZ6vVVymfv1M2Ih94IKnRUaJ+o0SgAcyJS+ZLfYOlLp2IjBrMMv2h69dKvgSd
         oS11PAuOK+5C2Fh+LaUFFFdZCkeiH/1TK3J3zoHJ5I7xtgGHfnCkOOCuSqvjx4YKceV1
         Fh9LJ1Xy4SFCRK59Fg5/k8WPH9+rjpd/VwKOKWpdUyCxmI8LwsuS2VMQHTR+CSxnLn4O
         EmSNclgJIW+TaBUAkSzTL/tIC3mm2zNJ/14mode5DBV9vfGzVkVSFtYV7BiJV1ezNIzY
         52AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bbHNVTpXzIBH43k7+53bLmR3Osutfa9At2Hme6Sb9BQ=;
        b=s6OOuWUPym6s9+Gb9HiRrCuKyVp8SI2YWqrVSTNbUrcfGs2BzeUp4xkykv+cmnOOTH
         qeVBR1nSuDIhpL/2zBWuBk1V9CpwAnDmDLghuQCG5bHgEAirJA15d9R0ZmLHt0BVHJER
         ZlLIjkMzPNjNiIz/JW6cPfYr1l0+GfGPvxkFNiIMa1jO2mjc+fEXH/6hNzqEICkozCME
         9sXZMY4CXW3wCSeASaAkjKsahRfMeoouHFHGrGuXj3MnFYz3kUlh2mKTNWCs1ldPBCAy
         CKQ/06f2HjTv4n8HFZsaGBJKWBxeR/JiXPpD8dXCE5q/u85NOBNLMhPA056OsNv6UwtN
         pLaw==
X-Gm-Message-State: AGi0Puae+ch47ZlYqEM65A4ncZPYEmr5Oqb6CnPrxLMes+mn+5NLPTiA
        EQfVvfpNLBmpT8MXc6shf7OTcQ==
X-Google-Smtp-Source: APiQypKHpehC+NoZtiH6O1b+EgH40+ocC2ldPt1fuV9Crb6tjR/KtOsD6F8IOBtbo+KoSxGe4rMN3g==
X-Received: by 2002:a05:600c:2c04:: with SMTP id q4mr3264060wmg.7.1588258136239;
        Thu, 30 Apr 2020 07:48:56 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d4b6:9828:8bd2:ce6f])
        by smtp.gmail.com with ESMTPSA id c10sm4180096wru.48.2020.04.30.07.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 07:48:55 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 06/15] arm64: kvm: Move __smccc_workaround_1_smc to .rodata
Date:   Thu, 30 Apr 2020 15:48:22 +0100
Message-Id: <20200430144831.59194-7-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200430144831.59194-1-dbrazdil@google.com>
References: <20200430144831.59194-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This snippet of assembly is used by cpu_errata.c to overwrite parts of KVM hyp
vector. It is never directly executed, so move it from .text to .rodata.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/hyp-entry.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 5986e1d78d3f..7e5f386c5c2d 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -364,6 +364,11 @@ SYM_CODE_END(__bp_harden_hyp_vecs)
 	.popsection
 
 #ifndef __HYPERVISOR__
+	/*
+	 * This is not executed directly and is instead copied into the vectors
+	 * by install_bp_hardening_cb().
+	 */
+	.pushsection	.rodata
 SYM_CODE_START(__smccc_workaround_1_smc)
 	esb
 	sub	sp, sp, #(8 * 4)
@@ -377,5 +382,6 @@ SYM_CODE_START(__smccc_workaround_1_smc)
 1:	.org __smccc_workaround_1_smc + __SMCCC_WORKAROUND_1_SMC_SZ
 	.org 1b
 SYM_CODE_END(__smccc_workaround_1_smc)
+	.popsection
 #endif /* __HYPERVISOR__ */
 #endif /* CONFIG_KVM_INDIRECT_VECTORS */
-- 
2.26.1

