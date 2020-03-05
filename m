Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23962C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB702146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9spS8cm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCEKB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:01:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37341 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725897AbgCEKB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583402488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qpugOFYl5V3c99FSliIabsi6Xzso9YXY154ETSWVrWk=;
        b=a9spS8cm5nQ3DUtWI674vFZIs7S/k52EsNb0Tkiri7LxMdWJwZPa25jwfcx79oEtGKevmM
        0iHtR9h9cBtg5KG/zEskCrneqio0t2KKoZ2icEuBwpL98/Um9tsvv7ZQZuKxwK+zvEkZGD
        TZId657JW+DAgj1TZl/FFzvc24H4XWs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-7NGpolM3NViU85RqPsL1tQ-1; Thu, 05 Mar 2020 05:01:26 -0500
X-MC-Unique: 7NGpolM3NViU85RqPsL1tQ-1
Received: by mail-wm1-f71.google.com with SMTP id t2so1374101wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 02:01:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qpugOFYl5V3c99FSliIabsi6Xzso9YXY154ETSWVrWk=;
        b=NnFvU102XR9X83jVzLtogywcgp8Rc9O7j8pp8lMyy9Vc+aMDcrXEWcJ6w93HFlxKka
         Mv+g64gE2193ZEbrSr+v/0dDwESBtFhq+QxYtacrYSHr7nKTklio9kgjpE1WD1GGf+NV
         E/QA0U0CbMjQH+jNcbbFIFvgsnRKbnst506Ov5eTL1fQllKy3loKPCjEnNJVFROlY/fV
         dck0pw5AGXmrfvnZC6Nwt0JHrH+hNPN6P+gN5gLlq33M0r3gtqRQ8D5vHtiHmJpSAMAO
         cF8LTOLeicoeJEZcQf9qOvAOVY4JffzDAzPyRDxge6GUhuS/jslOU9Eb5kcO5+rkT6/Y
         FrzQ==
X-Gm-Message-State: ANhLgQ12aGE8R9flSuJuZeduIuoPo8UvIv18bn+Rc5feVl+yFtf9w9Qi
        2s5xBs3m2Ko6xItLUSZYXQh36n2ta0N7SZR/muviFSoVDYGtqASpDly7J3OfX3Js1d6WwpI9rjJ
        hf+oKYFMI/+ywXyUabIOECWbL
X-Received: by 2002:a1c:df07:: with SMTP id w7mr3298012wmg.7.1583402485694;
        Thu, 05 Mar 2020 02:01:25 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuz6dICjFPBTcnmSBIcEQjdYGYqDapQCmvmzoB8Kk/sgxpi35ZXSbrUoVQzUwpjoTnnS8XQNw==
X-Received: by 2002:a1c:df07:: with SMTP id w7mr3297996wmg.7.1583402485531;
        Thu, 05 Mar 2020 02:01:25 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f207sm10440025wme.9.2020.03.05.02.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 02:01:24 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] KVM: x86: VMX: cleanup VMXON region allocation
Date:   Thu,  5 Mar 2020 11:01:21 +0100
Message-Id: <20200305100123.1013667-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup with no functional change (intended):
- Rename 'kvm_area' to 'vmxon_region'
- Simplify setting revision_id for VMXON region when eVMCS is in use

Vitaly Kuznetsov (2):
  KVM: x86: VMX: rename 'kvm_area' to 'vmxon_region'
  KVM: x86: VMX: untangle VMXON revision_id setting when using eVMCS

 arch/x86/kvm/vmx/vmx.c | 41 ++++++++++++++++++-----------------------
 arch/x86/kvm/vmx/vmx.h | 12 +++++++++---
 2 files changed, 27 insertions(+), 26 deletions(-)

-- 
2.24.1

