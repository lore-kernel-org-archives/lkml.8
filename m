Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79623C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50FEE206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+g5LjLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgEEUuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 16:50:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25965 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726593AbgEEUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588711805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aTLHVMbsIaqAX7BaSrLpdm3P4nxyMTwYs/IkveEjuuM=;
        b=h+g5LjLLgBeXLx9Ke1xo7Vg5QkKLoJglXE0clmhx17KDwrknFLI6FhDO0Y4zqmOnqKJxrC
        RNn17P57hHh4JkHSaM5olEzN2gsBuMkLlgcPpBREmU5BQ9soPkF5cRO8N21PSIUnuNDlgH
        HiY8JaJ6cJTy4xqs9qbtviPEXcA1QPI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-LfjTTW26MU-jPornKl_tdQ-1; Tue, 05 May 2020 16:50:03 -0400
X-MC-Unique: LfjTTW26MU-jPornKl_tdQ-1
Received: by mail-qv1-f69.google.com with SMTP id d4so3214296qva.16
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 13:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aTLHVMbsIaqAX7BaSrLpdm3P4nxyMTwYs/IkveEjuuM=;
        b=DgLE4XQTTcAXBypQ/gqjg5OFMuwc1HiporOkYM9BIAW/3gtq8As5+gUUBs4gozoBUy
         bAk9sIBgRQ08bFHEigVU3420xl8kMgmwggQU7a4SJhF3M4VlnD2PCih8dUx8YumimgGd
         pEBt4J6Qqg8BGUJ0s90rqS3hNWjeGAWRhZPrMnoOqxxJzFnwdE8qf7KXbM1+ptf3ME2/
         1Qh7LaPgkH+uFENwE092PBekcfvfB//lzksN4WFikvi9guMTSSbSPIaJJZRnNC3fa37f
         Hk4g3UhrmxQiLbNAXntDIL1AucQzUkdPmAe3vwnPs7qxolXRQ3Xenp6S02v198oBO0H5
         5jVw==
X-Gm-Message-State: AGi0Pub3raGMcKD7O6JlQKhJXfr7YGV6MOff51IqjCv4F3Dw5fXjKXKf
        T/oqyAF8HG7XWv2YAMcxWMIAR7UXwSjq9llFeStmKdiICeul9fYNqGuQasjeQ9SrldtBhJ413zc
        VNZF5Cro5swkPaI2ppREPI0GA
X-Received: by 2002:ac8:5653:: with SMTP id 19mr4679676qtt.252.1588711802814;
        Tue, 05 May 2020 13:50:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypJZWCseS8WCKKpT3aDra1sX1ikSoUZ46+/xjslmiir4MILBMJv5VWPlzmW+jNOSrx1v5dxLGw==
X-Received: by 2002:ac8:5653:: with SMTP id 19mr4679660qtt.252.1588711802514;
        Tue, 05 May 2020 13:50:02 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 193sm19380qkl.42.2020.05.05.13.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 13:50:01 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/3] KVM: X86: Two fixes for KVM_SET_GUEST_DEBUG, and a selftest
Date:   Tue,  5 May 2020 16:49:57 -0400
Message-Id: <20200505205000.188252-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two patches try to fix two issues I found (I think) with the
selftest.  The 3rd patch is the test itself.  Note, we need below patches to be
applied too for the test to work:

        KVM: X86: Declare KVM_CAP_SET_GUEST_DEBUG properly
        KVM: selftests: Fix build for evmcs.h

Please review, thanks.

Peter Xu (3):
  KVM: X86: Set RTM for DB_VECTOR too for KVM_EXIT_DEBUG
  KVM: X86: Fix single-step with KVM_SET_GUEST_DEBUG
  KVM: selftests: Add KVM_SET_GUEST_DEBUG test

 arch/x86/kvm/vmx/vmx.c                        |   2 +-
 arch/x86/kvm/x86.c                            |   2 +-
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |   2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |   9 +
 .../testing/selftests/kvm/x86_64/debug_regs.c | 180 ++++++++++++++++++
 6 files changed, 194 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/debug_regs.c

-- 
2.26.2

