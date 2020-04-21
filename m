Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE453C55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC972076A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlrVX0Gs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgDULQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 07:16:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53021 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDULQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587467806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=97DLxg4Yjg3km/mFNl5Zacv6VSLE1VXtqLZ5V4giXi0=;
        b=HlrVX0GsVKY+PNOhH8kTEyTdXU1qVbiJHKgccyIqX3DhE6pqXPhMEgn7owWA0C3bBOWVnf
        T8eHCQPdf0JTtQ1kTLSllOrjsYfchMeq8RNEo8uoJBxNRx1hz0tBmFVCgt90lnTAqFz/ZM
        rgo4EOYKmdzPYEx+hVdV4wjssYoW+Nk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-4NZ7qyVbNU-zDvsmYgxkfQ-1; Tue, 21 Apr 2020 07:16:44 -0400
X-MC-Unique: 4NZ7qyVbNU-zDvsmYgxkfQ-1
Received: by mail-wr1-f72.google.com with SMTP id i10so7313044wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 04:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=97DLxg4Yjg3km/mFNl5Zacv6VSLE1VXtqLZ5V4giXi0=;
        b=jrA8xI4s62W8juof+/CHVJQXh/Vz0xbtnqUEEAwkY2xckghnbXxzJGxK8+v9HXvizr
         EOWzOXh2s1zIi6yxTYniodwC+UJlNA++aGe5GcEDOgvX2wT8TYQis0QugBnerOYb+QdM
         5fydesyQTasV23SiWRF6b7HsitWRAHBN5qm3gmCGg7wSmZvLjfUN7U/XLnbCeDHpk/dF
         M9JXtvwanBEQf0lxXlNg1yLfQ6lQtkQRf50UVmmw/TtQ9+1rkiLQW4JOnvD/cDqdznLn
         OL5sbAvcV/tBKK2U3tp5oQDFG9Fyr0X41K7sV01Vptk11lNxtFZ3XlF9xcwgspHCFzNs
         mC6Q==
X-Gm-Message-State: AGi0Puaaa9bWAMS1PHvvWFH2mS0rOR6JDBbDH1TJqfSu7cDuIVU0hjt0
        YnmPlT4u+ANrjEmyYc3amzYJ6CpqlQFth8Moz9uO8PdElHb4wrzfuGR5QeHTF/V9jWmgeKaKnw8
        cJX116P1WI7NPAx8C7AGdFk9m
X-Received: by 2002:a5d:5652:: with SMTP id j18mr6767442wrw.40.1587467803535;
        Tue, 21 Apr 2020 04:16:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypIM+q3J6iSnskRnURVF3g9hh9MdKKvxJisuR8ZZlbkBs6sJqC1TWZ4HVghfB2r6qghAm3/t8A==
X-Received: by 2002:a5d:5652:: with SMTP id j18mr6767417wrw.40.1587467803259;
        Tue, 21 Apr 2020 04:16:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446? ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
        by smtp.gmail.com with ESMTPSA id t17sm3290485wro.2.2020.04.21.04.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 04:16:42 -0700 (PDT)
Subject: Re: [PATCH 1/4] KVM: x86: hyperv: Remove duplicate definitions of
 Reference TSC Page
To:     Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
References: <20200420173838.24672-1-mikelley@microsoft.com>
 <20200420173838.24672-2-mikelley@microsoft.com>
 <20200421092925.rxb72yep4paruvi6@debian>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c2bae31-14a8-39cf-6e6d-139d84146477@redhat.com>
Date:   Tue, 21 Apr 2020 13:16:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200421092925.rxb72yep4paruvi6@debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/20 11:29, Wei Liu wrote:
> On Mon, Apr 20, 2020 at 10:38:35AM -0700, Michael Kelley wrote:
>> The Hyper-V Reference TSC Page structure is defined twice. struct
>> ms_hyperv_tsc_page has padding out to a full 4 Kbyte page size. But
>> the padding is not needed because the declaration includes a union
>> with HV_HYP_PAGE_SIZE.  KVM uses the second definition, which is
>> struct _HV_REFERENCE_TSC_PAGE, because it does not have the padding.
>>
>> Fix the duplication by removing the padding from ms_hyperv_tsc_page.
>> Fix up the KVM code to use it. Remove the no longer used struct
>> _HV_REFERENCE_TSC_PAGE.
>>
>> There is no functional change.
>>
>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
>> ---
>>  arch/x86/include/asm/hyperv-tlfs.h | 8 --------
>>  arch/x86/include/asm/kvm_host.h    | 2 +-
>>  arch/x86/kvm/hyperv.c              | 4 ++--
> 
> Paolo, this patch touches KVM code. Let me know how you would like to
> handle this.

Just include it, I don't expect conflicts.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

