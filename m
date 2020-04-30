Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFC0C47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C3912074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DGkgyiQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgD3Osz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726381AbgD3Osv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:48:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB6EC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:48:51 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d17so7240436wrg.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W2dOZedYL4JDAAn5nSlmNV+ZjvfKthEjodtzNjqCunU=;
        b=DGkgyiQ0NginXnf8otO/F358XbxPMWkiqajyOjWp3qrwhI3IjJ5VxpWltUxTWpeYhi
         EzYTPLQUJPaT54+Gtq8bQ/kq/LVPXUUOLOkSY4quVOuInKuAhg+If+fiiQWZrk8sg4/2
         wucgIlbFqPSMeVyM7Tcx67kTqaT8iYVNoc7mQXwSN0bIG9PAdu2aOyVCUs1RYJDOp7G5
         J6bYFSMfSCNjHyHht0n7BO/pvp6s1HqaBb0j+1ewoIQxJMbwGe4MmXheqZK06lVBoxN9
         Ih1WCF5C/x/zOa0VU71rHZ7tBJxntN008fOtfonZDN0KIx0kOZdvJ4PzQkI7mNQBaWUq
         yiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W2dOZedYL4JDAAn5nSlmNV+ZjvfKthEjodtzNjqCunU=;
        b=l/o3wB620k1D3BIYrZzn6uoNA17Qi5ROtVwL6yU0Tcz1cR6apUSY8BCAQyjNi+yNRw
         CkNJ0qVn1mmWvspc7MYYccqx0DnJBEf9epcwyE9s4gSeLBTqt/RuQgDHL9OeegiXZZt0
         dJbZG+Gb1k8o7Vfw8VCX2T4fUDwkGW3Rvkm4kaQMwU7n3nOYIZaEEfEe5ozPB+/U7dMx
         NIkAGs/6OcdZzWT8txD5LnB7p4idGJQAYSeQrlgzlRcnUYzDxpADQxfE5i3mXG8LBAtO
         jwTlJvcQGNt5r5ZbJjN8y8E1WqQL7we/iSbmhf7AR6QMLKCNfasugNWT5rk4SHz4zy/p
         Jj7A==
X-Gm-Message-State: AGi0PuYIvMYMehnlpSAp9aEIp5uNaVVALtyzCODjqnjsSErcJ0jCGNv8
        KcS1v/7BfqBqY93vk6wlSiAUzg==
X-Google-Smtp-Source: APiQypI092ppnnKBWs4+7y2ui5zUBh7qAbqhxW88bEw98VWLvJPs/WkNEiKJyOlPkCmjk7ivxSWnJQ==
X-Received: by 2002:adf:e445:: with SMTP id t5mr4244456wrm.223.1588258129829;
        Thu, 30 Apr 2020 07:48:49 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d4b6:9828:8bd2:ce6f])
        by smtp.gmail.com with ESMTPSA id b66sm12780787wmh.12.2020.04.30.07.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 07:48:48 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 03/15] arm64: kvm: Fix symbol dependency in __hyp_call_panic_nvhe
Date:   Thu, 30 Apr 2020 15:48:19 +0100
Message-Id: <20200430144831.59194-4-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200430144831.59194-1-dbrazdil@google.com>
References: <20200430144831.59194-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__hyp_call_panic_nvhe contains inline assembly which did not declare
its dependency on the __hyp_panic_string symbol.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 8a1e81a400e0..7a7c08029d81 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -836,7 +836,7 @@ static void __hyp_text __hyp_call_panic_nvhe(u64 spsr, u64 elr, u64 par,
 	 * making sure it is a kernel address and not a PC-relative
 	 * reference.
 	 */
-	asm volatile("ldr %0, =__hyp_panic_string" : "=r" (str_va));
+	asm volatile("ldr %0, =%1" : "=r" (str_va) : "S" (__hyp_panic_string));
 
 	__hyp_do_panic(str_va,
 		       spsr, elr,
-- 
2.26.1

