Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DEAC352A1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBABA21741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPC80VCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgBEMao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:30:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49160 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727999AbgBEMan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580905842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FZ3Fjj0BjzHheqix1bmWtGQyTCVbBm91zCQKiRJjeoc=;
        b=BPC80VCMg0sbdv86KZrDCm8HS8doLuNB3nmSjvc+qFAaU9+N6RIB0Ep3/FEu3AY8UKPniO
        QQonPk8pMm9zoY5S0AYIHHL6xQmp2XqBLlqJ/I0gOaCcQMgmk6X2P242nFHyyMhAmRV2HK
        nVxooeV/hU5u6eq10l5KOFodYyLG++Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-0VKi6KvpMDqzta3gmm1XAg-1; Wed, 05 Feb 2020 07:30:38 -0500
X-MC-Unique: 0VKi6KvpMDqzta3gmm1XAg-1
Received: by mail-wm1-f71.google.com with SMTP id q125so781204wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 04:30:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FZ3Fjj0BjzHheqix1bmWtGQyTCVbBm91zCQKiRJjeoc=;
        b=n3wYGpSN0pcgNKjsTSfJL/HiZnVsbaRQ8HMoU35LpxEmLd503XKfhmUTZBm6QjiDN5
         rAORqKILE1+nhKwOARXDD43Mp1CUGpSGeqR8rIZLSAahnklRqFm63xhF7nDKu5uUvo3f
         fT3rZ8NaYDBuLDjbCjQCWdK7fjyNL4L38ZXSXmSbwUDtevHEef4/XS7W8mpD9O+X3nDh
         oIQ7z1pcPC+UKNJ/SK9pY6YcDJsU6o1+WWrdDF6dSDntzRnlYF+V/Vb6Ds8Ngd1NmN/f
         FdGca8cBi89/3oQcNPmkhRArwLUbN07XCVxSypRE1ixdjnV/+Rtpz/axMnWfSxe6EPI+
         cH+w==
X-Gm-Message-State: APjAAAVRLjDy0ml+F/nx0uzpG0YR7rcjkJBZxxfVljZCub6Lp4Kj1g/u
        EBDH2JK7TgT0D+jVcRuVX6QqoUqcS5ih5YUFhbDnCU7PrhZAItYV9fYy45cx118zedmx7ib6Xjl
        g/dPJUjHIGQvufpseseK/2nRu
X-Received: by 2002:a5d:6802:: with SMTP id w2mr27773569wru.353.1580905837150;
        Wed, 05 Feb 2020 04:30:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6xei4lJJtlxIHzm0eIiTXbZ2RJ6mzDj5iTZMvHZSp+m6YI7Hhbrz63uThgLSRStvcrZPzPw==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr27773549wru.353.1580905836907;
        Wed, 05 Feb 2020 04:30:36 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g7sm34227251wrq.21.2020.02.05.04.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 04:30:36 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: [PATCH 0/3] x86/kvm/hyper-v: fix enlightened VMCS & QEMU4.2
Date:   Wed,  5 Feb 2020 13:30:31 +0100
Message-Id: <20200205123034.630229-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With fine grained VMX feature enablement QEMU>=4.2 tries to do KVM_SET_MSRS
with default (matching CPU model) values and in case eVMCS is also enabled,
fails. While the regression is in QEMU, it may still be preferable to
fix this in KVM.

It would be great if we could just omit the VMX feature filtering in KVM
and make this guest's responsibility: if it switches to using enlightened
vmcs it should be aware that not all hardware features are going to be
supported. Genuine Hyper-V, however, fails the test. It, for example,
enables SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES and without
'apic_access_addr' field in eVMCS there's not much we can do in KVM.
Microsoft confirms the bug but it is unclear if it will ever get fixed
in the existing Hyper-V versions as genuine Hyper-V never exposes
these unsupported controls to L1.

Changes since 'RFC':
- Go with the bare minimum [Paolo]

KVM RFC:
https://lore.kernel.org/kvm/20200115171014.56405-1-vkuznets@redhat.com/

QEMU RFC@:
https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg00123.html

Vitaly Kuznetsov (3):
  x86/kvm/hyper-v: remove stale evmcs_already_enabled check from
    nested_enable_evmcs()
  x86/kvm/hyper-v: move VMX controls sanitization out of
    nested_enable_evmcs()
  x86/kvm/hyper-v: don't allow to turn on unsupported VMX controls for
    nested guests

 arch/x86/kvm/vmx/evmcs.c  | 90 ++++++++++++++++++++++++++++++++++-----
 arch/x86/kvm/vmx/evmcs.h  |  3 ++
 arch/x86/kvm/vmx/nested.c |  3 ++
 arch/x86/kvm/vmx/vmx.c    | 16 ++++++-
 4 files changed, 99 insertions(+), 13 deletions(-)

-- 
2.24.1

