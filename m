Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2BCC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD2120708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339579;
	bh=Ly0IkmrgmVTdVI+OAkYsXZD7zF/l/VAyYRWTaSoG2EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=19TLfTKovWchy5fcY5uUgxu4MaIw1RE+MKIeCxetTeqdw3oEwBDl0UAR1SWCsgbmb
	 b5DOXgF/ZDfdDwxY3zSmofFsxvQbLaKTXi0BF6K9PRaMMuY65YgD0OBsl0dGys/+1v
	 /3rzfx9fyEaSip33UYakmWAOQk8AFtcplzfpX86c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgBJM7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:59:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729908AbgBJMlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:41:09 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5494020661;
        Mon, 10 Feb 2020 12:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338469;
        bh=Ly0IkmrgmVTdVI+OAkYsXZD7zF/l/VAyYRWTaSoG2EE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PN2pDhF/uvn8lmBzo8zK5uGOFKdRjzSKX0U9nqNtIEl52w7yhADAGniOw1LDiI4EL
         VX0Q601PsnO7T99vavJNhMHHVntcP3LEsPf0uapXp7WzDVdgL4MzG4celP6JHxe8J9
         O7qDs2Fj27KMR7H1z++nfx+/RGVid0VgsVt0pS5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Finco <nifi@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Andrew Honig <ahonig@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.5 232/367] KVM: x86: Protect kvm_hv_msr_[get|set]_crash_data() from Spectre-v1/L1TF attacks
Date:   Mon, 10 Feb 2020 04:32:25 -0800
Message-Id: <20200210122445.662471098@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
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
 arch/x86/kvm/hyperv.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -809,11 +809,12 @@ static int kvm_hv_msr_get_crash_data(str
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
 
@@ -852,11 +853,12 @@ static int kvm_hv_msr_set_crash_data(str
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
 


