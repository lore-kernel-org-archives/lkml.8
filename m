Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D63FC35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 12:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5116C20637
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 12:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcngjVQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbgBYMnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 07:43:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37088 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729686AbgBYMnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 07:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582634618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iaNn1ynq48vLpTxDrAlYN1oM6Y/pu6+O3QE2MamshO4=;
        b=QcngjVQ2hHoyBHV0/FoOCpRuS6eZn/Cd4qkkAtd5NhH40pDutNAjS4HPYNDpHzEfoL3ID2
        usqgI03JpnohH+JPSBSA/zd/nYPNfVSguOt3BNPfuNPTzmHfMQB+jWtBHm5PTX2m+5i0Vi
        En/EnPa7RDiviExxgqOfD+67ZJdEn5g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-aIJhlotYPqi5sAUBRm5wlw-1; Tue, 25 Feb 2020 07:43:37 -0500
X-MC-Unique: aIJhlotYPqi5sAUBRm5wlw-1
Received: by mail-wm1-f69.google.com with SMTP id k21so810800wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 04:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iaNn1ynq48vLpTxDrAlYN1oM6Y/pu6+O3QE2MamshO4=;
        b=naGSTNLMx8eQXNG3qRTMrUUL9t25mSRrT4CFsRi4kndjfJ0K8FCva+UKanhZgF8Qig
         3Nft0DMM8m3ubDSbo3oo/tTZg0SeLdCn1dHp4++wmzWxYB3XFI0BPjEF5go/7biCoUvH
         oDUw/o9Pj48NDcB9I67SON+6afWiVsEvoD1P5a2aDxRzy7dPaGLSSmB7ovnp0so9ycOP
         S7hRGYBKJ4EjRh53+yPcBpfdUCzTDwyxshTzsYVlxvTC3O/09BTonZNyLVhyORGJIALx
         HBCpK+baZJoBzycXbhgqcSGl43D68o4fhdRUXwZYc6aSbaFS4t+639IkXSvBM67d0Exz
         io4g==
X-Gm-Message-State: APjAAAUlvwX4GHeTsCTN7Mo0ETddtLs6mdO7J8P8nAe3b+EAhW5LLZ9V
        FhP9xLHukTePBXhEXGD8i7aqt7+v8ast6ENGtyvZ1is4HPrU5A/4ZgnK7T6GpmzqKIi2L+Gea5J
        XioYYEFJFzo+lm/yiHyvEfaA8
X-Received: by 2002:a1c:2089:: with SMTP id g131mr4891480wmg.63.1582634615979;
        Tue, 25 Feb 2020 04:43:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXpLSxXihQUnUiQh0jNgbtVlRTh4HV6fmkshzIW/LXmyh0n1o+t0mLFMw203AeYdGahwTdKg==
X-Received: by 2002:a1c:2089:: with SMTP id g131mr4891454wmg.63.1582634615709;
        Tue, 25 Feb 2020 04:43:35 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o27sm6334675wro.27.2020.02.25.04.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 04:43:35 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: X86: avoid meaningless kvm_apicv_activated() check
In-Reply-To: <1582597279-32297-1-git-send-email-linmiaohe@huawei.com>
References: <1582597279-32297-1-git-send-email-linmiaohe@huawei.com>
Date:   Tue, 25 Feb 2020 13:43:34 +0100
Message-ID: <87d0a2n8g9.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> From: Miaohe Lin <linmiaohe@huawei.com>
>
> After test_and_set_bit() for kvm->arch.apicv_inhibit_reasons, we will
> always get false when calling kvm_apicv_activated() because it's sure
> apicv_inhibit_reasons do not equal to 0.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/x86.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ddcc51b89e2c..fa62dcb0ed0c 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8018,8 +8018,7 @@ void kvm_request_apicv_update(struct kvm *kvm, bool activate, ulong bit)
>  		    !kvm_apicv_activated(kvm))
>  			return;
>  	} else {
> -		if (test_and_set_bit(bit, &kvm->arch.apicv_inhibit_reasons) ||
> -		    kvm_apicv_activated(kvm))
> +		if (test_and_set_bit(bit, &kvm->arch.apicv_inhibit_reasons))
>  			return;
>  	}

This seems to be correct in a sense that we are not really protected
against concurrent modifications of 'apicv_inhibit_reasons' (like what
if 'apicv_inhibit_reasons' gets modified right after we've checked
'kvm_apicv_activated(kvm)').

The function, however, still gives a flase impression it is somewhat
protected against concurent modifications. Like what are these
test_and_{set,clear}_bit() for?

If I'm not mistaken, the logic this function was supposed to implement
is: change the requested bit to the requested state and, if
kvm_apicv_activated() changed (we set the first bit or cleared the
last), proceed with KVM_REQ_APICV_UPDATE. What if we re-write it like

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2103101eca78..b97b8ff4a789 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8027,19 +8027,19 @@ EXPORT_SYMBOL_GPL(kvm_vcpu_update_apicv);
  */
 void kvm_request_apicv_update(struct kvm *kvm, bool activate, ulong bit)
 {
+       bool apicv_was_activated = kvm_apicv_activated(kvm);
+
        if (!kvm_x86_ops->check_apicv_inhibit_reasons ||
            !kvm_x86_ops->check_apicv_inhibit_reasons(bit))
                return;
 
-       if (activate) {
-               if (!test_and_clear_bit(bit, &kvm->arch.apicv_inhibit_reasons) ||
-                   !kvm_apicv_activated(kvm))
-                       return;
-       } else {
-               if (test_and_set_bit(bit, &kvm->arch.apicv_inhibit_reasons) ||
-                   kvm_apicv_activated(kvm))
-                       return;
-       }
+       if (activate)
+               clear_bit(bit, &kvm->arch.apicv_inhibit_reasons);
+       else
+               set_bit(bit, &kvm->arch.apicv_inhibit_reasons);
+
+       if (kvm_apicv_activated(kvm) == apicv_was_activated)
+               return;
 
        trace_kvm_apicv_update_request(activate, bit);
        if (kvm_x86_ops->pre_update_apicv_exec_ctrl)

Is this equal?

-- 
Vitaly

