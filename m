Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49423C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 269F120B80
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520375;
	bh=vXYk7JUvoeakSGmPKmqeDoVsAFE/QUqU1NhtnvOHL0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EpzrJ8phq3HL/TCibIlFCflTMuUDb7aMEnFh/pxu/oP1eBAF9i4wwAYOb8c/pj2wM
	 B1A5T672esKVDxt1+SShAngiQKnH9yc0LO/USwR2OYCHxLtVlDz6DNzJYfZz251RsS
	 74uPSgqGtcUtBxwSgnjiElknrOFikUoq0L+gBZ6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404147AbgEZTMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392126AbgEZTMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:12:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D37C20C56;
        Tue, 26 May 2020 19:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520369;
        bh=vXYk7JUvoeakSGmPKmqeDoVsAFE/QUqU1NhtnvOHL0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGtk8f0Ybhmygo7L3lFaO08K0az6Wg8sHG4uX53EnGpoG9CGBcYWgNDzAl4inLYSR
         Y9/ahYPkV3waY0cqqsbHFy4vk3KppeYVRJzdRON7Zh1iRhLbMoMGvLTMQPWck0o0i3
         v/U2Ja3r41U+MgKXdAaesBHaFoDKAVM/+kVoEggU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 052/126] KVM: selftests: Fix build for evmcs.h
Date:   Tue, 26 May 2020 20:53:09 +0200
Message-Id: <20200526183942.429523625@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

[ Upstream commit 8ffdaf9155ebe517cdec5edbcca19ba6e7ee9c3c ]

I got this error when building kvm selftests:

/usr/bin/ld: /home/xz/git/linux/tools/testing/selftests/kvm/libkvm.a(vmx.o):/home/xz/git/linux/tools/testing/selftests/kvm/include/evmcs.h:222: multiple definition of `current_evmcs'; /tmp/cco1G48P.o:/home/xz/git/linux/tools/testing/selftests/kvm/include/evmcs.h:222: first defined here
/usr/bin/ld: /home/xz/git/linux/tools/testing/selftests/kvm/libkvm.a(vmx.o):/home/xz/git/linux/tools/testing/selftests/kvm/include/evmcs.h:223: multiple definition of `current_vp_assist'; /tmp/cco1G48P.o:/home/xz/git/linux/tools/testing/selftests/kvm/include/evmcs.h:223: first defined here

I think it's because evmcs.h is included both in a test file and a lib file so
the structs have multiple declarations when linking.  After all it's not a good
habit to declare structs in the header files.

Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20200504220607.99627-1-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/include/evmcs.h  | 4 ++--
 tools/testing/selftests/kvm/lib/x86_64/vmx.c | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/evmcs.h b/tools/testing/selftests/kvm/include/evmcs.h
index 4912d23844bc..e31ac9c5ead0 100644
--- a/tools/testing/selftests/kvm/include/evmcs.h
+++ b/tools/testing/selftests/kvm/include/evmcs.h
@@ -217,8 +217,8 @@ struct hv_enlightened_vmcs {
 #define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_MASK	\
 		(~((1ull << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) - 1))
 
-struct hv_enlightened_vmcs *current_evmcs;
-struct hv_vp_assist_page *current_vp_assist;
+extern struct hv_enlightened_vmcs *current_evmcs;
+extern struct hv_vp_assist_page *current_vp_assist;
 
 int vcpu_enable_evmcs(struct kvm_vm *vm, int vcpu_id);
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/vmx.c b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
index 7aaa99ca4dbc..ce528f3cf093 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
@@ -17,6 +17,9 @@
 
 bool enable_evmcs;
 
+struct hv_enlightened_vmcs *current_evmcs;
+struct hv_vp_assist_page *current_vp_assist;
+
 struct eptPageTableEntry {
 	uint64_t readable:1;
 	uint64_t writable:1;
-- 
2.25.1



