Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D9DC11D13
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1513207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9QKLynW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgBTRWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:22:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29090 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728799AbgBTRWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582219335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rZyXD5q+onhmCDPHKZnUNJAstGhWUGrhi7Vh7fDt5g0=;
        b=a9QKLynW6RUm++W22qLQQxtWjevCgd061TBDDHsrTYQ6nYITuvStFDXPItVzdd71dDodCt
        0SytloLUuu3DN5cT6yVU0mJQ160bta3lGis185UIHS/akE7F+Gpx/wV6nlCXbo1fMQZctF
        V4KOxWt2xRTfurypSgVE2+WKcZBKNEs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-bcBnArHeOgy92JiMr2GuWw-1; Thu, 20 Feb 2020 12:22:10 -0500
X-MC-Unique: bcBnArHeOgy92JiMr2GuWw-1
Received: by mail-wr1-f70.google.com with SMTP id j4so2029701wrs.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 09:22:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZyXD5q+onhmCDPHKZnUNJAstGhWUGrhi7Vh7fDt5g0=;
        b=q0KB22nB86Vm42SNonRqycJ9i6a0JD9i1t08HZgq5r5sRkImIik0uFDHLgEE74W7AM
         dQv81NlwrpztfJHfS9tVRri2ipOZR4Kt00Uy554BF5WwIEA0yjwLszgIPbLP+FMo7V3p
         3NeFr3Iwjn2oZe9n+ynMJTpr1VFrhpXKhaLLp5NTc9vXsnKTGizwCxxo1ZFV+5+h32Qj
         1Tp98ri3/m0Z5LX68HCAwbSpZQ+tc645EEFCCDLrLIvFQeq4uJgVgPUb79tqXTF2QamF
         MPBOLAom+PE8T9USuC4UJvkBsiBY3s8pFZr+hmzXfx7Qrjny54xLllXKg1khRBRIyiLy
         BHZA==
X-Gm-Message-State: APjAAAU5BfubofoNihtjTPlMEr8gUV7R9wXg3uzEGSl0/z2KlSpewnFE
        w/AxuRC10x6tje8HgJZ7E0v8b/odwo7UB2+G4/9769CFLVjFq8tGnHo4Prf5890GK7j065bXcbo
        OMxTnFhgQnGil1IqF2uwuYCCx
X-Received: by 2002:adf:fd87:: with SMTP id d7mr45699843wrr.226.1582219328193;
        Thu, 20 Feb 2020 09:22:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqyznpk/Mju2cxo6UDLosBl/WALhWP2M64Z82L2SgtLE3m4B2Qb1Kh7smxIT3jRFYoOJt4jZkQ==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr45699820wrr.226.1582219327916;
        Thu, 20 Feb 2020 09:22:07 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a184sm5355891wmf.29.2020.02.20.09.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:22:07 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/2] KVM: nVMX: fix apicv disablement for L1
Date:   Thu, 20 Feb 2020 18:22:03 +0100
Message-Id: <20200220172205.197767-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that fine-grained VMX feature enablement in QEMU is broken
when combined with SynIC:

    qemu-system-x86_64 -machine q35,accel=kvm -cpu host,hv_vpindex,hv_synic -smp 2 -m 16384 -vnc :0
    qemu-system-x86_64: error: failed to set MSR 0x48d to 0xff00000016
    qemu-system-x86_64: <...>: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
    Aborted

QEMU thread: https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg04838.html

Turns out, this is a KVM issue: when SynIC is enabled, PIN_BASED_POSTED_INTR
gets filtered out from VMX MSRs for all newly created (but not existent!)
vCPUS. Patch1 addresses this. Also, apicv disablement for L1 doesn't seem
to disable it for L2 (at least on CPU0) so unless there's a good reason
to not allow this we need to make it work. PATCH2, suggested by Paolo,
is supposed to do the job.

RFC: I looked at the code and ran some tests and nothing suspicious popped
out, however, I'm still not convinced this is a good idea to have apicv
enabled for L2 when it's disabled for L1... Also, we may prefer to merge
or re-order these two patches.

Vitaly Kuznetsov (2):
  KVM: nVMX: clear PIN_BASED_POSTED_INTR from nested pinbased_ctls only
    when apicv is globally disabled
  KVM: nVMX: handle nested posted interrupts when apicv is disabled for
    L1

 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/lapic.c            |  5 +----
 arch/x86/kvm/svm.c              |  7 ++++++-
 arch/x86/kvm/vmx/capabilities.h |  1 +
 arch/x86/kvm/vmx/nested.c       |  5 ++---
 arch/x86/kvm/vmx/nested.h       |  3 +--
 arch/x86/kvm/vmx/vmx.c          | 23 +++++++++++++----------
 7 files changed, 25 insertions(+), 21 deletions(-)

-- 
2.24.1

