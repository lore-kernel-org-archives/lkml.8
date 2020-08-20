Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651D7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46147207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFEeVnKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgHTMGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:06:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21829 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730349AbgHTJ6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597917527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8lvvw/yYxKRmz+hdWa2YvTezmPK88L9XFePRdHjAeE=;
        b=UFEeVnKfiyhT+nLdQ6pjJYWn2q135LQaRv+HpdQyx+3Y2N3XVARHE3hMby6shW5zvZ5/AO
        MslKa0U4nSYbEzMDDGVY42YyZ3v43HyFhclhSFdAlW/PsfND47/fb5JRZaLqx3LutmaAIN
        K2o4CmbsQ0ffyK7YpP62HQwxakU3Yz4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-Ri56sbYhOP-vqABCEVQyVg-1; Thu, 20 Aug 2020 05:58:45 -0400
X-MC-Unique: Ri56sbYhOP-vqABCEVQyVg-1
Received: by mail-wr1-f72.google.com with SMTP id l14so473146wrp.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 02:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t8lvvw/yYxKRmz+hdWa2YvTezmPK88L9XFePRdHjAeE=;
        b=s7QIBjU3555sb8eL63Hyp+2MA0YUkUR5mLwzRKahYz1lSg9AjRhRpJTAVfomqrY+Fl
         Q9XiC52a+iTW2eb2zI9ccjntHN/ySjquTDMuTLTMI9wi7vDCOuSUtcSICXfZ/5VtKdQP
         EzvglUk8SQuP/3/X0yjF3jiz6B0rOBDY7qUKSR1aYuh9zMXWiSdAf7uX4Zo2G++LWu9v
         7wuQeTrqGkNhcKQ6z/DHMs9ddD0vFyzyslyPqRr+7jus3FPE6XbLFR2KCxHeha860uFW
         kMT3Vgh5eOETBjIWc9PKpaVLSggPoXTU3j7ioKG7/ZTdXSxrTSW+xhankcrKiYsBYSfV
         nogg==
X-Gm-Message-State: AOAM533UYE3QoTVb+++BOCX5WKpCegZ1kqlHIIYqX+XGZ8zp4wKLDOZa
        0G2apkVYZ0XaPA6yMYfFyJSnJesluHGCzjmJMrhjDOiaiKCpYtc38S6sJ5FT2Fm+eN/B77idADl
        8hs8WM5S9hR7Qi31aKP7Jq+Ca
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr2892898wmb.54.1597917524020;
        Thu, 20 Aug 2020 02:58:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQG2uYPWfBztaiUxqZyq+dbAAl1wn0Yf6pusnnn3jC/iiRZELY2R1ZcTSp/HyzwfQlSLGT+Q==
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr2892879wmb.54.1597917523784;
        Thu, 20 Aug 2020 02:58:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745? ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
        by smtp.gmail.com with ESMTPSA id t14sm3517781wrg.38.2020.08.20.02.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 02:58:43 -0700 (PDT)
Subject: Re: [PATCH 5/8] KVM: nSVM: implement ondemand allocation of the
 nested state
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20200820091327.197807-1-mlevitsk@redhat.com>
 <20200820091327.197807-6-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <476eecc8-a861-203c-40f5-46707d8c0237@redhat.com>
Date:   Thu, 20 Aug 2020 11:58:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200820091327.197807-6-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/20 11:13, Maxim Levitsky wrote:
> @@ -3912,6 +3914,14 @@ static int svm_pre_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
>  	vmcb_gpa = GET_SMSTATE(u64, smstate, 0x7ee0);
>  
>  	if (guest) {
> +		/*
> +		 * This can happen if SVM was not enabled prior to #SMI,
> +		 * but guest corrupted the #SMI state and marked it as
> +		 * enabled it there
> +		 */
> +		if (!svm->nested.initialized)
> +			return 1;
> +
>  		if (kvm_vcpu_map(&svm->vcpu, gpa_to_gfn(vmcb_gpa), &map) == -EINVAL)
>  			return 1;

This can also happen if you live migrate while in SMM (EFER.SVME=0).
You need to check for the SVME bit in the SMM state save area, and:

1) triple fault if it is clear

2) call svm_allocate_nested if it is set.

Paolo

