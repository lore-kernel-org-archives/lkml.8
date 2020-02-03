Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F39C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A5521582
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747936;
	bh=hFnHV7/X+uhrWwYMUhnf5Us8rzASYVsTKI4eJySekBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CLdzHUmj1IK5L8fwEbyx68xoMtQnvGB+iuyLsDcy/TcGezCylaBHDBA2W3egGMduI
	 RLIfA28m9w1VeRGhZb1DNYFdoHx1mUr9xI5Mu260x7dnhynFxks+cWVa2kYHssgRD4
	 qM3+bvxLBhWcXwZdsxQEEH+lzRI5VWkvMdBUuCj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbgBCQiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:38:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730986AbgBCQiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:38:09 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDD6C21582;
        Mon,  3 Feb 2020 16:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747889;
        bh=hFnHV7/X+uhrWwYMUhnf5Us8rzASYVsTKI4eJySekBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XPqBz6bRVeJ16kLVRUMIMSd6jumr2GoT902YIAOMPgRiXyJpfLykTwDoV2TFK88c5
         bR9JtQJFCqgPinr2T1BnCArtxTkRkYvMX8xZoyJWq42wZnSb4K+AHMpjqK3nnfkm69
         cJnrDfUiAI53cEixtJ4BPKg40PVhgS71b6Q7EWGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Michael <fedora.dm0@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 06/23] KVM: PPC: Book3S PR: Fix -Werror=return-type build failure
Date:   Mon,  3 Feb 2020 16:20:26 +0000
Message-Id: <20200203161903.968107761@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161902.288335885@linuxfoundation.org>
References: <20200203161902.288335885@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Michael <fedora.dm0@gmail.com>

[ Upstream commit fd24a8624eb29d3b6b7df68096ce0321b19b03c6 ]

Fixes: 3a167beac07c ("kvm: powerpc: Add kvmppc_ops callback")
Signed-off-by: David Michael <fedora.dm0@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_pr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index ce4fcf76e53e9..eb86a2f26986f 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -2030,6 +2030,7 @@ static int kvm_vm_ioctl_get_smmu_info_pr(struct kvm *kvm,
 {
 	/* We should not get called */
 	BUG();
+	return 0;
 }
 #endif /* CONFIG_PPC64 */
 
-- 
2.20.1



