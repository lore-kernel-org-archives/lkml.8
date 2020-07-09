Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39079C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154F5205CB
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxZTO0MH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGIKzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:55:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37296 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726440AbgGIKzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594292143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PTDQffC1tMzQ3lRtufW6bbJO7+lFsHLO2yhqYkX2OD4=;
        b=QxZTO0MHOjoMsLponAWRcaUZKRRU8DejNe2c02wnHxT49Dr6xUpVPgDyo8CNhcKVNYwFD2
        valg6tSajevEvp3HV30ACDh/irSOyvW35JqW/+uxHjU2VAaCmwzoq8bTsLyx0H/SIAFezH
        ZQp1lEe/+YgxEk+jnC/axhzM8igWtpA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-GI69mxv9McWVzaADABOP6Q-1; Thu, 09 Jul 2020 06:55:41 -0400
X-MC-Unique: GI69mxv9McWVzaADABOP6Q-1
Received: by mail-wr1-f70.google.com with SMTP id o25so1603944wro.16
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 03:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PTDQffC1tMzQ3lRtufW6bbJO7+lFsHLO2yhqYkX2OD4=;
        b=aB0Zi8+xdlI1P+dowhTzmnYyBz9fqR/idukoKdmA0KVy4h1QLWbgKYdGFuh8VgHLxG
         Ryj/9RTpYNwuAf0yk70WgnWng7R4JonN3UEChz1as+a+ck3CaK6OgFhuMkY8PN2O1UwX
         SSk7B2U3YnUwjeqkhqrhmunsM3UKgYnRBV2HV/LzHOEI8lt1JiE9r2QOZld6lybufS/9
         RUKeCPFaCMaaX8M053NUfpySZ43cfB6HCZa1HeqektWbbbRkoby6uMuvHdfZp1is5Txs
         YhNWiFdqMiqbUcXrlGatU5uRvfTUJx30pN7RzBBoSMIfZZlMbYhAtnTKTidzDj/a+yxv
         NBHA==
X-Gm-Message-State: AOAM530WufdD069StLBtQcWp0bEnMHi6zuQ4m8pJAMixKecKev9MWbh4
        3wfi9ndruYPRiLbKs+AfqqhrUqRITiN6y5rmuoJPsZ6NMI97XBMyr85nDFdsrxmugNu2yCrARw3
        /w/VAIKwWHr6TGlwBtpa3nTsy
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr32647617wrm.113.1594292140037;
        Thu, 09 Jul 2020 03:55:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4j0HtIxJr87LdzFPez74tjNG36xLEG2m4Lx3KIWQk4DnBnjXipmFHn/FMzkdbo05bFcQn0w==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr32647598wrm.113.1594292139839;
        Thu, 09 Jul 2020 03:55:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id u74sm4334245wmu.31.2020.07.09.03.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 03:55:39 -0700 (PDT)
Subject: Re: [PATCH v4 2/5] KVM: x86: Extract kvm_update_cpuid_runtime() from
 kvm_update_cpuid()
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200709043426.92712-1-xiaoyao.li@intel.com>
 <20200709043426.92712-3-xiaoyao.li@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <27a4c18f-ba14-90f6-7918-f4520e7f3a69@redhat.com>
Date:   Thu, 9 Jul 2020 12:55:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709043426.92712-3-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/20 06:34, Xiaoyao Li wrote:
> Beside called in kvm_vcpu_ioctl_set_cpuid*(), kvm_update_cpuid() is also
> called 5 places else in x86.c and 1 place else in lapic.c. All those 6
> places only need the part of updating guest CPUIDs (OSXSAVE, OSPKE, APIC,
> KVM_FEATURE_PV_UNHALT, ...) based on the runtime vcpu state, so extract
> them as a separate kvm_update_cpuid_runtime().

I'm not sure KVM_FEATURE_PV_UNHALT counts as one of these, but I guess
it's not a big deal.

Paolo

