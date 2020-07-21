Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85685C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDAA20714
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7JJZ3Sk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgGUIYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGUIYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:24:03 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0EEC061794;
        Tue, 21 Jul 2020 01:24:03 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cv18so1112080pjb.1;
        Tue, 21 Jul 2020 01:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=SCGoNX/Gx06PI0eqChSqx3NbjiK5be1SzuTiaG36KlM=;
        b=k7JJZ3SkykmDYq8ZsHa0/+BVnqjUEmIX0Vc/FeXqhPuHhvILnYCAwLMoOYuYCsKTmD
         IL6G6MWxIdPp96ntVwfE+xFSV4TRJlwnEqER6JrVlrIDNgtLumwZ7eCDRYIuoD4a/uuK
         7gsleRJW09qRkVdKRIItkFiTXezv+zGMiPnSajOT4/0QlarhbVS/RoPbX6VZFlgK9dUM
         YglOx7PIMp9T2EMuM7ihKApDj6bo1zBUEysxRE3p5YFbFQE3B+GmmwTmnT+nzscdh1KO
         OFp8anhxRvxbagspNBX7cnOayMDbMRUQVyz2gCEHBdwEg2fspVnIRZAgyINClUOrQmse
         XZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=SCGoNX/Gx06PI0eqChSqx3NbjiK5be1SzuTiaG36KlM=;
        b=tjQAWLeT+JYMZ602HEfV21gQ1UV4Th1zE6zmzq8Z461EleGTlcd7D+nroN0vItjANu
         eLoFbzo45sDoG5rE5MGVAid3MQyjYaLKVtocE5QKSx8uD+2kHMulkVPy62Qpq+34Np8e
         PhAFLrGE4IZE56sRSSFA0sMvEIxz871qEneRqrM731UDaNoP9zToHF9HcyIja3L+gNlR
         BQ5DMBb2W1oRa885n5HO/HjMmi8/w3MN5nWYtwsPOEbnkQUVzqGDti+ESWQ4Z0YYO47/
         iYo5KwQfB+0dpCFvTIth5V1B0Jio+SKfy7q/OWEGvKuHkEJtUt/PcxMKVpXu+kvmoY9S
         1H7w==
X-Gm-Message-State: AOAM533Y2dBbyeqPAnXLRMZMbSsGkXEGi6i2xFFYb02whotG5/8RBjd+
        oc+UGCQHy4N/u26tFUdtNXCFnu8=
X-Google-Smtp-Source: ABdhPJxf5x6eCqDIUTuyjMpOsrP0TkNV1tWJzOzszqAD+uyC19rtvch+3o66OLWY35vA/J4CkakHFg==
X-Received: by 2002:a17:90b:3684:: with SMTP id mj4mr3763826pjb.66.1595319842817;
        Tue, 21 Jul 2020 01:24:02 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.54])
        by smtp.gmail.com with ESMTPSA id y8sm2261197pju.49.2020.07.21.01.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 01:24:02 -0700 (PDT)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>, mingo@redhat.com,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>
From:   Haiwei Li <lihaiwei.kernel@gmail.com>
Subject: [PATCH] KVM: Using macros instead of magic values
Message-ID: <4c072161-80dd-b7ed-7adb-02acccaa0701@gmail.com>
Date:   Tue, 21 Jul 2020 16:23:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiwei Li <lihaiwei@tencent.com>

Instead of using magic values, use macros.

Signed-off-by: Haiwei Li <lihaiwei@tencent.com>
---
  arch/x86/kvm/lapic.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 47801a4..d5fb2ea 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2083,7 +2083,8 @@ int kvm_lapic_reg_write(struct kvm_lapic *apic, 
u32 reg, u32 val)

  	case APIC_SELF_IPI:
  		if (apic_x2apic_mode(apic)) {
-			kvm_lapic_reg_write(apic, APIC_ICR, 0x40000 | (val & 0xff));
+			kvm_lapic_reg_write(apic, APIC_ICR,
+					    APIC_DEST_SELF | (val & APIC_VECTOR_MASK));
  		} else
  			ret = 1;
  		break;
--
1.8.3.1
