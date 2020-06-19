Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB62C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD56421707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584046;
	bh=1A5mgssrvA3C+KZPzFjWGfGOyB9XKTvZZzMVoOXwNnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QcrnSXC+Mdan/H9ubgUbJO6Zls8fwdx8GYu1m8FvuAGYrMLq1zCd1QkG4SGX62CT5
	 AQzfxOE4UsXwwEgpZn6mYqq/4Tg9uXajO7qaNo4um5gJKr9XhOfqpLpiG2M55/sK2G
	 m6KVpgRHLu2pO12IndEzitDvm8qPTffXK7ty8ROU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394717AbgFSQ1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390025AbgFSO4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:56:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 800BC2158C;
        Fri, 19 Jun 2020 14:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578565;
        bh=1A5mgssrvA3C+KZPzFjWGfGOyB9XKTvZZzMVoOXwNnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zW1N8YuNp+ILdDpnnjo4JQBNzxFgBt3XPwyFb9fLWWTZvQmchyWlYes+m61Gj5hpL
         21M2JMM6Oq+TOTQkk3oXgDIfTixvph9NszcePOkfTZbAqV2GTAjys2vUV3teQf8TfG
         7DMaT6I3kAtwNnioPohNKQH5C4XvryhlqnMwaJbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 071/267] KVM: nSVM: fix condition for filtering async PF
Date:   Fri, 19 Jun 2020 16:30:56 +0200
Message-Id: <20200619141652.304477872@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
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
 arch/x86/kvm/svm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3229,8 +3229,8 @@ static int nested_svm_exit_special(struc
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


