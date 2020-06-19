Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876CFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5FF20734
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592585556;
	bh=uzuLMGAdePRGslzSUmlWNQk/hLWre2Me6fiHtWNIbtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xe+Mzz45ooRzHgGWg+v2aHafiEkiCgre+sbl33EdFkUVT/o7JnZMfM8hmXPJOejQD
	 wognAgnEOnawRtXOmuZ+j8hhKcFjkFSFTCX83ZxXq9u9JV3uV5Gh0iyutaFJtySZEu
	 TAtYVurcgqCq/KYo7AADzEjlARQnrW+DMGkTXOq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405963AbgFSQwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgFSOhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:37:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FA3D2158C;
        Fri, 19 Jun 2020 14:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577472;
        bh=uzuLMGAdePRGslzSUmlWNQk/hLWre2Me6fiHtWNIbtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=on4UhB3Ojcn7IjGIYgtpWgExnGkN9IWq7tOt+Dt7FZ35BfDzxPwC1VmSMN1+Pyn12
         Q5NH0xA6gcxdn53nZSU7zo9pcudyGlieF0cV/mU/MYC25rJD5VBGCrWGFCO0bMUgrt
         6cNXFGZFciKxeQlw/J9+b/7xq8CrAYq7Ig/+oN1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.4 035/101] KVM: nSVM: leave ASID aside in copy_vmcb_control_area
Date:   Fri, 19 Jun 2020 16:32:24 +0200
Message-Id: <20200619141615.953939874@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141614.001544111@linuxfoundation.org>
References: <20200619141614.001544111@linuxfoundation.org>
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
@@ -2250,7 +2250,7 @@ static inline void copy_vmcb_control_are
 	dst->iopm_base_pa         = from->iopm_base_pa;
 	dst->msrpm_base_pa        = from->msrpm_base_pa;
 	dst->tsc_offset           = from->tsc_offset;
-	dst->asid                 = from->asid;
+	/* asid not copied, it is handled manually for svm->vmcb.  */
 	dst->tlb_ctl              = from->tlb_ctl;
 	dst->int_ctl              = from->int_ctl;
 	dst->int_vector           = from->int_vector;


