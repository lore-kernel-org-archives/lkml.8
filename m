Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775FBC47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7AC2073E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jow5aUhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgEDNMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 09:12:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60037 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726404AbgEDNMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 09:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588597960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3UJFfbQE2y0YksHkyDVD2IwXDk0FmannGZsgQWHPWN4=;
        b=Jow5aUhXFqee+eRcLAMAq5UETuixmXyqgHdu0QoEA0c8k2lcBo+oPyLmJKRT2js51czopQ
        yD8ipq1zGqit6OBYddqhfNGlIItTfE4QF8Z5+RVSaKTW5ZBuEKKzkeTao/LKkJQx4A18Oq
        Bp0sYTS1xWIhBwAAjp2I3hadlLHfKEE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-SInlJcjyOImXARWx7ik6Dg-1; Mon, 04 May 2020 09:12:39 -0400
X-MC-Unique: SInlJcjyOImXARWx7ik6Dg-1
Received: by mail-wr1-f72.google.com with SMTP id p2so10683866wrx.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 06:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3UJFfbQE2y0YksHkyDVD2IwXDk0FmannGZsgQWHPWN4=;
        b=ggq1IGuDs2aP5s5LA2DliR6Apz1vwGo2OyfmV/H2vzdJ5tHFXo1UI6YhSwbs159K2z
         aH4ARYGsD7DLSuW+zTuClajGlBqI9erGSjh0NtcMYSeyrowtRVUiCnnp/7Q3NN71JxXj
         rQ1VWnUUjYbhJsWUi39YO0aqVMpQ6FP8pCVtfJ6b8VT+gHVBcl/N1xDRZ2+QryYMktVn
         kzamyCSazdDPDGACir+w3Rf9lA6Og3//5GP0qLCrPG+K9F2bWsa6L9FORPQ6Sb02HVfi
         mAL3HbBwLEbVxqxlImSXU3q6S+F/ReIxpSz5QyWB2fbNucQzEyxFMviTq7BmrPSLAQhF
         YaSg==
X-Gm-Message-State: AGi0PubF+CwgsIYZrWg1gRMziWMdo9RpXkFja026e95FQlYxZ+IDFlcK
        SbYGajE/nN9/ajBMkRKigDK/Kiu+OwP+QzUXbUI88/qgD8tsagaeja1pw/1x3gth7l2/yxI185v
        wt8F+j2JQLhVaslIBtZ/oanu6
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr20588291wru.326.1588597957908;
        Mon, 04 May 2020 06:12:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ1O81/J0JwkiZSh7+3W4ruk62C2ztVK4Zj9/OJqN1Gg3ctJQj8c3Zb9XuibDPMugA0aCXfZw==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr20588269wru.326.1588597957696;
        Mon, 04 May 2020 06:12:37 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id h16sm20691024wrw.36.2020.05.04.06.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 06:12:37 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: nVMX: Skip IBPB when switching between vmcs01 and
 vmcs02
To:     Alexander Graf <graf@amazon.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        KarimAllah Raslan <karahmed@amazon.de>
References: <20200501163117.4655-1-sean.j.christopherson@intel.com>
 <1de7b016-8bc9-23d4-7f8b-145c30d7e58a@amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d0d09da-3920-16d6-11ae-51b864171b66@redhat.com>
Date:   Mon, 4 May 2020 15:12:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1de7b016-8bc9-23d4-7f8b-145c30d7e58a@amazon.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/20 14:01, Alexander Graf wrote:
> I like the WARN_ON :). It should be almost free during execution, but
> helps us catch problems early.

Yes, it's nice.  I didn't mind the "buddy" argument either, but if we're 
going to get a bool I prefer positive logic so I'd like to squash this:

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b57420f3dd8f..299393750a18 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -304,7 +304,13 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
 	prev = vmx->loaded_vmcs;
 	WARN_ON_ONCE(prev->cpu != cpu || prev->vmcs != per_cpu(current_vmcs, cpu));
 	vmx->loaded_vmcs = vmcs;
-	vmx_vcpu_load_vmcs(vcpu, cpu, true);
+
+	/*
+	 * This is the same guest from our point of view, so no
+	 * indirect branch prediction barrier is needed.  The L1
+	 * guest can protect itself with retpolines, IBPB or IBRS.
+	 */
+	vmx_vcpu_load_vmcs(vcpu, cpu, false);
 	vmx_sync_vmcs_host_state(vmx, prev);
 	put_cpu();
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 669e14947ba9..0f9c8d2dd7f6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1311,7 +1311,7 @@ static void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 		pi_set_on(pi_desc);
 }
 
-void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu, bool nested_switch)
+void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu, bool need_ibpb)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	bool already_loaded = vmx->loaded_vmcs->cpu == cpu;
@@ -1336,7 +1336,7 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu, bool nested_switch)
 	if (per_cpu(current_vmcs, cpu) != vmx->loaded_vmcs->vmcs) {
 		per_cpu(current_vmcs, cpu) = vmx->loaded_vmcs->vmcs;
 		vmcs_load(vmx->loaded_vmcs->vmcs);
-		if (!nested_switch)
+		if (need_ibpb)
 			indirect_branch_prediction_barrier();
 	}
 
@@ -1378,7 +1378,7 @@ void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	vmx_vcpu_load_vmcs(vcpu, cpu, false);
+	vmx_vcpu_load_vmcs(vcpu, cpu, true);
 
 	vmx_vcpu_pi_load(vcpu, cpu);
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index fa61dc802183..e584ee9b3e94 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -320,7 +320,7 @@ struct kvm_vmx {
 };
 
 bool nested_vmx_allowed(struct kvm_vcpu *vcpu);
-void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu, bool nested_switch);
+void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu, bool need_ibpb);
 void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 int allocate_vpid(void);
 void free_vpid(int vpid);


Paolo

