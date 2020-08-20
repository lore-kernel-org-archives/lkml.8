Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6ACC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2FC822B40
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiDyaWk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgHTKHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39678 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730361AbgHTKBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597917680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xtUkw1+pgkP1u0CE6ZeSzJD33eQ60AqxVBB24zxNhsI=;
        b=OiDyaWk5d5AhnAHKmBZYkcd6kn0qtiOTFcY4p2fJSK4ANTzpHgrhnb0yi2nRIh9a0g1IZf
        mbLjbdI0fqzfG0ez9+s72f9jvXduR6o+ZN375g2zs7MhItUPgOZ8HmPD1DBlJmkf7xDME7
        WuPsn86VYsNFm27eex3ABcBEeZLX8Ic=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-pVi6lbvtM4S9QiyUbS4wnw-1; Thu, 20 Aug 2020 06:01:18 -0400
X-MC-Unique: pVi6lbvtM4S9QiyUbS4wnw-1
Received: by mail-wm1-f71.google.com with SMTP id u144so604234wmu.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 03:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xtUkw1+pgkP1u0CE6ZeSzJD33eQ60AqxVBB24zxNhsI=;
        b=d5teiRFQ1NTiptiBN02FbIt/cDqHIYhjtJsBem1/w5UOVZc1MOsuefjIbyrz+13uj9
         CgD/w4MuC97229X1YqYb66VseBTKgWnGq9NY8B4cru29SCsiQjVGXkh3IqTrQz2Mvxym
         OINJj5sjN5YC4VB16KLh+TS5bmOzV37Xtp6sQBJVzQ4mj8UdJWQceMAwjkzrdjGmDEXB
         2StC/hYZXEGbH5EDAwwhylLl+itBj5X4EGU77aPFkZw9GQLj1SZ+q1JbLrMn2GyP+Ga8
         PbY9KituBBppfmfRO7YadlOYkA0FDHJdI/iD4AeYC/HJeMaQ4bKEFnSdn2eSaTbjsrK1
         5d3A==
X-Gm-Message-State: AOAM530EcAJy6ebiiVpu4Ya+xpJ7jsZ0rrLenKR4y822phiDTTd9TBRZ
        XMIBQSkFrAJx67z4ohXX5ynfSbAf6Da+gEwT8LCHT0NmHFzPulXwlWORbEkX6L67YAX1zvmQTft
        MCRIM6Csqop6v6IWkq2EfocvX
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr2687074wma.122.1597917677216;
        Thu, 20 Aug 2020 03:01:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4gKUiUJ6EoQh9xoNdvazNihbXQF/czcITGb1+BqN75JHRCFO/tyWZLCjckhAt6e9saona4Q==
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr2687048wma.122.1597917676995;
        Thu, 20 Aug 2020 03:01:16 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id n18sm3077185wrp.58.2020.08.20.03.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 03:01:16 -0700 (PDT)
Subject: Re: [PATCH 8/8] KVM: nSVM: read only changed fields of the nested
 guest data area
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
 <20200820091327.197807-9-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <53afbfba-427e-72f5-73a6-faea7606e78e@redhat.com>
Date:   Thu, 20 Aug 2020 12:01:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200820091327.197807-9-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/20 11:13, Maxim Levitsky wrote:
> +	u32 clean = nested_vmcb->control.clean;
> +
> +	if (svm->nested.vmcb_gpa != vmcb_gpa) {
> +		svm->nested.vmcb_gpa = vmcb_gpa;
> +		clean = 0;
> +	}

You probably should set clean to 0 also if the guest doesn't have the
VMCBCLEAN feature (so, you first need an extra patch to add the
VMCBCLEAN feature to cpufeatures.h).  It's probably best to cache the
guest vmcbclean in struct vcpu_svm, too.

Paolo

