Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292A4C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F170D20780
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RczFRMmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgDQQit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:38:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53414 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725877AbgDQQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587141526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=V7W+fUTy17m2U7Vvai/9OLLIkPQEcn4WJeVrBwLoseU=;
        b=RczFRMmC1ti2j27jwyEijWrNV/VrHdmwnI++sc3pB9jAAKmUvHH+xs1TEi/unZr422PaLr
        buPlwRHgGUGHUXHX+qaqwBOjglBwI4Js42SCGWmeAp0xFvkjh1UnPPF8iE2u6IlAOeb6NG
        iMfJxDC6mD/bW+307NixllnFJ4OBkZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-7z7eowszM7abL1uDXzgRMg-1; Fri, 17 Apr 2020 12:38:45 -0400
X-MC-Unique: 7z7eowszM7abL1uDXzgRMg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0F9D8024D4;
        Fri, 17 Apr 2020 16:38:43 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 978B55DA84;
        Fri, 17 Apr 2020 16:38:43 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 0/2] KVM: fix set_memory_region_test on AMD
Date:   Fri, 17 Apr 2020 12:38:41 -0400
Message-Id: <20200417163843.71624-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The set_memory_region_test selftest is failing on AMD machines, this
series fixes two bugs in it.

Paolo Bonzini (2):
  KVM: SVM: avoid infinite loop on NPF from bad address
  selftests: kvm/set_memory_region_test: do not check RIP if the guest
    shuts down

 arch/x86/kvm/svm/svm.c                              |  7 +++++++
 .../testing/selftests/kvm/set_memory_region_test.c  | 13 +++++++++----
 virt/kvm/kvm_main.c                                 |  1 +
 3 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.18.2

