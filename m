Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23345C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA1EF217D8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578052;
	bh=1wy0WirOesUlf0Qy7uIsgO7rDDX483ubGkN+M/aVb58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qSY9IuihBPbnCW/tEPNCofvbopC8ryomvdMAPcZrO2IrFF7sdflU/5vWb5mwqHlM1
	 yEpq5pBw8TujdFXKWV5WCvkl6PO2hJc/jxAYvYOy6GhCH+bV89xs+XHZ2z7Ie29DO6
	 YFbmc9cF1Wym1WyOcQX83BJ0fC0TI0m6JyWiVYqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbgFSOr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388946AbgFSOrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:47:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A749E2083B;
        Fri, 19 Jun 2020 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578040;
        bh=1wy0WirOesUlf0Qy7uIsgO7rDDX483ubGkN+M/aVb58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0mewY/7n1qQJmoX0BslXplyygoHKhKuIx7YOwnF/QUE/emLLOAZNzcflV7/0+PS5q
         74/wdIeEdo9uQ4zueKgM4BpK3FzI5IGyWAGbYw8Q2CkpuuDYU0klfv76P597picCVr
         IRsoqaFD+dfHrNLlsD5YcaXH1WaHAWZ4IjiQzbrk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 057/190] KVM: nSVM: leave ASID aside in copy_vmcb_control_area
Date:   Fri, 19 Jun 2020 16:31:42 +0200
Message-Id: <20200619141636.424440083@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit 6c0238c4a62b3a0b1201aeb7e33a4636d552a436 upstream.

Restoring the ASID from the hsave area on VMEXIT is wrong, because its
value depends on the handling of TLB flushes.  Just skipping the field in
copy_vmcb_control_area will do.

Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/svm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -2847,7 +2847,7 @@ static inline void copy_vmcb_control_are
 	dst->iopm_base_pa         = from->iopm_base_pa;
 	dst->msrpm_base_pa        = from->msrpm_base_pa;
 	dst->tsc_offset           = from->tsc_offset;
-	dst->asid                 = from->asid;
+	/* asid not copied, it is handled manually for svm->vmcb.  */
 	dst->tlb_ctl              = from->tlb_ctl;
 	dst->int_ctl              = from->int_ctl;
 	dst->int_vector           = from->int_vector;


