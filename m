Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E83C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251FA2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOWTL1vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbgG3Wtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:49:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60419 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728588AbgG3Wtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596149369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKyJrYWDX6x969FmRZ0QcDqOUbfYEkv8rsi7p3uCKKw=;
        b=SOWTL1vm3f4oE5Qa3ZDIj0TjgkNK0o7Hq90gcS+7sXok0w43cYhos+Ki9+/BYJwmBjExDJ
        HLXw4cKlMkn2QXpPk3CnWwcRzh01iolxOO7GK1BuCr4zzGDvm1EWVn95vLnWVZn/Lpr/PX
        D0F2CstoSR/E9Txa9Ssm98gmUwRQSTk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-05PNKzhdNcGoHCMXztb2og-1; Thu, 30 Jul 2020 18:49:28 -0400
X-MC-Unique: 05PNKzhdNcGoHCMXztb2og-1
Received: by mail-wr1-f69.google.com with SMTP id 89so8398029wrr.15
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 15:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AKyJrYWDX6x969FmRZ0QcDqOUbfYEkv8rsi7p3uCKKw=;
        b=imKM4vL6uU9BZGrsnfVGbP8qvw1QLKYJwyeuZ+nSLANWQnv/xQNOLnv/cQRfxFiX3k
         i0RyG8p8o42F/D0ZfyRcXR7O+TOBppwErnR30J/fCC3WirrINADSUgAwLAcTlJs4eRyY
         /T32UbKJNtqVv1fClRqk5F9FfY4MKwVpf3MU+cW+cOkkWc0V3ju8nRS9PTEAJ9QtZTAJ
         an+CAsHTu802B3jB/MjxTgEg89uEjiuwZ7B4PoCBdzq2wZeyyclAfBKKjulMWTrr3yxp
         fooMQQgDdmzK8YLYAG88bPlU4YyxKm/ZuSfQczyJK39WLPsuaLoLqmkjRXLtnhg4pYaV
         iN0w==
X-Gm-Message-State: AOAM533bxl/9YMN48Vl4s1rS34b8XvDijzxtwY5xwsZiWwxeEBrf9h3W
        jONfTZZcb6qlX58VgX/KP8SVLZTKvOBjDMozWOI513KApK2h4YGFm9IE8e3m2u3X9Pwv+BdoV0O
        EEl5uWRcF+SAYZQgtjg7UcDP+
X-Received: by 2002:a05:600c:2888:: with SMTP id g8mr1244787wmd.118.1596149366789;
        Thu, 30 Jul 2020 15:49:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiSvm3UnA27GuaplhnTlAkbTEsPEhFvd2AYU6wvlMVGQFr2KY+Xr1z3LwwSh73Mtd0o/Yd0w==
X-Received: by 2002:a05:600c:2888:: with SMTP id g8mr1244781wmd.118.1596149366596;
        Thu, 30 Jul 2020 15:49:26 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id k4sm12545213wrd.72.2020.07.30.15.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 15:49:26 -0700 (PDT)
Subject: Re: [PATCH v3 03/11] KVM: SVM: Change intercept_dr to generic
 intercepts
To:     Babu Moger <babu.moger@amd.com>, Jim Mattson <jmattson@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <159597929496.12744.14654593948763926416.stgit@bmoger-ubuntu>
 <159597948692.12744.7037992839778140055.stgit@bmoger-ubuntu>
 <CALMp9eRF-ScqaWG7vn2mxKmR4jWo7LYZiiicHksiZR9hh+G=-A@mail.gmail.com>
 <3841a638-eb9e-fae6-a6b6-04fec0e64b50@redhat.com>
 <2987e401-f021-a3a7-b4fa-c24ff6d0381b@amd.com>
 <560456cc-0cda-13f6-d152-3dca4896e27f@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3737d3b5-0569-bba3-cda1-9967e9651365@redhat.com>
Date:   Fri, 31 Jul 2020 00:49:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <560456cc-0cda-13f6-d152-3dca4896e27f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/20 00:41, Babu Moger wrote:
>> Let me try to understand.
>>
>> vmcb01 is &svm->vmcb->control;l
>> vmcb02 is &svm->nested.hsave->control
>> vmcb12 is  &svm->nested.ctl;

Right now we don't have a separate vmcb01/vmcb02, we have the current
and hsave VMCBs.  Cathy is working on it.

Just do the refactoring by passing the control area to
vmcb_set_intercept/vmcb_clr_intercept/vmcb_is_intercept.

>> The functions set_intercept and clr_intercept calls get_host_vmcb to get the
>> vmcb address.
>
> I will move the get_host_vmcb inside the caller and then call
> vmcb_set_intercept/vmcb_clr_intercept/vmcb_is_intercept directly.

Hmm no I think set_intercept and clr_intercept should remain as is.

Paolo

> I will re post the series. This will change the whole series a little bit.

