Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63722C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A94E2076B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITiF6Qjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgFAQfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:35:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26332 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726017AbgFAQf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591029327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zc9wyn742yLh7B24rM+A2xhouSXE07FcUGUaBsY67qY=;
        b=ITiF6Qjya9d8Dxk3YZ4KUxm9PqjYlw1AUnjmIIPxzeCtUGvFhgIoplFsFtt0fw2VmFe5Xi
        vynmJWBzm4tTsKFckw3JeyCafEsXnKUV8wWotutlS9dgj1XkrHzqB+A17RD9tSlRxYAcaa
        yZ8KUhOFeq8yqXJ00x/g8i2duF4I2zs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-Siizjmm1Ppylx5XvFmsfcA-1; Mon, 01 Jun 2020 12:35:26 -0400
X-MC-Unique: Siizjmm1Ppylx5XvFmsfcA-1
Received: by mail-wm1-f69.google.com with SMTP id x6so13398wmj.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 09:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zc9wyn742yLh7B24rM+A2xhouSXE07FcUGUaBsY67qY=;
        b=AF1+aOcBx+GpUZEkG/zOfdAx7Xml6fSSnJzrCt3QFCLxkmN0h95LFzhlGqpuiyGzFS
         J5k2KpT3TXp4PFk4tRyXZPhQTGq9OeJyxSwnbMHaAndJzC/Dq6d494hmNBI3JxS+FCgu
         HBjKCAIhqesZv72fBJTI4Ff4VCA56I4ABBUxQQT+ridJpQ2ybogpMg37dkCPG3SNGgMX
         NNv1w35H1Ds+f8Pj5wIvkwii3tgh24MMn761iqTaNZeEsftRFy5X6Rqr+BF7/9urkLGo
         ls4zSTnbTwOlOaglq5FYqrcW6hKbRkv9CvPk/7i08Wr80WjVKwd8zeqeLPHS2kcprFWg
         zc0g==
X-Gm-Message-State: AOAM530y/WJIRGWjd+tynM+5+Glc8gZHOHVpioT2Je0TwMx3hGZUotuj
        C3rHfbrCiOWRSWapUy20WiZg33kzE6eJ4ykwOcrU6GW4hpq7OsLUSKPhAh1kUpRIvbzo5aeNdKH
        nCxQdE572FqdPEvb/qs7VA1HC
X-Received: by 2002:a1c:3585:: with SMTP id c127mr186486wma.34.1591029324727;
        Mon, 01 Jun 2020 09:35:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9UvBpHprFyqkB9INncZbq9Zh/UjdnJcRudmhYbCdzWCCop0k8OMkWVXIN62P1rQ5lrNmQZw==
X-Received: by 2002:a1c:3585:: with SMTP id c127mr186466wma.34.1591029324534;
        Mon, 01 Jun 2020 09:35:24 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id 138sm194273wma.23.2020.06.01.09.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 09:35:23 -0700 (PDT)
Subject: Re: [RFC 06/16] KVM: Use GUP instead of copy_from/to_user() to access
 guest memory
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200522125214.31348-1-kirill.shutemov@linux.intel.com>
 <20200522125214.31348-7-kirill.shutemov@linux.intel.com>
 <87a71w832c.fsf@vitty.brq.redhat.com> <20200525151755.yzbmemtrii455s6k@box>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a5acc4c8-2ee6-9e5d-c0a5-2a6f7c54c059@redhat.com>
Date:   Mon, 1 Jun 2020 18:35:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200525151755.yzbmemtrii455s6k@box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/20 17:17, Kirill A. Shutemov wrote:
>> Personally, I would've just added 'struct kvm' pointer to 'struct
>> kvm_memory_slot' to be able to extract 'mem_protected' info when
>> needed. This will make the patch much smaller.
> Okay, can do.
> 
> Other thing I tried is to have per-slot flag to indicate that it's
> protected. But Sean pointed that it's all-or-nothing feature and having
> the flag in the slot would be misleading.
> 

Perhaps it would be misleading, but it's an optimization.  Saving a
pointer dereference can be worth it, also because there are some places
where we just pass around a memslot and we don't have the struct kvm*.

Also, it's an all-or-nothing feature _now_.  It doesn't have to remain
that way.

Paolo

