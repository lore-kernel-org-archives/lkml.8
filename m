Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9879EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757E5207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6wjUK5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgFRMK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:10:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28168 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727873AbgFRMKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592482249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4BhAaUF6WRGpfAqOkgZuOyPei4wEh9xi+t7koUmuvAc=;
        b=K6wjUK5h5BaL1eNkZPs+NDXOr617BU4mQxUjviQsExji/zmh8N8LSVLeAsGsvyECxNlDoB
        H9FxsUvE0EAmi4ctUZQxwguj8QSd+ttXxi3Pjhft9upOsfCmnclpLzFFnrBh+sV2I7DSC2
        GfAN/XzMxBS5T0XCIEBMuh25Lh1VV+g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-1kuEO9ENOfuoaMmG1nxPaA-1; Thu, 18 Jun 2020 08:10:48 -0400
X-MC-Unique: 1kuEO9ENOfuoaMmG1nxPaA-1
Received: by mail-wm1-f72.google.com with SMTP id p24so1724565wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4BhAaUF6WRGpfAqOkgZuOyPei4wEh9xi+t7koUmuvAc=;
        b=HCT+uVWJomF6cjh9H4Ir2o2eHO2QzQBG/l4jS9HhRzBLMk0UYPrs5IvFQgPfVKI9qS
         4kcnJbdBA30Ya/uQCxd+qYCcccwuw+HbtppGKaNjvMWlOUVkaY0aoyDUn8qLVcOVSj81
         g0yQ/fNYtjYazDsw2NCDuCiiAtbKpRI4xkEdoso7Xg/D+N7CejLsiOJLy5Xt0M45qf4w
         872mXB9pXT17KZdwi3LC8Fzns103NtLM4nea5iq4hNHYt0h8k3fiW2I0beMrNevL/Bf2
         0QUKVpLW/8/X88rgzkS6XJoybqtu/3laJQrrlf+OW9h0WNpDKSwm6ThkAAHl2TkO4hEP
         3x6g==
X-Gm-Message-State: AOAM533//h6aNn35+V5OSb/ExYD+hpB1q74X0Mp+8Nj9xd6e8nMB++BQ
        oXSm4LnUHGbxYpVGqFVBWm0BPexol9f9LJ2H5bxFUdYZkpipGdh38kOhonIcXAf2MPh1Qb1/0Hb
        2IKcfRAXbgMzP5lyiHqFaDeAb
X-Received: by 2002:a5d:40d0:: with SMTP id b16mr4250707wrq.218.1592482247105;
        Thu, 18 Jun 2020 05:10:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlOURfKaDjxjqlQ0vKZlW8yVK31olTXINWGcAm3/4sIVpqW7bYXbgEMjhaOzE3wXvRfqKE0Q==
X-Received: by 2002:a5d:40d0:: with SMTP id b16mr4250675wrq.218.1592482246764;
        Thu, 18 Jun 2020 05:10:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb? ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
        by smtp.gmail.com with ESMTPSA id s18sm3928028wra.85.2020.06.18.05.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 05:10:46 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: SVM: emulate MSR_IA32_PERF_CAPABILITIES
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Like Xu <like.xu@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20200618111328.429931-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <adc8b307-4ec4-575f-ff94-c9b820189fb1@redhat.com>
Date:   Thu, 18 Jun 2020 14:10:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200618111328.429931-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/20 13:13, Vitaly Kuznetsov wrote:
> state_test/smm_test selftests are failing on AMD with:
> "Unexpected result from KVM_GET_MSRS, r: 51 (failed MSR was 0x345)"
> 
> MSR_IA32_PERF_CAPABILITIES is an emulated MSR on Intel but it is not
> known to AMD code, emulate it there too (by returning 0 and allowing
> userspace to write 0). This way the code is better prepared to the
> eventual appearance of the feature in AMD hardware.
> 
> Fixes: 27461da31089 ("KVM: x86/pmu: Support full width counting")
> Suggested-by: Jim Mattson <jmattson@google.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/svm/pmu.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)

This is okay and I'll apply it, but it would be even better to move the
whole handling of the MSR to common x86 code.

Paolo

