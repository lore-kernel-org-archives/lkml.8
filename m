Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF76C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA4720578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqqPZTQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgCODfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 23:35:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39805 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726506AbgCODfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 23:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584243320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0LyD0PJgIGGLoQzoojfk9tWf5U8ULkM9R+XCQsoyJqs=;
        b=RqqPZTQVjg390cDJb3QMUqUizuBobFPD2UFO9LMrPVFF+O9XBo5/DzKF5sP5hHK5uXZrPP
        KX/ErysS+fmSAIFCCQG1Xn9NmKwdtk7kMJEQMyunWPlU6d7C7IHg2hUzTSdfmIjjEPmHTp
        QhvUx45rgloTX9Z/IDH2BZCJwAjwTWk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-FmR8M-COMgqboDJOSxCuzQ-1; Sat, 14 Mar 2020 07:31:31 -0400
X-MC-Unique: FmR8M-COMgqboDJOSxCuzQ-1
Received: by mail-wr1-f70.google.com with SMTP id u12so3375773wrw.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 04:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0LyD0PJgIGGLoQzoojfk9tWf5U8ULkM9R+XCQsoyJqs=;
        b=RblEegJmrElqLqiH5HY92oJcswvIWXCr4BK8Nxn7btUjoqMZ2xn0NENHvHkQtsZplA
         CS5IeFMhT/BOTbePCl3rZSt5BhBdFirCifiNHUjY7bvq0hnOeqbd+GqJr+Hgbnc8RUza
         3KftLesmKWmajitxFh6jbSzMt1NU2xmDpZjYudBR1h7D2KwEPi31UnnK0gwQnk7P//jY
         rcS+s+nZG258nLs22O/SdrQYDPtBjGnBJpLTdx4OoeAili0LrrRjGx3D8qXstTdeZlRC
         yny3HkeCu0U0ogw+RdYtyuz9EFivA23Pde+09M82b3GAPXCWhgqsxitLW4DknPwuwkrP
         bzrg==
X-Gm-Message-State: ANhLgQ1HnsaP2CHpO5yaSgtX7cicD7gkMZE6fB6j7ETYTk5Tebl3WR3m
        0xxEv10j5P2gMRzJ1iHddWL0iXLnRwkIRQc4096O5uN7py6VmfvAQrCVP+U9VJSUC2bDrIhVko4
        6V+mW6+jks57qBBC2WGH/R6Ar
X-Received: by 2002:a1c:23d5:: with SMTP id j204mr16789896wmj.59.1584185490037;
        Sat, 14 Mar 2020 04:31:30 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs7P00MYsmC+SvAzqAncBQeg6TZFVmmUDSznYiD+XlMbi+A+TDwdXXwziZQe0yzu+wo3xeiRA==
X-Received: by 2002:a1c:23d5:: with SMTP id j204mr16789874wmj.59.1584185489799;
        Sat, 14 Mar 2020 04:31:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7de8:5d90:2370:d1ac? ([2001:b07:6468:f312:7de8:5d90:2370:d1ac])
        by smtp.gmail.com with ESMTPSA id y3sm47966512wrm.46.2020.03.14.04.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2020 04:31:29 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: avoid meaningless kvm_apicv_activated() check
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
References: <1582597279-32297-1-git-send-email-linmiaohe@huawei.com>
 <87d0a2n8g9.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7c0aedea-36dc-bd84-b7ba-1aa6d1cceb11@redhat.com>
Date:   Sat, 14 Mar 2020 12:31:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87d0a2n8g9.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/20 13:43, Vitaly Kuznetsov wrote:
> If I'm not mistaken, the logic this function was supposed to implement
> is: change the requested bit to the requested state and, if
> kvm_apicv_activated() changed (we set the first bit or cleared the
> last), proceed with KVM_REQ_APICV_UPDATE. What if we re-write it like
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 2103101eca78..b97b8ff4a789 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8027,19 +8027,19 @@ EXPORT_SYMBOL_GPL(kvm_vcpu_update_apicv);
>   */
>  void kvm_request_apicv_update(struct kvm *kvm, bool activate, ulong bit)
>  {
> +       bool apicv_was_activated = kvm_apicv_activated(kvm);
> +
>         if (!kvm_x86_ops->check_apicv_inhibit_reasons ||
>             !kvm_x86_ops->check_apicv_inhibit_reasons(bit))
>                 return;
>  
> -       if (activate) {
> -               if (!test_and_clear_bit(bit, &kvm->arch.apicv_inhibit_reasons) ||
> -                   !kvm_apicv_activated(kvm))
> -                       return;
> -       } else {
> -               if (test_and_set_bit(bit, &kvm->arch.apicv_inhibit_reasons) ||
> -                   kvm_apicv_activated(kvm))
> -                       return;
> -       }
> +       if (activate)
> +               clear_bit(bit, &kvm->arch.apicv_inhibit_reasons);
> +       else
> +               set_bit(bit, &kvm->arch.apicv_inhibit_reasons);
> +
> +       if (kvm_apicv_activated(kvm) == apicv_was_activated)
> +               return;

Yes, I got to the same conclusion before seeing you message.  Another
possibility is to use cmpxchg, which I slightly prefer because if there
are multiple concurrent updates it has some possibilities of avoiding
the atomic operation and consequent cacheline bouncing.  I've sent a patch.

Paolo

