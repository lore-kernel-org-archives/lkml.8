Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F330EC32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57D22469D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQVEQtm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgARUN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 15:13:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60630 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726674AbgARUN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 15:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579378436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vAamMIuy9qZ1qnjqn1YuSKprV6Hn7tVGu8RDC7UeEBo=;
        b=DQVEQtm3OftQU6/vaWxBgQG+fpfhOMaJS2eej969NPY8279svzASg1t2mVqVZXqPU6jGN0
        1fzJNc6NB9P2CixtYf9SNXMmeuTw+4I46L9zciKpP1aBn7TkpVJGMWB/7sUesjP4w4Mq8I
        1jVWFx7rcBmyqtHUuJe+2WjnbqwN1VA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-iBSATGNPOleGPdHovNb4VA-1; Sat, 18 Jan 2020 15:13:55 -0500
X-MC-Unique: iBSATGNPOleGPdHovNb4VA-1
Received: by mail-wr1-f72.google.com with SMTP id j13so12042467wrr.20
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 12:13:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vAamMIuy9qZ1qnjqn1YuSKprV6Hn7tVGu8RDC7UeEBo=;
        b=BN+TSXXAE+eoIz1BkqEHekrhIwtZLXuQ33J2G7XtsxUiG80fAdOPxYWF1CtGtBrSp+
         7LCc7picXtdO3NXh/ksKgXK2K64jirZh9mODyttS4LVi/bvd+rkUnKuZPCA4jhJ9Sixg
         KcNVm8mB/LcBWnjT3bSsIXt0KFnRR0iIgw10x9gEgttXSjZvCCFcROIVM8eBCTvIn28g
         /+NDELDLkKVNY6z/MgtWoV72t/r/66J+qIfU0NojDz++iwLzB9Em5lXyyYldfpmYmW75
         8ZSYaSrOgp8L62gblaIINZwkugz4cCi9bI+ZOkFRlRd2zE1GtzcAn3i15Xl1eHzMVA3R
         nOHw==
X-Gm-Message-State: APjAAAW8uX5bRJGVqJbNrIVlSjBj7PZj6nwYUu9+QtOj6re81KaeGi5V
        mYSlhY4pWcGPn03LGEUQullik58sFbGMKSEci+CxZ7wl6GCMGKRVGPgT/TOzsov2u6ZApv9JyNk
        DjOSyORIa2My2m3kMOmhXtlbG
X-Received: by 2002:a1c:62c1:: with SMTP id w184mr11141577wmb.150.1579378434181;
        Sat, 18 Jan 2020 12:13:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqy+zGJGN89q816CDTxTWRuSaIsyzxshooUEMHLhNjUkY0gfv8EIwHG7NcDm7EAJtTkTR+MjFQ==
X-Received: by 2002:a1c:62c1:: with SMTP id w184mr11141563wmb.150.1579378433963;
        Sat, 18 Jan 2020 12:13:53 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e0d6:d2cd:810b:30a9? ([2001:b07:6468:f312:e0d6:d2cd:810b:30a9])
        by smtp.gmail.com with ESMTPSA id m10sm40198204wrx.19.2020.01.18.12.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2020 12:13:53 -0800 (PST)
Subject: Re: [PATCH v2 10/13] KVM: x86: Protect memory accesses from
 Spectre-v1/L1TF attacks in x86.c
To:     Marios Pomonis <pomonis@google.com>, rkrcmar@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Finco <nifi@google.com>, Andrew Honig <ahonig@google.com>,
        stable@vger.kernel.org
References: <20191211204753.242298-1-pomonis@google.com>
 <20191211204753.242298-11-pomonis@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d8f47c12-3301-cb70-8d08-fe93450d19eb@redhat.com>
Date:   Sat, 18 Jan 2020 21:13:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191211204753.242298-11-pomonis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/19 21:47, Marios Pomonis wrote:
> This fixes Spectre-v1/L1TF vulnerabilities in
> vmx_read_guest_seg_selector(), vmx_read_guest_seg_base(),
> vmx_read_guest_seg_limit() and vmx_read_guest_seg_ar().
> These functions contain index computations based on the
> (attacker-influenced) segment value.
> 
> Fixes: commit 2fb92db1ec08 ("KVM: VMX: Cache vmcs segment fields")

I think we could instead do

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 2d4faefe8dd4..20c0cbdff1be 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5195,16 +5195,28 @@ int x86_decode_insn(struct x86_emulate_ctxt
*ctxt, void *insn, int insn_len)
 				ctxt->ad_bytes = def_ad_bytes ^ 6;
 			break;
 		case 0x26:	/* ES override */
+			has_seg_override = true;
+			ctxt->seg_override = VCPU_SREG_ES;
+			break;
 		case 0x2e:	/* CS override */
+			has_seg_override = true;
+			ctxt->seg_override = VCPU_SREG_CS;
+			break;
 		case 0x36:	/* SS override */
+			has_seg_override = true;
+			ctxt->seg_override = VCPU_SREG_SS;
+			break;
 		case 0x3e:	/* DS override */
 			has_seg_override = true;
-			ctxt->seg_override = (ctxt->b >> 3) & 3;
+			ctxt->seg_override = VCPU_SREG_DS;
 			break;
 		case 0x64:	/* FS override */
+			has_seg_override = true;
+			ctxt->seg_override = VCPU_SREG_FS;
+			break;
 		case 0x65:	/* GS override */
 			has_seg_override = true;
-			ctxt->seg_override = ctxt->b & 7;
+			ctxt->seg_override = VCPU_SREG_GS;
 			break;
 		case 0x40 ... 0x4f: /* REX */
 			if (mode != X86EMUL_MODE_PROT64)

so that the segment is never calculated.

Paolo

