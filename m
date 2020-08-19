Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E1BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E52142063A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjtBb2bH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgHSVUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:20:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30285 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727045AbgHSVUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597871999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d8aaFslZMGhZl5AC1zF/8lKFp9QgGd2sl23QtosnVQs=;
        b=AjtBb2bHupOhnOUy+RV7vqaXo+7oM7rgeMozMdy9Rm8BC1430fcU12iwDmAsMwQHviKTYP
        k2Tl4R831xTQx9aBQY/9cXXqNf2dR+3DYbn2+QUNHB+yT5iZVcCpJVdicaQ/lULr6348Ba
        ZzEgiJaPBdc2qEqZ3Khr1u/7mIPX7yk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-Jq55kAs_MZOrQxIrFE_Q2Q-1; Wed, 19 Aug 2020 17:19:55 -0400
X-MC-Unique: Jq55kAs_MZOrQxIrFE_Q2Q-1
Received: by mail-qv1-f71.google.com with SMTP id x4so16487575qvu.18
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 14:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d8aaFslZMGhZl5AC1zF/8lKFp9QgGd2sl23QtosnVQs=;
        b=seV510J37Q5jlUuB5tzptXO8E570m3zF0ItXxhXLtN3YSf0lnMre5OndS6P4TWnwAH
         WiRQ0ruVUkBn+wyJXmPQb0hEfp80biwXVThgBc5jYCCM3xkvNFvEfPywBUWQDDWQ0GFs
         49FOcnTZkUfW+Pt0FjlTDwZaIOKM/OhXPZGI2x5EekXNCc8wNAU/L0cNKfmiEdwzB15U
         rPQrF0TwrEcsJcxVDphlLzZ2otIOD4QfYj1+3xDy7Uzq2775ExKZRQR+ZML7FqcBNMbD
         +N07Ih0cXwSQ4naVE0a+QBnEvX7B92LJvp3jlcVGs81nMBFUAjdE7Ev7iVLzGMMdSrky
         IQoQ==
X-Gm-Message-State: AOAM531uKXSi0Rd/FFNjV5u01eyZQVO2a0fRuftJL0lZIGST0MPlF0rs
        OqPdk+0ZxxcFXUkGNMYNt5i4mxUELOry3/9uM97ju++xMc3TzVX36tpm6FxqinTC4H+tS4DdJDU
        nUaIUjqy6Mvmf+ZglqnLBoTiF
X-Received: by 2002:a0c:b52b:: with SMTP id d43mr176166qve.158.1597871995082;
        Wed, 19 Aug 2020 14:19:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZf9ipn4932x+sExi1EY3BDhNG2nHiznmd/NazsmDhrrID6yRlma/qKP18WfWZY0hWvSKjuw==
X-Received: by 2002:a0c:b52b:: with SMTP id d43mr176150qve.158.1597871994866;
        Wed, 19 Aug 2020 14:19:54 -0700 (PDT)
Received: from redhat.redhat.com (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id d198sm25876478qke.129.2020.08.19.14.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 14:19:54 -0700 (PDT)
From:   Connor Kuehl <ckuehl@redhat.com>
To:     corbet@lwn.net, pbonzini@redhat.com
Cc:     kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: kvm: fix referenced ioctl symbol
Date:   Wed, 19 Aug 2020 16:19:52 -0500
Message-Id: <20200819211952.251984-1-ckuehl@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual symbol that is exported and usable is
'KVM_MEMORY_ENCRYPT_OP', not 'KVM_MEM_ENCRYPT_OP'

$ git grep -l KVM_MEM_ENCRYPT_OP
Documentation/virt/kvm/amd-memory-encryption.rst

$ git grep -l KVM_MEMORY_ENCRYPT_OP
Documentation/virt/kvm/api.rst
arch/x86/kvm/x86.c
include/uapi/linux/kvm.h
tools/include/uapi/linux/kvm.h

While we're in there, update the KVM API category for
KVM_MEMORY_ENCRYPT_OP. It is called on a VM file descriptor.

Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
---
 Documentation/virt/kvm/amd-memory-encryption.rst | 6 +++---
 Documentation/virt/kvm/api.rst                   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/virt/kvm/amd-memory-encryption.rst b/Documentation/virt/kvm/amd-memory-encryption.rst
index 2d44388438cc..09a8f2a34e39 100644
--- a/Documentation/virt/kvm/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/amd-memory-encryption.rst
@@ -53,11 +53,11 @@ key management interface to perform common hypervisor activities such as
 encrypting bootstrap code, snapshot, migrating and debugging the guest. For more
 information, see the SEV Key Management spec [api-spec]_
 
-The main ioctl to access SEV is KVM_MEM_ENCRYPT_OP.  If the argument
-to KVM_MEM_ENCRYPT_OP is NULL, the ioctl returns 0 if SEV is enabled
+The main ioctl to access SEV is KVM_MEMORY_ENCRYPT_OP.  If the argument
+to KVM_MEMORY_ENCRYPT_OP is NULL, the ioctl returns 0 if SEV is enabled
 and ``ENOTTY` if it is disabled (on some older versions of Linux,
 the ioctl runs normally even with a NULL argument, and therefore will
-likely return ``EFAULT``).  If non-NULL, the argument to KVM_MEM_ENCRYPT_OP
+likely return ``EFAULT``).  If non-NULL, the argument to KVM_MEMORY_ENCRYPT_OP
 must be a struct kvm_sev_cmd::
 
        struct kvm_sev_cmd {
diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index eb3a1316f03e..506c8426c583 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -4211,7 +4211,7 @@ H_GET_CPU_CHARACTERISTICS hypercall.
 
 :Capability: basic
 :Architectures: x86
-:Type: system
+:Type: vm
 :Parameters: an opaque platform specific structure (in/out)
 :Returns: 0 on success; -1 on error
 
-- 
2.25.4

