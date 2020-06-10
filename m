Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31DDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6402072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfuT5smW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgFJVHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:07:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42211 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726134AbgFJVHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591823227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tu2jjGryr0LbbIINiT9lskQiUTJPT9zi4N6MojzSreQ=;
        b=AfuT5smWTgKLg0AgXZGy3ra/HJB76khe9afG9e1W8PFOmljOa3mKEJPijxIBg+mWmGUMMN
        ae2y1+nPqvmU+1vk41z/Rgu56Ew5ZIfVnbehHZw0sps0oZMUFZV6YAPPet+RSZhH6y7ihn
        1JPtrYz9pZVIm/EWEQTdCUjI6fz0YeA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-XMsteDERNHOIiUg-6j6Hmw-1; Wed, 10 Jun 2020 17:07:06 -0400
X-MC-Unique: XMsteDERNHOIiUg-6j6Hmw-1
Received: by mail-wr1-f72.google.com with SMTP id z10so1616115wrs.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tu2jjGryr0LbbIINiT9lskQiUTJPT9zi4N6MojzSreQ=;
        b=YE/j0HdSSxulrIDinghDesh1N7q3WiWssTas4B1bqxcCuOLJqLeywmpCViOsRNggqK
         iSib2g44t86pXfOCE2f0ADvnieHJQ+NQPJkGCOtD58S1ush8GmZ3K0msagIpEKUYujpj
         YFfEk6V/NccK6hbZ5okEsfTrGxFggontKYJtoIqH3hUEd6hI8VgqC0twgO4R+oMoql9d
         WxNY4SvVIHzeF9hqOdOjqcTXaebbpbr9s01IzvdX6EjNOB03t9FDdV1pThFF+9IIFaEv
         ijP9srXWcPoLCQYFYSnSeX5LC/3AjVEs4tncvogepqtwsTBBM5wsQHJEboebCtJpznl5
         yg3A==
X-Gm-Message-State: AOAM531PONUevBo0VZmDubDvrsVL1XygNNkLUOk+YNYbjwlWrE0TdRG7
        hizaEfRCJ9J/HGZ8Kayv4PPta/Ww6WOs+GqhyjoEppTBZ0kA9RQPdJYTnxPSPrG0jaTE4t083ab
        R+3lFssOgisPHG1f5waN/X7Lv
X-Received: by 2002:a1c:7903:: with SMTP id l3mr4812447wme.50.1591823222127;
        Wed, 10 Jun 2020 14:07:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwB9u5OHRHTxISVcb8apV6jQZ2qzFcqJQzCsm1Vb79yhDGrB86d0X9sNVypofwaxUeYAbWMHw==
X-Received: by 2002:a1c:7903:: with SMTP id l3mr4812425wme.50.1591823221882;
        Wed, 10 Jun 2020 14:07:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29ed:810e:962c:aa0d? ([2001:b07:6468:f312:29ed:810e:962c:aa0d])
        by smtp.gmail.com with ESMTPSA id f11sm1369605wrm.13.2020.06.10.14.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 14:07:01 -0700 (PDT)
Subject: Re: [PATCH v2 08/10] KVM: x86: Switch KVM guest to using interrupts
 for page ready APF delivery
To:     Vivek Goyal <vgoyal@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20200525144125.143875-1-vkuznets@redhat.com>
 <20200525144125.143875-9-vkuznets@redhat.com>
 <20200610205145.GC243520@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <da087813-7be4-0e3c-d93c-a29d6933b69d@redhat.com>
Date:   Wed, 10 Jun 2020 23:06:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200610205145.GC243520@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/20 22:51, Vivek Goyal wrote:
>> KVM now supports using interrupt for 'page ready' APF event delivery and
>> legacy mechanism was deprecated. Switch KVM guests to the new one.
> Hi Vitaly,
> 
> I see we have all this code in guest which tries to take care of
> cases where PAGE_READY can be delivered before PAGE_NOT_PRESENT. In
> this new schedume of things, can it still happen. We are using
> an exception to deliver PAGE_NOT_PRESENT while using interrupt to
> deliver PAGE_READY.
> 
> If re-ordeing is not possible, then it will be good to get rid of
> that extra complexity in guest.

It is perhaps less likely but still possible, because the interrupt
might be delivered to another CPU and race against the exception.

Paolo

