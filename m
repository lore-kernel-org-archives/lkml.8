Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA0DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7DC20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825317;
	bh=F4Q7GLdIdRElMbXOmwNR/YQ1sfbeM3UBi5JtX1D5sPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SrruS7OzAmWF3kQz3np5Gjz8mjfIq4MMR64Vltx+kkVzeMQvz/V/Y8CM+avgUxLtF
	 vRWzFiu8cYzUvuoG269IAXHsmu9R0A8jVhaadklK0jd5+JlCCfPfJAddOGcKcDz8wH
	 H5SorfLax5uWkvrQ9fZNijrW4X063ROA1axYvrLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733065AbgERSHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:07:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387415AbgERSHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:07:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7885207D3;
        Mon, 18 May 2020 18:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825252;
        bh=F4Q7GLdIdRElMbXOmwNR/YQ1sfbeM3UBi5JtX1D5sPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJujb9Bh5K2nLi/X2bjKTX7F2Uo578ifUiIDp8kTDOGwncvqZ/vETGNmbHLfvWKNs
         nxip5yufopBxRVyq/NgKb5klmkkUVf83Xsj9+Wom9TzxPlYdO8NyBvjMbqEnXTL38w
         2oJy2oXB6Xw9rjqNt1Z0cGwtqPKeqrwV/tzDPF+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jue Wang <juew@google.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.6 190/194] KVM: x86: Fix off-by-one error in kvm_vcpu_ioctl_x86_setup_mce
Date:   Mon, 18 May 2020 19:38:00 +0200
Message-Id: <20200518173547.237107348@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Mattson <jmattson@google.com>

commit c4e0e4ab4cf3ec2b3f0b628ead108d677644ebd9 upstream.

Bank_num is a one-based count of banks, not a zero-based index. It
overflows the allocated space only when strictly greater than
KVM_MAX_MCE_BANKS.

Fixes: a9e38c3e01ad ("KVM: x86: Catch potential overrun in MCE setup")
Signed-off-by: Jue Wang <juew@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
Message-Id: <20200511225616.19557-1-jmattson@google.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3739,7 +3739,7 @@ static int kvm_vcpu_ioctl_x86_setup_mce(
 	unsigned bank_num = mcg_cap & 0xff, bank;
 
 	r = -EINVAL;
-	if (!bank_num || bank_num >= KVM_MAX_MCE_BANKS)
+	if (!bank_num || bank_num > KVM_MAX_MCE_BANKS)
 		goto out;
 	if (mcg_cap & ~(kvm_mce_cap_supported | 0xff | 0xff0000))
 		goto out;


