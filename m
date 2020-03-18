Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF14C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3934C20752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mn6dyZbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgCRRSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:18:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33738 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbgCRRSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584551879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1tmYrjNBPlfS8Oz+KPrbLzllyHIAIh5B4HPxuEUJj2k=;
        b=Mn6dyZbztjND11qoJL4cfmok0WOT29vzmbsXzdfeDYY6YC2vTZjI42/aTNVELjk93k/3OI
        bapP+LWo761K3q43TN6TW7SB5UTN2PKfRW2qvstQCA/jupj5GyrQSKPRJR8an+gZ3h7er7
        o6uXSUYqXyCe5aH+nMMSMouW7b+hkww=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-W_t7eJ1fMJeU2SCLCb0wJQ-1; Wed, 18 Mar 2020 13:17:56 -0400
X-MC-Unique: W_t7eJ1fMJeU2SCLCb0wJQ-1
Received: by mail-wr1-f71.google.com with SMTP id k11so4035686wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1tmYrjNBPlfS8Oz+KPrbLzllyHIAIh5B4HPxuEUJj2k=;
        b=UCTt6PLa5SkfomMxZ/9pHL8ep7+94keYrZBgT/sfG/I9Ec5afn3vS3B9SaNRLJc4WR
         LSg1XCda7w2gqGMrnxOyTBAHyzN4msYxtzVXKQBCsurFr6Hw11O9hQ6KGd0cqqEdd8m+
         UalqW9HgWueAIyxrPbYf8Va0wAaN73PF3TXnGDr8Afgxz9kOJyIP0prjMoUplDoQm7w/
         oEckC0U/YEN+pkENyvDF3EmYv3qS1WHHGGylIZQOCuhtwclkL1dARoeh7FuDdHfLwnz2
         PBcncKsP3WjqQ0fpJPbcFnNuTvsJ0beNWSzHl9IDR5T6G+TCyjz+UxNjk3QT4gkhzPM1
         jsMg==
X-Gm-Message-State: ANhLgQ1kO2VoVN51TqyU1sonYieNPre8YH1vrk6lXP9evr8Jo3TRkm7v
        HAP1kCR/Uj8Kt1BuhGPn8NLl5GjD5jV/oQkPkMPcpjeS4jBL/tetr1buIohG82ZLSiDwAbGTRJF
        0wfz34PJpeOMgM3feREfS8Nlo
X-Received: by 2002:a5d:680d:: with SMTP id w13mr6619020wru.227.1584551875099;
        Wed, 18 Mar 2020 10:17:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuV4gL9NnrUrL3uhgtDnC8jCR+eQZlEHteghQ1cIvY0SDIXvFJgPy1bqpym7Ng4rNGsdr2PWA==
X-Received: by 2002:a5d:680d:: with SMTP id w13mr6618996wru.227.1584551874821;
        Wed, 18 Mar 2020 10:17:54 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r3sm10531597wrw.76.2020.03.18.10.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:17:54 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] KVM: VMX: cleanup VMXON region allocation
Date:   Wed, 18 Mar 2020 18:17:50 +0100
Message-Id: <20200318171752.173073-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup with no functional change (intended):
- Rename 'kvm_area' to 'vmxon_region'
- Simplify setting revision_id for VMXON region when eVMCS is in use

Changes since v3:
- Rebase to kvm/queue
- Added Krish's Reviewed-by: tag to PATCH1
- Re-name 'enum vmcs_type' members [Sean Christopherson]

Vitaly Kuznetsov (2):
  KVM: VMX: rename 'kvm_area' to 'vmxon_region'
  KVM: VMX: untangle VMXON revision_id setting when using eVMCS

 arch/x86/kvm/vmx/nested.c |  2 +-
 arch/x86/kvm/vmx/vmx.c    | 44 ++++++++++++++++++---------------------
 arch/x86/kvm/vmx/vmx.h    | 12 ++++++++---
 3 files changed, 30 insertions(+), 28 deletions(-)

-- 
2.25.1

