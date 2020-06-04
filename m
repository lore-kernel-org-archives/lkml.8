Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B78FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C6FB206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkmlohsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgFDQUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:20:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45082 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729765AbgFDQUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591287634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c0B1gOCQB3tsMAy6nQWjh9wldszMTnQJEuaouLyuBOY=;
        b=NkmlohsQlfsbJ8hHTHYZ8kXQe/aggq074zd3ZZ1pDa6DAkfIAw0AN0+K4m/yO3mu1uPF0H
        d1V4OQh00meymQR8jOYUGQQKHWuJSIWxpt23iPPdo5TW05tqL38I0yBNC5DrLyKXcj+Aax
        aK1BOGxK2AcIVQF+OOlmQSXZBOqcQKY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-BkptHBVwPQqQAU5QwNFBhg-1; Thu, 04 Jun 2020 12:20:33 -0400
X-MC-Unique: BkptHBVwPQqQAU5QwNFBhg-1
Received: by mail-wr1-f69.google.com with SMTP id l1so2619074wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 09:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c0B1gOCQB3tsMAy6nQWjh9wldszMTnQJEuaouLyuBOY=;
        b=ff+9H0i+TfFladok78pu8ZQBcEd4MwpaEDrYsWx3cR2Y0ymNtFPWKEjj5iDdOluc2A
         UtCg0fSaPuKd120pZ5kH9zgi+kPJ4RAVQsl5qJk0428zPCGWXB4LIVcUUv8/yIC2ZSyu
         BQ1R/ndW6isHGsSLgbB2O/jCfagyuHkf12HHhFNDIDcKe4UrANr7lS3TJoKk25yX/qNa
         vYmhlwQ3MZ2VdLvlLTYoOPo+S6FKy7ExDbz2ZwNTbH23g6HH9yRh1U4sCR+EzOFdHmoB
         UL0TmSwmu8JtvAI3WfIU01o5PCNPU2HzmeFop/k2vsu0lonYFNys14+gQ24wtuHxB5J7
         /ttQ==
X-Gm-Message-State: AOAM533d8kA56NDmd5GWZAQmjgrz8IKLKweK+C19OhiXx8DeZVuUDYbx
        7BKTK6jzt0GiEM4wOBdmx1p2tMHBGGEpVqNi5XKR53sTXSCK+mXd6JwcFyugH312KFef1EYeIWh
        9DaSXYsf2bkV5gS2W0PJ5PbVV
X-Received: by 2002:adf:e285:: with SMTP id v5mr5042139wri.129.1591287631529;
        Thu, 04 Jun 2020 09:20:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3W3/M9qQ/tUPpEsUkOe3S+h3yWEMQolGXs+VzVVX35oHJCG/g9ZFPQyKy/A/EqO1DNwfL/Q==
X-Received: by 2002:adf:e285:: with SMTP id v5mr5042116wri.129.1591287631274;
        Thu, 04 Jun 2020 09:20:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb? ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
        by smtp.gmail.com with ESMTPSA id q1sm7570203wmc.12.2020.06.04.09.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 09:20:30 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: Always treat MSR_IA32_PERF_CAPABILITIES as a
 valid PMU MSR
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        "Xu, Like" <like.xu@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <like.xu@linux.intel.com>
References: <20200603203303.28545-1-sean.j.christopherson@intel.com>
 <46f57aa8-e278-b4fd-7ac8-523836308051@intel.com>
 <20200604151638.GD30223@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f7a234a7-664b-9160-f467-48b807d47c8b@redhat.com>
Date:   Thu, 4 Jun 2020 18:20:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200604151638.GD30223@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/20 17:16, Sean Christopherson wrote:
> On Thu, Jun 04, 2020 at 09:37:59AM +0800, Xu, Like wrote:
>> On 2020/6/4 4:33, Sean Christopherson wrote:
>>> Unconditionally return true when querying the validity of
>>> MSR_IA32_PERF_CAPABILITIES so as to defer the validity check to
>>> intel_pmu_{get,set}_msr(), which can properly give the MSR a pass when
>>> the access is initiated from host userspace.
>> Regardless ofÃ‚Â  the MSR is emulated or not, is it a really good assumption that
>> the guest cpuids are not properly ready when we do initialization from host
>> userspace
>> ?
>
> I don't know if I would call it a "good assumption" so much as a "necessary
> assumption".  KVM_{GET,SET}_MSRS are allowed, and must function correctly,
> if they're called prior to KVM_SET_CPUID{2}.

Generally speaking this is not the case for the PMU; get_gp_pmc for
example depends on pmu->nr_arch_gp_counters which is initialized based
on CPUID leaf 0xA.

The assumption that this patch fixes is that you can blindly take the
output of KVM_GET_MSR_INDEX_LIST and pass it to KVM_{GET,SET}_MSRS.

Paolo

