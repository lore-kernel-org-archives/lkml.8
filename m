Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AC8C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97945206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702546;
	bh=dkc3DcPnSfReoLTVZWTryE+VHvgOIvMyhzYaUJQ6280=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZbY4xeXB1L/C9lAn5yQQhYGmzvzYrBmqulln+kWVcVqRQoSlUcIjjUvhSRNQh6KD9
	 r/haMg7VM9NA1kNQxRBF2rofLpSjmsg3wQnbqlm7DTer79IPaEXuexZ2d2v6Zqo1SD
	 6RJB/4se0thQjrC3kaN0Q7OrS34lrNXzpUtSZq/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389990AbgBNRtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:49:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:44130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388555AbgBNP7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:59:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F4B42067D;
        Fri, 14 Feb 2020 15:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695965;
        bh=dkc3DcPnSfReoLTVZWTryE+VHvgOIvMyhzYaUJQ6280=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tSspkLhQDnihXztlp3RZJWkBJX+yAafv9LQy2bpOZzT1brmgkmrcJvHQcAp4TVi7Q
         GFPTa0glBcAZZqxypUOyoBxU/jHhh6nScqDPK1WhrxouQCmEERCcnYoGqN5sm0wpYH
         S+7f8RB2eeUQLh6oP3nVclTOepK8iFgxe21VlFJk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bharata B Rao <bharata@linux.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <sashal@kernel.org>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.5 493/542] KVM: PPC: Book3S HV: Release lock on page-out failure path
Date:   Fri, 14 Feb 2020 10:48:05 -0500
Message-Id: <20200214154854.6746-493-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharata B Rao <bharata@linux.ibm.com>

[ Upstream commit e032e3b55b6f487e48c163c5dca74086f147a169 ]

When migrate_vma_setup() fails in kvmppc_svm_page_out(),
release kvm->arch.uvmem_lock before returning.

Fixes: ca9f4942670 ("KVM: PPC: Book3S HV: Support for running secure guests")
Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 2de264fc31563..5914fbfa5e0a7 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -543,7 +543,7 @@ kvmppc_svm_page_out(struct vm_area_struct *vma, unsigned long start,
 
 	ret = migrate_vma_setup(&mig);
 	if (ret)
-		return ret;
+		goto out;
 
 	spage = migrate_pfn_to_page(*mig.src);
 	if (!spage || !(*mig.src & MIGRATE_PFN_MIGRATE))
-- 
2.20.1

