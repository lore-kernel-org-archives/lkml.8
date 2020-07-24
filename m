Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC8BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DCC92073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595591097;
	bh=LLNs+7CThyrFBHG8F1QMVfdWnpGJfvWeWZGx27uwsBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ex3a8pcdxXZ32pTQMexchJ/Yzrud/byxWz979iqHa/srMEuuLxSg/k/I6GqYQGbv0
	 Nfw/SMj5TxCqG5rgH8NAellrK3xu5ijKMilvVl59dZ/PThJaEUOlxo2iqL7cQQcDh8
	 tWfmZEHR9BMAq+AjR5sVgjglHakJ45ca3bI7RWFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGXLo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXLox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:44:53 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD2FC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:44:52 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h28so6823841edz.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0gsLhBTns929bqQjKSmleY078/xCezGLLk4wDzFNNps=;
        b=g7igo7eisj06uL4L6JRb3s97UBZBfynmHh3zMqMVQN1xCX4IYGoaU1k9Yd1tyw/egd
         xuwtB4qEAf0niacksfkTzOhw60KYxyQ0RGnCELlQ33RES1eZkHt7kRbkmo+gdFiqh2MU
         gPT2Kp7lVyEVfLCiKgMskZ1sI+DL2SMs6Na0xSNbhLigxjQmNS79ktIHHQDA5d0jXmLy
         TR7ags58mweKK8WtZsTshWgGUXdgr4HqSvRKIBdfc4gwv34wqsNGIJL2i1JVpRPkV811
         Uz3HY66piJ+TY9q/qUSq4VhGqsenOnF0XE9IIYnm7/YvZQ6v+1Xswoyg0PfMN4ALGel0
         skcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0gsLhBTns929bqQjKSmleY078/xCezGLLk4wDzFNNps=;
        b=VST3Aj11iHoSfPxI36P3Wm3PMLfWBJfTIc4Wpe0N07kpzlxEjH+vc+x5sUYV0WwIp2
         DpFAJwdNKrNWhJSBNzK21GmHliDnowlX7xSjqmEKzLZOFV06UovzRX5t1PhvlC1rZpbf
         jm+fM89poBwCHoTarPhAmNdaEuoTa40R2jNXquhNAG8+tmg+WNcjLTLq6Y+3kucYK8Ck
         oB7eHugPZ6dYBQ/EKsNQ9AHdaCTkvnwtNdlu9DZgivBmvZSXAc421X/gxPw8J0GO9mJg
         ozcK7zCtOlpn6u8JKcQgyIpC/frlCP4a4rODNA96lRVTZhhy4XFNpxjDYR9CuxISSzN0
         7lNg==
X-Gm-Message-State: AOAM530XWe4TRe0dzYfpW77LeKINtFYzkWksPi8UXJAAmhvyuzyimsg5
        i/dJi03D6A0MeTaYTKRdIBuy5mJA
X-Google-Smtp-Source: ABdhPJyYKgJVNhc3eyZGcfpwAzY09p8QZMC+BG/x+PjUmCRL1usHbau0m9J2AfPr062/MwLS1por5w==
X-Received: by 2002:a05:6402:1c10:: with SMTP id ck16mr8645092edb.72.1595591090577;
        Fri, 24 Jul 2020 04:44:50 -0700 (PDT)
Received: from localhost.localdomain (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id r5sm580152edx.32.2020.07.24.04.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 04:44:49 -0700 (PDT)
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH 1/3] x86/ioapic: Remove unused "IOAPIC_AUTO" define
Date:   Fri, 24 Jul 2020 13:44:16 +0200
Message-Id: <20200724114418.629021-2-mingo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724114418.629021-1-mingo@kernel.org>
References: <20200724114418.629021-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last use was removed more than 5 years ago, in:

   5ad274d41c1b: ("x86/irq: Remove unused old IOAPIC irqdomain interfaces")

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/io_apic.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index fd20a2334885..a1a26f6d3aa4 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -99,7 +99,6 @@ struct IR_IO_APIC_route_entry {
 struct irq_alloc_info;
 struct ioapic_domain_cfg;
 
-#define IOAPIC_AUTO			-1
 #define IOAPIC_EDGE			0
 #define IOAPIC_LEVEL			1
 
-- 
2.25.1

