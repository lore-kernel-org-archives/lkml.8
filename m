Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1F6C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F20214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDb7tej3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgBFKr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 05:47:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39547 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728113AbgBFKr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580986046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WDv648gdoxBL5k3OvEkq/2fYC6UUu2jW9NCWzg2D/UQ=;
        b=BDb7tej3aSrPsgi5fzgqmYL7fXelZMadAOvMNbwohxE9GszfxxOHlpcIYolRGD+wBC2yA5
        li45fyxjvs4KSokQq8YrFLM03eU8yzEZZAT3g7ROJF+KPaxKnhL8UscsU4nbC8GHUK6Wk5
        pcHpz3p7vgwv+SIQtcac3skl8r+GNfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-BiYc8bX6MOuOey5E5nJ0aA-1; Thu, 06 Feb 2020 05:47:22 -0500
X-MC-Unique: BiYc8bX6MOuOey5E5nJ0aA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 365ACDBA3;
        Thu,  6 Feb 2020 10:47:21 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B5088BE00;
        Thu,  6 Feb 2020 10:47:13 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, vkuznets@redhat.com
Cc:     thuth@redhat.com, drjones@redhat.com, wei.huang2@amd.com
Subject: [PATCH v4 0/3] selftests: KVM: AMD Nested SVM test infrastructure
Date:   Thu,  6 Feb 2020 11:47:07 +0100
Message-Id: <20200206104710.16077-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the basic infrastructure needed to test AMD nested SVM.
Also add a first basic vmcall test.

Best regards

Eric

This series can be found at:
https://github.com/eauger/linux/tree/v5.5-amd-svm-v4

History:
v3 -> v4:
- gpr64_regs struct just contains 64b mode GPRs ordered
  as in x86_register
- cleanup in run_guest (vm* instructions) and reduce
  clubber list.
- add some comments

v2 -> v3:
- Took into account Vitaly's comment:
  - added "selftests: KVM: Replace get_gdt/idt_base() by
    get_gdt/idt()"
  - svm.h now is a copy of arch/x86/include/asm/svm.h
  - avoid duplicates

v1 -> v2:
- split into 2 patches
- remove the infrastructure to run low-level sub-tests and only
  keep vmmcall's one.
- move struct regs into processor.h
- force vmcb_gpa into rax in run_guest()

Eric Auger (3):
  selftests: KVM: Replace get_gdt/idt_base() by get_gdt/idt()
  selftests: KVM: AMD Nested test infrastructure
  selftests: KVM: SVM: Add vmcall test

 tools/testing/selftests/kvm/Makefile          |   3 +-
 .../selftests/kvm/include/x86_64/processor.h  |  28 +-
 .../selftests/kvm/include/x86_64/svm.h        | 297 ++++++++++++++++++
 .../selftests/kvm/include/x86_64/svm_util.h   |  38 +++
 tools/testing/selftests/kvm/lib/x86_64/svm.c  | 161 ++++++++++
 tools/testing/selftests/kvm/lib/x86_64/vmx.c  |   6 +-
 .../selftests/kvm/x86_64/svm_vmcall_test.c    |  79 +++++
 7 files changed, 604 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/svm.h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/svm_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/svm.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c

--=20
2.20.1

