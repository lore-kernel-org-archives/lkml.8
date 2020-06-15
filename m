Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D2FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC5720739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5JnA/26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgFOWQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:16:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43350 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726628AbgFOWQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eGLIpLum9/bkEKfHV3oPe4nmlL39+Vf3k9heSN4qJAU=;
        b=d5JnA/26WFMm4GMKiQYcXdRfQEg5KoeHxpDv2CToNEdTUZHS+SmDfvj1r5WCYk1xgAyNrG
        TedhexRk6wr+1Yu5h1Ll6TumNXLNZLrT9612p8QR6JFYd9GJF6zuG3iO/EjGEaM6rBJ05B
        HzUJ4abVCYyw/FXVNtoAAp42bGfKloo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-peet_ZG7PrKxVYYsVuynwg-1; Mon, 15 Jun 2020 18:16:36 -0400
X-MC-Unique: peet_ZG7PrKxVYYsVuynwg-1
Received: by mail-qv1-f71.google.com with SMTP id a8so14139669qvt.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eGLIpLum9/bkEKfHV3oPe4nmlL39+Vf3k9heSN4qJAU=;
        b=nNx3KpvWiZ7GNITsviNmBWIgoDAFUtK8sk3YrCPxvyj6EMYIyOzHS7Cc/LgvQRkyxa
         P2YUFg8USABXqCPVSit0Onl6nG3qSFGWKdOmFFci990YEWwEzjXFC8sA4aKnKOfvhpjC
         piioAGQsqZUZo18Hd778ExysGXE/u02zClu2bLVPLhyh0LmWX9Z0BsLkKCZojp77Tef7
         8aKplvOuBkbixcOKa+xCNjYYMg84VsEVkIpnJUOoJMry5KsLojHgy5oqjKxWLpawdNU+
         1bX4auAfDol1RoA3RKLTLD2EjBM1UrwZI+U4L0FP0k1vJ/fE/hFvxFQLl4zSBzz4fj+w
         P8jQ==
X-Gm-Message-State: AOAM5325cQh4mUh81miTPHu/4HGMpYUcfl7RZxLfxXRyB4s1tVOQ3T3F
        KpWvNyf0/cvU0fQpCCeHzFhdjVPKHzutXqs3sY/29h0ebr+ou//cRYJr/Vkshz4HXUD0xY6/LE7
        XR2DBuqye0MhBoOZBnYlcGqos
X-Received: by 2002:ac8:551a:: with SMTP id j26mr18359196qtq.237.1592259396034;
        Mon, 15 Jun 2020 15:16:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxognUmvVGeEJ3EpmiYCZAJK+S5RL79DtNWeRBIkUTKhLGqRsPOXXqxVvDHrT9aEIO3O5lmRA==
X-Received: by 2002:ac8:551a:: with SMTP id j26mr18359173qtq.237.1592259395830;
        Mon, 15 Jun 2020 15:16:35 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:35 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH 15/25] mm/openrisc: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:15:57 -0400
Message-Id: <20200615221607.7764-16-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615221607.7764-1-peterx@redhat.com>
References: <20200615221607.7764-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new mm_fault_accounting() helper for page fault accounting.

Avoid doing page fault accounting multiple times if the page fault is retried.
Also, the perf events for page faults will be accounted too when the config has
CONFIG_PERF_EVENTS defined.

CC: Jonas Bonn <jonas@southpole.se>
CC: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
CC: Stafford Horne <shorne@gmail.com>
CC: openrisc@lists.librecores.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/openrisc/mm/fault.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 8af1cc78c4fb..594195ae8cdb 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -49,7 +49,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	int si_code;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	tsk = current;
@@ -160,6 +160,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 */
 
 	fault = handle_mm_fault(vma, address, flags);
+	major |= fault & VM_FAULT_MAJOR;
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -176,10 +177,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
 		/*RGD modeled on Cris */
-		if (fault & VM_FAULT_MAJOR)
-			tsk->maj_flt++;
-		else
-			tsk->min_flt++;
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
@@ -193,6 +190,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 
 	up_read(&mm->mmap_sem);
+	mm_fault_accounting(tsk, regs, address, major);
 	return;
 
 	/*
-- 
2.26.2

