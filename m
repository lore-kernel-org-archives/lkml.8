Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A05C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD7D420739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZT9xAav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgFOWQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:16:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45663 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726535AbgFOWQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ls9QmJCLOm68CvolACOW0xbuhdSZty4Jnv9TrFZw+qw=;
        b=iZT9xAav6OMlp5jwF+L2rH1yAohP/ORN7oN9I1tD4BSytP54165Fe/Qx8r/BtektbWNn04
        XUAsiXkmB4jzLJvc9hhC3MDtHua+e9vOpUhUx1eKTXwlS9BgI22wvc6UGqUCTQetgnFdFO
        vxeRSNwQRzemsXpeMJUZ7RC/wAHwWGA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-mn3cfeYsPNOoTEaxZ44aHg-1; Mon, 15 Jun 2020 18:16:21 -0400
X-MC-Unique: mn3cfeYsPNOoTEaxZ44aHg-1
Received: by mail-qt1-f198.google.com with SMTP id x21so15142037qtp.16
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ls9QmJCLOm68CvolACOW0xbuhdSZty4Jnv9TrFZw+qw=;
        b=ruaaphfUrYtRoHRWBvxuqB3mB7DLbFtjfmlUPVwRS7W13FoaRvuh+nc69Qy+nbDjBO
         XAcXH5V3QwMjsQX9gEfM6GKJjaSrtd+tHDN9rENAW0K+Hsw/WN0zRiDokqyIn7EhgYxw
         GZOxp8UgTdCevzumkESh0otSzcZxO0PfGnU/YMUQludou6vd23cXnmos4IOIFYGuiBhn
         hL/2OIIdAUZpjH+bXbdX/ofltEUEDhhIDdx1udpjUjKN2eNRThJy2griJbV22T531His
         U5CvPM1NZ/mk2Y5a5C+XEywYG+yZvOpTx3TW2wIe4U/PSG/Eem+dg2JFcj9Kj3K8QSOw
         kfxQ==
X-Gm-Message-State: AOAM533eIPwnpmt+nGS7avLfuSrNdK+mOimxvY+VPLi6t/yRw+ekc85Z
        lZWpPDy/+W4GbHRs58jPQGz3HQVqktz/KkeKIBfTrz+qvAtGrV/w777LbgViH79jViOE+xDZOkP
        V+2pSOo61EXuQt/cQdDkuNy5a
X-Received: by 2002:a0c:b256:: with SMTP id k22mr4540379qve.115.1592259380199;
        Mon, 15 Jun 2020 15:16:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPmau1M6QKWc6GHncKWYMz7eFkgSphlbSZomzioBm+KJn2NkIvBOjAdW7fQwymnkxPP7AAIg==
X-Received: by 2002:a0c:b256:: with SMTP id k22mr4540360qve.115.1592259380012;
        Mon, 15 Jun 2020 15:16:20 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:19 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/25] mm/arm64: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:15:48 -0400
Message-Id: <20200615221607.7764-7-peterx@redhat.com>
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

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will@kernel.org>
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/mm/fault.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index c9cedc0432d2..09af7d7a60ec 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -484,8 +484,6 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 					 addr, esr, regs);
 	}
 
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
-
 	/*
 	 * As per x86, we may deadlock here. However, since the kernel only
 	 * validly references user space from well defined areas of the code,
@@ -535,20 +533,9 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 			      VM_FAULT_BADACCESS)))) {
 		/*
 		 * Major/minor page fault accounting is only done
-		 * once. If we go through a retry, it is extremely
-		 * likely that the page will be found in page cache at
-		 * that point.
+		 * once.
 		 */
-		if (major) {
-			current->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
-				      addr);
-		} else {
-			current->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
-				      addr);
-		}
-
+		mm_fault_accounting(current, regs, address, major);
 		return 0;
 	}
 
-- 
2.26.2

