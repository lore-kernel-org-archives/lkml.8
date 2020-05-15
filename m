Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFCAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2054A20657
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOI3sPtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgEORl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:41:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43377 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726465AbgEORlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589564513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=NstvlP5tNzUfUYikWj6FNTt45pdW5CGZjiroRvCAySM=;
        b=YOI3sPtdVBfiXWMVkr/rW7Qk6lb5hsYNNLLTZMU4qnOIbzaHdI8xgVRJwbg8yK1IzvNwN0
        M8UqurMdSr9lTZXD4goM7PeO1AkT/NtzlzMQjLCWM/sXMSMK0EYQsmQHXOOWTRp4861XSB
        0xFIkHVs1udWf7hfe/GW93T8i05rbkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-S-KRjdPlMCeJNwuSwL0mKg-1; Fri, 15 May 2020 13:41:47 -0400
X-MC-Unique: S-KRjdPlMCeJNwuSwL0mKg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70E85100CC90;
        Fri, 15 May 2020 17:41:46 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF64C105911A;
        Fri, 15 May 2020 17:41:45 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Cathy Avery <cavery@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 0/7] KVM: SVM: baby steps towards nested state migration
Date:   Fri, 15 May 2020 13:41:37 -0400
Message-Id: <20200515174144.1727-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some refactorings to prepare for an SVM implementation of
KVM_SET_NESTED_STATE.  It's a prerequisite for that to eliminate
exit_required, moving exceptions to svm_check_nested_events.  However:

- I might work on that soon, because it's needed to handle RSM when
the L1 hypervisor wants to get it from #UD rather than the specific
RSM intercept

- this should be enough to get a quick prototype, that I need in order to
debug a particularly crazy bug and figure out its reproducibility.

So, I am getting these patches out of my todo list for now.

Thanks,

Paolo

Paolo Bonzini (7):
  KVM: SVM: move map argument out of enter_svm_guest_mode
  KVM: SVM: extract load_nested_vmcb_control
  KVM: SVM: extract preparation of VMCB for nested run
  KVM: SVM: save all control fields in svm->nested
  KVM: nSVM: remove HF_VINTR_MASK
  KVM: nSVM: do not reload pause filter fields from VMCB
  KVM: SVM: introduce data structures for nested virt state

 arch/x86/include/asm/kvm_host.h |   1 -
 arch/x86/include/uapi/asm/kvm.h |  26 +++++++-
 arch/x86/kvm/svm/nested.c       | 115 +++++++++++++++++---------------
 arch/x86/kvm/svm/svm.c          |  11 ++-
 arch/x86/kvm/svm/svm.h          |  28 +++++---
 5 files changed, 116 insertions(+), 65 deletions(-)

-- 
2.18.2

