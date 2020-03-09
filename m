Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78956C2BB57
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB7B20727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ns/e6viG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgCIQ4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:56:05 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54314 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbgCIQz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:55:59 -0400
Received: by mail-pj1-f67.google.com with SMTP id np16so107451pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 09:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOiyM2uGzUc6zhWPwWC3bZJGaa62phcZiPuWR1LO/LM=;
        b=ns/e6viGugpe2sBeszGUW3QpCkeJB8MrYvhnEDHtLsFIns1NbWHZCL4O++HLMpG59o
         OZToMHr8HqtFaeMZgdNI84bo+KkGHLigFMo+d557Yf4W/0SCXPOxAR0fPP/oIGxXRiiD
         LHdnMeG+3aSl9JsQ/5GggSq9GjcobzY+pOknrKIhwPyWslWvDxaC68QjgxC6SxFtzJB7
         cQlkoW32VTwAAVI8vxofLhcOEi5csCrBNqTk7V67L+mxKL56djRSWtTmsyr3JvCLagfE
         XRZurknzTeTBKkXhpY8VNvKYhZoKPi61wa33hrG1ryx8icKuHvQHhb7RUYT0btO1mTUB
         fWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOiyM2uGzUc6zhWPwWC3bZJGaa62phcZiPuWR1LO/LM=;
        b=IlfNGDtAhlZc5gosDNIwGZQn6A6l1YtfiWqS2LsEPFDaK2bHRq0AVdC3zlR7ZnCO4F
         XCyZAF2/bM11OpKGbakFrpC/fS/Q3DbKGUl5y8KjykqJTqODllGy4smhY4VtIcebDTUd
         mD6aPgWVKxc32z5f2pt708oR/Rl4EyoVZQeJcZCKNqm+LwuElzWnLcxzHxUEK4F7P6Lw
         iCWA2PVtmDm9Rw24tgIUbnGK24GgUmUASJrpgXvbO8lmU4KUQmgPvtRyQ5EhGwGsaPI4
         C6dRDVE0G8BMgyveJ+qegwk+y0b7x1s1ZbOmEHDonf2j5caRIObodPJ2xkTrbHZDqGtx
         YWWQ==
X-Gm-Message-State: ANhLgQ0acXp/1H+4f2ruBO9TJVN2Xp723jjtu50pGit6waBb1yzUiIzx
        /TJJzH9eJw++QrwuhwAmvyXbpw==
X-Google-Smtp-Source: ADFU+vuMwySfy4aW6l0eigB7My7EMmZrzIS9bpASt5EBC14RkPz9zUaM1SfXngLklZVJnawwvD3fJQ==
X-Received: by 2002:a17:902:aa98:: with SMTP id d24mr16957575plr.106.1583772958869;
        Mon, 09 Mar 2020 09:55:58 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id cm2sm104013pjb.23.2020.03.09.09.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 09:55:58 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 4/9] riscv: move exception table immediately after RO_DATA
Date:   Tue, 10 Mar 2020 00:55:39 +0800
Message-Id: <5c80357b06faf1caed8fbab2d4dc57a2cbeb8b94.1583772574.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583772574.git.zong.li@sifive.com>
References: <cover.1583772574.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move EXCEPTION_TABLE immediately after RO_DATA. Make it easy to set the
attribution of the sections which should be read-only at a time.
Add _data to specify the start of data section with write permission.
This patch is prepared for STRICT_KERNEL_RWX support.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/kernel/vmlinux.lds.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 1e0193ded420..02e948b620af 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -58,6 +58,10 @@ SECTIONS
 		*(.srodata*)
 	}
 
+	EXCEPTION_TABLE(0x10)
+
+	_data = .;
+
 	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
 	.sdata : {
 		__global_pointer$ = . + 0x800;
@@ -69,8 +73,6 @@ SECTIONS
 
 	BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
 
-	EXCEPTION_TABLE(0x10)
-
 	.rel.dyn : {
 		*(.rel.dyn*)
 	}
-- 
2.25.1

