Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CE2C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE2524690
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607364;
	bh=HoPYvoEBNfhFq7YxHxFAAPfn70vdc+PTMBDCMsHQFcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PIuuNN5jD8S1PErNp1IZX1yAH49FpI6ioDO+ECjRNRonxHOTYcO850/d2I6blHgLt
	 MN/SrPMZOC9y+4XmeLunMwTxmclQ/XoGa6tqbCwOiCt9xXpQ5RcSRwmMQ2TZ5NEfHP
	 MIuCoXNZMrvR8OdWb20F2oUGyUEavtVt+UspG9MY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgBMPWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727973AbgBMPWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:22:35 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 865CC20848;
        Thu, 13 Feb 2020 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607354;
        bh=HoPYvoEBNfhFq7YxHxFAAPfn70vdc+PTMBDCMsHQFcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QxSqYl1JMvlURIw2Mny+CDZ7MjuIqZ9V1QqC4CuQA4rvuvsq8EjqFScU2DMWyY1Ur
         JlpqR1nbfZRNafbumjEi6ePjDHZZBoKD8Fy//AMYi5FFE9o7333+GxSbDJMBHAap9k
         9xry7oQMfwvsPuNTj1cNKZ84SUANFWl2RL9EOOUI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Finco <nifi@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Andrew Honig <ahonig@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.4 37/91] KVM: x86: Protect kvm_hv_msr_[get|set]_crash_data() from Spectre-v1/L1TF attacks
Date:   Thu, 13 Feb 2020 07:19:54 -0800
Message-Id: <20200213151835.916554087@linuxfoundation.org>
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

commit 8618793750071d66028584a83ed0b4fa7eb4f607 upstream.

This fixes Spectre-v1/L1TF vulnerabilities in kvm_hv_msr_get_crash_data()
and kvm_hv_msr_set_crash_data().
These functions contain index computations that use the
(attacker-controlled) MSR number.

Fixes: e7d9513b60e8 ("kvm/x86: added hyper-v crash msrs into kvm hyperv context")

Signed-off-by: Nick Finco <nifi@google.com>
Signed-off-by: Marios Pomonis <pomonis@google.com>
Reviewed-by: Andrew Honig <ahonig@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/hyperv.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -26,6 +26,7 @@
 #include "hyperv.h"
 
 #include <linux/kvm_host.h>
+#include <linux/nospec.h>
 #include <trace/events/kvm.h>
 
 #include "trace.h"
@@ -53,11 +54,12 @@ static int kvm_hv_msr_get_crash_data(str
 				     u32 index, u64 *pdata)
 {
 	struct kvm_hv *hv = &vcpu->kvm->arch.hyperv;
+	size_t size = ARRAY_SIZE(hv->hv_crash_param);
 
-	if (WARN_ON_ONCE(index >= ARRAY_SIZE(hv->hv_crash_param)))
+	if (WARN_ON_ONCE(index >= size))
 		return -EINVAL;
 
-	*pdata = hv->hv_crash_param[index];
+	*pdata = hv->hv_crash_param[array_index_nospec(index, size)];
 	return 0;
 }
 
@@ -96,11 +98,12 @@ static int kvm_hv_msr_set_crash_data(str
 				     u32 index, u64 data)
 {
 	struct kvm_hv *hv = &vcpu->kvm->arch.hyperv;
+	size_t size = ARRAY_SIZE(hv->hv_crash_param);
 
-	if (WARN_ON_ONCE(index >= ARRAY_SIZE(hv->hv_crash_param)))
+	if (WARN_ON_ONCE(index >= size))
 		return -EINVAL;
 
-	hv->hv_crash_param[index] = data;
+	hv->hv_crash_param[array_index_nospec(index, size)] = data;
 	return 0;
 }
 


