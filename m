Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23555C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E97B122BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XendloUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgH0RL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:11:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41036 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727013AbgH0RLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598548314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6skhDZK1eBFqInLIv6DlYJCfL20AefptLm3lM0sktaQ=;
        b=XendloUhFiswFH7LvIYEY6LJUg5M8Fd5YMJtowPxYwGVuSWqYtBzQqKCpyufHdZXnx8JwD
        T12LdHH8doWvVhlMYG+Lz8ab43uEyS/mjvynEgsk/7DIFLdXJFlHthrxzqIodCHirEOpnR
        dT7nZAoXe2JHG7E1XP2lAFAVlrpEpK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-4-_sblBzO3mMfn4CsuUU5Q-1; Thu, 27 Aug 2020 13:11:52 -0400
X-MC-Unique: 4-_sblBzO3mMfn4CsuUU5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FAAE425DA;
        Thu, 27 Aug 2020 17:11:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C73C5D9E8;
        Thu, 27 Aug 2020 17:11:46 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT)), Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v3 0/8] KVM: nSVM: ondemand nested state allocation + smm fixes
Date:   Thu, 27 Aug 2020 20:11:37 +0300
Message-Id: <20200827171145.374620-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does some refactoring and implements on demand nested sta=
te area=0D
This way at least guests that don't use nesting won't waste memory=0D
on nested state.=0D
=0D
This patch series is based on patch series '[PATCH 0/3] Few nSVM bugfixes'=
=0D
(patch #7 here should have beeing moved there as well to be honest)=0D
=0D
The series was tested with various nested guests, and it seems to work=0D
as long as I disable the TSC deadline timer (this is unrelated to this=0D
patch series)=0D
=0D
I addressed the review feedback from V2, and added few refactoring=0D
patches to this series as suggested.=0D
=0D
Best regards,=0D
        Maxim Levitsky=0D
=0D
Maxim Levitsky (8):=0D
  KVM: SVM: rename a variable in the svm_create_vcpu=0D
  KVM: nSVM: rename nested vmcb to vmcb12=0D
  KVM: SVM: refactor msr permission bitmap allocation=0D
  KVM: SVM: use __GFP_ZERO instead of clear_page=0D
  KVM: SVM: refactor exit labels in svm_create_vcpu=0D
  KVM: x86: allow kvm_x86_ops.set_efer to return a value=0D
  KVM: emulator: more strict rsm checks.=0D
  KVM: nSVM: implement ondemand allocation of the nested state=0D
=0D
 arch/x86/include/asm/kvm_host.h |   2 +-=0D
 arch/x86/kvm/emulate.c          |  22 ++-=0D
 arch/x86/kvm/svm/nested.c       | 267 ++++++++++++++++++--------------=0D
 arch/x86/kvm/svm/svm.c          | 106 +++++++------=0D
 arch/x86/kvm/svm/svm.h          |  10 +-=0D
 arch/x86/kvm/vmx/vmx.c          |   9 +-=0D
 arch/x86/kvm/x86.c              |   3 +-=0D
 7 files changed, 243 insertions(+), 176 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

