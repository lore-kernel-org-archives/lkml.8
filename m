Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7481BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53FC120739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzLa+9/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgFOWQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:16:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58490 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726601AbgFOWQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1JGrcb4VtJwhM/mfk1pWvCfErRPSyrjF6khDNDw6Ls=;
        b=PzLa+9/dtf9zLCfLhIQq1KCkiBUJ5GtEBcGth+thT/ItsO7uljB1wW8dWrwiPkEEnmYDmT
        qeoswXVs4CPPftH21Sih54IM0iu69JC5oBMIgPmb3p+7Az5nXZwbfW4R/gF5e+NTv8gsYR
        k6qxJm4oO8uPRF0GgqfvEr4eGVHcB8w=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-LS_Tr3mTOuuHXb6o8_lNOw-1; Mon, 15 Jun 2020 18:16:39 -0400
X-MC-Unique: LS_Tr3mTOuuHXb6o8_lNOw-1
Received: by mail-qk1-f197.google.com with SMTP id h18so15410278qkj.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D1JGrcb4VtJwhM/mfk1pWvCfErRPSyrjF6khDNDw6Ls=;
        b=i578vlGPv1IC4S1CwlgvhV8p/sFWLD3Jf0V3sDoLVrjjD50y3v5RXPFlEX3dXDNVKN
         SJh9nPYygq1R9j+KAYtP6gZCzLzVdUNL3KYeHU7wM71DVIsHWx6ArfirCxuyVuwTXbmX
         GenYuSrdyZdzDM/YAeKytTURvVJDwL2EfO9a9+fh2QNAzcOXQjj5R8boNLZ0YWc6juas
         USc1NF1APSGxqGiupmN2G2h6fzO/kx3foEMniLoFvVZc2o3IdGttqrb6EY1FayJdbB8Q
         mkie6fV7uYdoCBgAtyLoAPCz+VHnq+TP7B2jo3MEt7jgAcLhsbB2m7VyvPQCw6ZQLSl5
         vaQA==
X-Gm-Message-State: AOAM533jJM3C4dxvtvb4OqTaOQEzM6UmQ4e88+W/SvRXv61k8jRJJdaC
        wmwYMnfGxJYeotGTQFSQzRymlxibeyquHpLI+WqDoWh8rBFYQX86vvme8NK4A3W59Pig8+qs0pd
        R5ChS02odxAXCkpXSffsiyajA
X-Received: by 2002:ac8:4742:: with SMTP id k2mr18393742qtp.304.1592259399126;
        Mon, 15 Jun 2020 15:16:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwis4xPglPp7o+FOHT5OI+c4AKHHUO1bfH47AyrkUm4D6BUmGSmwgXfC3cp9GJLELgwIXDa2g==
X-Received: by 2002:ac8:4742:: with SMTP id k2mr18393717qtp.304.1592259398932;
        Mon, 15 Jun 2020 15:16:38 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:38 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 17/25] mm/powerpc: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:15:59 -0400
Message-Id: <20200615221607.7764-18-peterx@redhat.com>
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

cmo_account_page_fault() is special.  Keep that.

CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/powerpc/mm/fault.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 84af6c8eecf7..6043b639ae42 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -481,8 +481,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (!arch_irq_disabled_regs(regs))
 		local_irq_enable();
 
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
-
 	if (error_code & DSISR_KEYFAULT)
 		return bad_key_fault_exception(regs, address,
 					       get_mm_addr_key(mm, address));
@@ -604,14 +602,11 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	/*
 	 * Major/minor page fault accounting.
 	 */
-	if (major) {
-		current->maj_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, address);
+	if (major)
 		cmo_account_page_fault();
-	} else {
-		current->min_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);
-	}
+
+	mm_fault_accounting(current, regs, address, major);
+
 	return 0;
 }
 NOKPROBE_SYMBOL(__do_page_fault);
-- 
2.26.2

