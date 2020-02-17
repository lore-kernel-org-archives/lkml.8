Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC4FC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842C520656
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caBRZNFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgBQRQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:16:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47122 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729226AbgBQRQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581959762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f1LZGD5WNqtz5rIbXI6TpBQUDWxl65cn90/dkNdr5mw=;
        b=caBRZNFG1aqX4qT113JEMHNGhurmwcSgHEweio/J/V60wI+DDEaKht8EnES11gxhj9CNKr
        RdrcpOFM+RLrqNgejsHMCqWqp5VYWezp8uziJ8Axjor0i+Uv9FkKmEX3bSLpHltJZaSLb9
        qvRR7GPGAh5pUuQRXsShJS6nqJt1Lxs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-KmuWz23nPE2RUzjFfuLwnA-1; Mon, 17 Feb 2020 12:14:48 -0500
X-MC-Unique: KmuWz23nPE2RUzjFfuLwnA-1
Received: by mail-wr1-f72.google.com with SMTP id 50so9305301wrc.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 09:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f1LZGD5WNqtz5rIbXI6TpBQUDWxl65cn90/dkNdr5mw=;
        b=q0D0qGJ8hi5BQIpedaIfARHIHvMSHhLjhB6REVHA+P0NHLpJFZpOt0v9lLpPcdtBnW
         pQms5CDWEEnIYXLrdgWdZzsSwRX4RNZ1W5dy5KcbPUNKC5dOOeVqP7BryevWm8DZPyMi
         PrZ27s0po1eRB6W7kfqkvlUiH8vedEJwOCcIaPaycau+4mpmxrkasgobNidB6aL8V8ep
         YZqtyw1X8CWgJgO0iZGTlPdnclyoYWqq3zhSViXePD10syDz4UjqEqBIbUHx2wNGCWdw
         AxND7XwfANZhWeqWCjjiykQHtBxUFF/70ls7rrsMevV61DA/wn7AV5s3o8Kq+9Uq0hVM
         wmUw==
X-Gm-Message-State: APjAAAXokSS/q2PNeg7sPYd9mnUG5QhI6FZbmx2Xh99g7PatJl4lPxor
        g6glqZj8ip0J7pvMAJrkoVGZfPfV6fd6Kg1xdxbmljOBgBJHjQ6MOXC2WJcaLTRR82B2+/CF/EU
        gINwFQtLCs8mAv0TtCQypJSpT
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr22198754wro.279.1581959687161;
        Mon, 17 Feb 2020 09:14:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzMdCEUTe/MyuDEjjJD3/8S3SMGQhBkx3p/6bMu4ZJG7y/qDDJMFMEHco03lwFK/cDS7ORBrg==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr22198735wro.279.1581959686973;
        Mon, 17 Feb 2020 09:14:46 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4? ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
        by smtp.gmail.com with ESMTPSA id u62sm117423wmu.17.2020.02.17.09.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 09:14:46 -0800 (PST)
Subject: Re: [PATCH] KVM: VMX: Add VMX_FEATURE_USR_WAIT_PAUSE
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20200216104858.109955-1-xiaoyao.li@intel.com>
 <87r1ytbnor.fsf@vitty.brq.redhat.com>
 <bb0302e1-c946-2695-8468-d08c3b146b76@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aea2c71a-b4b8-14f4-c55a-2498fc09986e@redhat.com>
Date:   Mon, 17 Feb 2020 18:14:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <bb0302e1-c946-2695-8468-d08c3b146b76@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/20 09:57, Xiaoyao Li wrote:
> What an uncareful typo. Thanks!

No problem, queued.

Paolo

>>>   #define VMX_FEATURE_ENCLV_EXITING    ( 2*32+ 28) /* "" VM-Exit on
>>> ENCLV (leaf dependent) */
>>>     #endif /* _ASM_X86_VMXFEATURES_H */
>>
>> With the typo fixed (likely upon commit),
>>
>> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>>

