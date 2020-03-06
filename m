Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0DDC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5378208CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFQx8Z0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCFNCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:02:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37542 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726565AbgCFNCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583499743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9kyJgQMNNTtILNB3efmK9JnspOevwrPmN1Q1JAEBpAU=;
        b=QFQx8Z0l2m3Bzp/iorCCCZe91fZVlA5BzrUezI4n3SlC9+A5GKxbI/U0cgE6YNGAOmxRFz
        Vwzdbv9OGQyucQoD/pCuxRm8sUUvStTLd9BWyahK9sHlMpWMtGV8LU47w9PCgDIWI9B2rZ
        8jK6hgbJZDcMjMDJZH8Wwoy0uW00YLM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-L7slPDPlNRuExle3sCiGCg-1; Fri, 06 Mar 2020 08:02:22 -0500
X-MC-Unique: L7slPDPlNRuExle3sCiGCg-1
Received: by mail-wm1-f70.google.com with SMTP id d129so862180wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 05:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9kyJgQMNNTtILNB3efmK9JnspOevwrPmN1Q1JAEBpAU=;
        b=LfRDJK2EOMi82N3HVAui0EYGQarC+d/wgoASVJOtRMY1oTOzYybiGcpTokhyD98G0p
         UTVTRbwMYJChnnF/z4rw9E7+yqGEm8j/bWyFC/GqhEPaqF4jfNXuQ7NEc9fGBB7gbja5
         lMUvB2EhnRJR1k2kKZbjdgQW2DFoP+B1HbiTTcFqVbEc7vK5WPTnQ76e7Z+1mQIBScoX
         TJfvmca4l2wflc0AFDVC0we3HAqz89fqBdTpPxhty/VC+zqF6CAk8Q04P4ZuN8uG2K4G
         KHsENrgPY3E4ENKMk5WCR1JIbhUkJg0UYEmUqIBTcBvdLRg6qb62cfx0YYhFmEm4jeHg
         qu0w==
X-Gm-Message-State: ANhLgQ2JijkIifpGY0syuR9yKXaeK4+WTLeEw7f8j2tv7xX/ZqAxgSa7
        VdmNrMI0zxFuaCCh0a5f358Fq7wDtiNDLwbdo7ooh1DC+akCQQluSAHC4VZKAXvvSx/CEX6hLVA
        V9yS5ozGqpF92QU1CKsB3ANqu
X-Received: by 2002:adf:de0d:: with SMTP id b13mr3989697wrm.297.1583499738505;
        Fri, 06 Mar 2020 05:02:18 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsKYoaK09agc4K6ttjmJfCHwezyd4P5yvpgDy7QZx84bx8Hc+dQIFutDBEvtnkB7At6SeYHAQ==
X-Received: by 2002:adf:de0d:: with SMTP id b13mr3989672wrm.297.1583499738253;
        Fri, 06 Mar 2020 05:02:18 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i67sm26613243wri.50.2020.03.06.05.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 05:02:17 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] KVM: VMX: cleanup VMXON region allocation
Date:   Fri,  6 Mar 2020 14:02:13 +0100
Message-Id: <20200306130215.150686-1-vkuznets@redhat.com>
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

Changes since v1:
- Pass 'enum vmcs_type' parameter to alloc_vmcs() too [Sean Christopherson <sean.j.christopherson@intel.com>]

Vitaly Kuznetsov (2):
  KVM: VMX: rename 'kvm_area' to 'vmxon_region'
  KVM: VMX: untangle VMXON revision_id setting when using eVMCS

 arch/x86/kvm/vmx/nested.c |  2 +-
 arch/x86/kvm/vmx/vmx.c    | 44 ++++++++++++++++++---------------------
 arch/x86/kvm/vmx/vmx.h    | 12 ++++++++---
 3 files changed, 30 insertions(+), 28 deletions(-)

-- 
2.24.1

