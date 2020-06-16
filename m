Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B52FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CB720776
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322517;
	bh=IVn/3drH1clXXqRbqRo2p9VUMcFT+JCYw8LrLMgWf0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qrX1FZqxxWXVa4k47Fcg2LA8vD2U2gO3zl89rEVoWFitmMQ5fL3iWKldshxevbS1S
	 DOSvmRe2Q2zwUiiY71oMwW1KoicjIxYEetIActljEJg1tbX0vUaH7FIxMCF36F4nGo
	 GsNPE5GeWIGYE9T6ZC11uZi3MQ6fMjKkKSSlAdhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbgFPPsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732408AbgFPPsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:48:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3039721473;
        Tue, 16 Jun 2020 15:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322503;
        bh=IVn/3drH1clXXqRbqRo2p9VUMcFT+JCYw8LrLMgWf0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dT0P1by0Dcb0KdekvGEOY/CLj5l0ovI1cX4bx7o0D0WCeMVZ3fUyswf6t+rewsRwT
         MKMu3h8Bhf1Rn9XBPEW/GGfpcD3p+eGvcc0sDDhy0QsQUwDgY3ZDQUTKBjBOGvOaw4
         UVX9n0jqUpOSz2DF3/1z6puJTfnVD8gd5JFz6k6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.7 128/163] KVM: nSVM: fix condition for filtering async PF
Date:   Tue, 16 Jun 2020 17:35:02 +0200
Message-Id: <20200616153112.945946713@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit a3535be731c2a343912578465021f50937f7b099 upstream.

Async page faults have to be trapped in the host (L1 in this case),
since the APF reason was passed from L0 to L1 and stored in the L1 APF
data page.  This was completely reversed: the page faults were passed
to the guest, a L2 hypervisor.

Cc: stable@vger.kernel.org
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/svm/nested.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -834,8 +834,8 @@ int nested_svm_exit_special(struct vcpu_
 			return NESTED_EXIT_HOST;
 		break;
 	case SVM_EXIT_EXCP_BASE + PF_VECTOR:
-		/* When we're shadowing, trap PFs, but not async PF */
-		if (!npt_enabled && svm->vcpu.arch.apf.host_apf_reason == 0)
+		/* Trap async PF even if not shadowing */
+		if (!npt_enabled || svm->vcpu.arch.apf.host_apf_reason)
 			return NESTED_EXIT_HOST;
 		break;
 	default:


