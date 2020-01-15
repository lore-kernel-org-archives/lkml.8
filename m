Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F3AC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1F9214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Flr8Z9tE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgAORKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:10:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58955 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726574AbgAORKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579108220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lUo1D7ikLQfA8lYaKoHVJNnJCuON6B6xnJFrEX1/0vk=;
        b=Flr8Z9tErEIVno9bnIJ5AQL67Rd7nwXFmZcBtk6k22Snk4H7dz6X5IZG1zhpKzmgCi08Zg
        RZWTjXF06c3SV7g4bhQpNj53y7iJHOTqHNprIvsbgzu6yLa9RIDfQDByyhgy3rf38nWNLm
        2NbmDIAd5U3s2SVK4que49hzJg1C7KQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-raGCTKUlP4m-pW0ae1OVwA-1; Wed, 15 Jan 2020 12:10:19 -0500
X-MC-Unique: raGCTKUlP4m-pW0ae1OVwA-1
Received: by mail-wr1-f70.google.com with SMTP id u18so8194197wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 09:10:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lUo1D7ikLQfA8lYaKoHVJNnJCuON6B6xnJFrEX1/0vk=;
        b=tLkur00WjOEDy2KomrFdDIlt+FJnIyL90hqhkEU+wWUwsw3RUzcy7t0POAOO8w4Yci
         X2xpC65p+zOrKZAMrAjBu5PLtHbNwx4fJ6ofNzrWLwzoHdzHQDB51tDHz3KuMcTssZoG
         /vYmcNgmuQdzux8tz4npqnBKB6Q5yHWBBNDTswMzPH8qSw/t9q2rsGNIMTHedazRkRkj
         ZFnl+kmuzuXRMPpUmr/dv5T32FO/jouYHpjM6ahUG2iwTbuSvrZZTMTOSmBdarTQqf/h
         eV/qtn4Y3sGUDzls1vtWmwGz75J4UqlaO1WvBL334PVoaHrDcrEU1qMuGpMAONEpjQ4N
         cLaQ==
X-Gm-Message-State: APjAAAVmaZZ24iJPPWTQsby5jZ12tXbdAQJVaim/aVJbbNrLXClsCrEt
        XMlkgtjmYCh4eEAmkkG2wFT7vYFCD9hf1X1NgOxyLot9wur5AbDu9E5csJdG40uIGhktCq1xJrq
        H3Aa8Dvgz79B7GBM3lVNyZRid
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr887030wmi.89.1579108217926;
        Wed, 15 Jan 2020 09:10:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqx4B9x0NLSvFhdpR/GVGflvW4G/nSX8mzTF5mcgnPay7KLNFLabJe8vYU6dpBFPYErt1ooqnQ==
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr887008wmi.89.1579108217757;
        Wed, 15 Jan 2020 09:10:17 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y20sm525071wmi.25.2020.01.15.09.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 09:10:16 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: [PATCH RFC 1/3] x86/kvm/hyper-v: remove stale evmcs_already_enabled check from nested_enable_evmcs()
Date:   Wed, 15 Jan 2020 18:10:12 +0100
Message-Id: <20200115171014.56405-2-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115171014.56405-1-vkuznets@redhat.com>
References: <20200115171014.56405-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nested_enable_evmcs() evmcs_already_enabled check doesn't really do
anything: controls are already sanitized and we return '0' regardless.
Just drop the check.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/evmcs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
index 72359709cdc1..89c3e0caf39f 100644
--- a/arch/x86/kvm/vmx/evmcs.c
+++ b/arch/x86/kvm/vmx/evmcs.c
@@ -350,17 +350,12 @@ int nested_enable_evmcs(struct kvm_vcpu *vcpu,
 			uint16_t *vmcs_version)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	bool evmcs_already_enabled = vmx->nested.enlightened_vmcs_enabled;
 
 	vmx->nested.enlightened_vmcs_enabled = true;
 
 	if (vmcs_version)
 		*vmcs_version = nested_get_evmcs_version(vcpu);
 
-	/* We don't support disabling the feature for simplicity. */
-	if (evmcs_already_enabled)
-		return 0;
-
 	vmx->nested.msrs.pinbased_ctls_high &= ~EVMCS1_UNSUPPORTED_PINCTRL;
 	vmx->nested.msrs.entry_ctls_high &= ~EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
 	vmx->nested.msrs.exit_ctls_high &= ~EVMCS1_UNSUPPORTED_VMEXIT_CTRL;
-- 
2.24.1

