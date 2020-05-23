Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E14C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 16:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A9F20872
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 16:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFxkvMFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgEWQPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 12:15:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30585 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726338AbgEWQPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 12:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590250507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=L8j7T0o/S5OaFe2c9p53BQS8VJwyJfs8YmL4K/O2KYU=;
        b=gFxkvMFKN4kOrEOVZV0oYpyWYpOPTiligUbcM0p8kt5IS3QOMoahyvy/X8mkPh6KGdmDUT
        MuFC3mC0Xz5jvDzljw21o++9OiJoHVJ/DEO1wEZ3tzRISPcw93IOIjp4tlwGUCFex078kc
        wjUxfld1D3OmGfvmt7Aunt3Lt+18GCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-WRTp-SYzNFCw-fza1ty5uA-1; Sat, 23 May 2020 12:15:03 -0400
X-MC-Unique: WRTp-SYzNFCw-fza1ty5uA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AFFB107ACCD;
        Sat, 23 May 2020 16:15:01 +0000 (UTC)
Received: from starship.f32vm (unknown [10.35.206.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC61F6E716;
        Sat, 23 May 2020 16:14:56 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tao Xu <tao3.xu@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jingqi Liu <jingqi.liu@intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 0/2] Fix issue with not starting nesting guests on my system
Date:   Sat, 23 May 2020 19:14:53 +0300
Message-Id: <20200523161455.3940-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my AMD machine I noticed that I can't start any nested guests,=0D
because nested KVM (everything from master git branches) complains=0D
that it can't find msr MSR_IA32_UMWAIT_CONTROL which my system doesn't supp=
ort=0D
at all anyway.=0D
=0D
I traced it to the recently added UMWAIT support to qemu and kvm.=0D
The kvm portion exposed the new MSR in KVM_GET_MSR_INDEX_LIST without=0D
checking that it the underlying feature is supported in CPUID.=0D
It happened to work when non nested because as a precation kvm,=0D
tries to read each MSR on host before adding it to that list,=0D
and when read gets a #GP it ignores it.=0D
=0D
When running nested, the L1 hypervisor can be set to ignore unknown=0D
msr read/writes (I need this for some other guests), thus this safety=0D
check doesn't work anymore.=0D
=0D
V2: * added a patch to setup correctly the X86_FEATURE_WAITPKG kvm capabili=
ty=0D
    * dropped the cosmetic fix patch as it is now fixed in kvm/queue=0D
=0D
Best regards,=0D
	Maxim Levitsky=0D
=0D
Maxim Levitsky (2):=0D
  kvm/x86/vmx: enable X86_FEATURE_WAITPKG in KVM capabilities=0D
  kvm/x86: don't expose MSR_IA32_UMWAIT_CONTROL unconditionally=0D
=0D
 arch/x86/kvm/vmx/vmx.c | 3 +++=0D
 arch/x86/kvm/x86.c     | 4 ++++=0D
 2 files changed, 7 insertions(+)=0D
=0D
-- =0D
2.26.2=0D
=0D

