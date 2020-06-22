Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3521C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A00C72073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNCQ3/cn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbgFVWEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:04:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39137 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbgFVWEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592863489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=D9zKETShESnlmbV3mu0MXm27L6L0w57VJPQLcTIPbrk=;
        b=bNCQ3/cnaPQ11zk3dqoQnHvKwmyBrrPHQL2KW4BbrAcZmDuLmXkTNNAmNxoQf8jNkZAPpQ
        JrrDZy4GJynpNfEUXftQrZdh/x88EXxKuv9HAkVUkm58SBrCKUIEm2qQgAqV0LtoXy7vIg
        7qsU/6S3jiBtoXT0E849sHJx3vU7KL4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-M-_Z7ItjPkmu6VOqRarj-w-1; Mon, 22 Jun 2020 18:04:47 -0400
X-MC-Unique: M-_Z7ItjPkmu6VOqRarj-w-1
Received: by mail-qk1-f199.google.com with SMTP id i62so4787263qkd.18
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D9zKETShESnlmbV3mu0MXm27L6L0w57VJPQLcTIPbrk=;
        b=lhEbcWObxtcQGmzvFA+Dz78nnEvrtM0LLijJDVpeya1e4d7/BuEPp7msDgEMohzhlv
         +yZe/XSnKOws+QDelphFmhfquWmT0fZuTX7Tax5Ke/DyOX/3RN4c5+gy6zDIUhz/8F6f
         3JLt/XIRcoty8JA/BAWXn/Fy9Oo4s+w04hxQ29bBNbJPSYf5SxWcbRHjcnep11FS6xgB
         JTyYMsuhMwU17LgT6yWg2zy3T752ilbRJqpjPb2x0p2lGYI6Z8Ekw4P+SMWQovhS5rDh
         C06kwz1Pzan3aLN0Jy9/UiJdujXjrtz93lTEifSy/z6/t0Jirmh362OSBlODLVYos0Bv
         vzaA==
X-Gm-Message-State: AOAM533ka8T4e40QAHU0fYO3tj9p8WFedmE1yA7MI40S8LFcZHffhBXW
        YXs8dmypjGUwfxlLclKb4HKMRahW/eeFBkMe0sf5StvhWp4zeQiw7vOPK/TqI8df19pgKOkBKpG
        /6KsF/8cAcWF/Gj9f/8ei1qte
X-Received: by 2002:ac8:39a5:: with SMTP id v34mr3750917qte.377.1592863486980;
        Mon, 22 Jun 2020 15:04:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPioSIYBbZtgP/PBxkHkqJOw9BSt46b64TzBxG1INjx9E7Vg9ObXsPvQdo2rC0ZKklAQiWMQ==
X-Received: by 2002:ac8:39a5:: with SMTP id v34mr3750894qte.377.1592863486754;
        Mon, 22 Jun 2020 15:04:46 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id h6sm3506810qtu.2.2020.06.22.15.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:04:45 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 0/2] KVM: X86: A few fixes around ignore_msrs
Date:   Mon, 22 Jun 2020 18:04:40 -0400
Message-Id: <20200622220442.21998-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ignore_msrs and report_ignored_msrs have a few issues:

  - Errors could be dumped to dmesg even if the msr access is triggered inside
    kvm itself (e.g., kvm_cpuid), while what we really want to trap should be
    either guest msr accesses, or KVM_SET_MSRS.

  - These two parameters didn't apply to feature msrs.

Each of the patch in this series tries to handle one of the issues.

Here KVM_MSR_RET_INVALID is introduced.  Ideally it can be an enum with both
0/1 defined too, but I'll see whether there's any feedback first about this
version.

This originates from a discussion between Paolo and me on an unexpected warning
msr access message that triggered on a RT system, which seemed to have caused
some system jitters.

Please have a look, thanks.

Peter Xu (2):
  KVM: X86: Move ignore_msrs handling upper the stack
  KVM: X86: Do the same ignore_msrs check for feature msrs

 arch/x86/kvm/svm/svm.c |  2 +-
 arch/x86/kvm/vmx/vmx.c |  2 +-
 arch/x86/kvm/x86.c     | 90 +++++++++++++++++++++++++++++-------------
 arch/x86/kvm/x86.h     |  2 +
 4 files changed, 66 insertions(+), 30 deletions(-)

-- 
2.26.2

