Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DF3C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C74020656
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581610155;
	bh=Bzhi6lde7OpuvdLPjVRGmFwvB5ok4FRpi36AmEcxJis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z6ezxkUDdZI8k82MH1q+EssFwHbs/DSopuAy/yKs6gGwFMl6A/lsb0CJqhgTPmGNY
	 fZnpXfc/3D8yyPRcjvUab/kP6FLK7csL587EoLsJclg8ti8w5z2LjZQ/RkQYnRyPb6
	 TeACom1atXo32r7/ASlnwADJMZg87y83gcZO74wI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbgBMQJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:09:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbgBMPWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:22:50 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94D3E24699;
        Thu, 13 Feb 2020 15:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607369;
        bh=Bzhi6lde7OpuvdLPjVRGmFwvB5ok4FRpi36AmEcxJis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kpj1E1KsrUGftVC1TP/x+kJsmU6B0BOVUeLogJrvQtDAdik0oqAFrO399rLfZUxwd
         BFVTojHBgrMS6yATU3gRzZvENRO2rXt3MblbSdeZZrjI37tI+ON/whvhsp9JiQJp9T
         VJ4tkRaUS+1QC0aUXrnWw1+fjhRpLc0746f6AVn4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Finco <nifi@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Andrew Honig <ahonig@google.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.4 43/91] KVM: x86: Protect MSR-based index computations in fixed_msr_to_seg_unit() from Spectre-v1/L1TF attacks
Date:   Thu, 13 Feb 2020 07:20:00 -0800
Message-Id: <20200213151838.314721719@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
References: <20200213151821.384445454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marios Pomonis <pomonis@google.com>

commit 25a5edea71b7c154b6a0b8cec14c711cafa31d26 upstream.

This fixes a Spectre-v1/L1TF vulnerability in fixed_msr_to_seg_unit().
This function contains index computations based on the
(attacker-controlled) MSR number.

Fixes: de9aef5e1ad6 ("KVM: MTRR: introduce fixed_mtrr_segment table")

Signed-off-by: Nick Finco <nifi@google.com>
Signed-off-by: Marios Pomonis <pomonis@google.com>
Reviewed-by: Andrew Honig <ahonig@google.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/mtrr.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/mtrr.c
+++ b/arch/x86/kvm/mtrr.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/kvm_host.h>
+#include <linux/nospec.h>
 #include <asm/mtrr.h>
 
 #include "cpuid.h"
@@ -202,11 +203,15 @@ static bool fixed_msr_to_seg_unit(u32 ms
 		break;
 	case MSR_MTRRfix16K_80000 ... MSR_MTRRfix16K_A0000:
 		*seg = 1;
-		*unit = msr - MSR_MTRRfix16K_80000;
+		*unit = array_index_nospec(
+			msr - MSR_MTRRfix16K_80000,
+			MSR_MTRRfix16K_A0000 - MSR_MTRRfix16K_80000 + 1);
 		break;
 	case MSR_MTRRfix4K_C0000 ... MSR_MTRRfix4K_F8000:
 		*seg = 2;
-		*unit = msr - MSR_MTRRfix4K_C0000;
+		*unit = array_index_nospec(
+			msr - MSR_MTRRfix4K_C0000,
+			MSR_MTRRfix4K_F8000 - MSR_MTRRfix4K_C0000 + 1);
 		break;
 	default:
 		return false;


