Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5ECC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC3720775
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fkxaY4rV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgGIRvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:51:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33640 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726615AbgGIRvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594317113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lm9MgZD36ADnk2YR9CzyFzRTbWxkMgc22jnTyO1aW40=;
        b=fkxaY4rVHtXv9YUUnNZWBci+Kf0+slb9hSOel5n6IHn4uCELhSmoYSE1cTqpzG8J5NECc9
        6GZL6435CM9EP+/TZEyNIYhtArasE62zKlRAd2XGODi7xKdv3TkYc6pE4Hc32Rjt0NNDHl
        +howUqrCF/JZ49AE68VzyE+Xfsmq5mc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-a1sYMQsSPpiM1Htm_eoYLA-1; Thu, 09 Jul 2020 13:51:52 -0400
X-MC-Unique: a1sYMQsSPpiM1Htm_eoYLA-1
Received: by mail-wr1-f69.google.com with SMTP id y16so2595467wrr.20
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 10:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lm9MgZD36ADnk2YR9CzyFzRTbWxkMgc22jnTyO1aW40=;
        b=nnQ70g9SDbeYGh6VzhN+hTDRUvqtEtnVV1ZLy7toQaQNwOc3OWB+tfsUJvOTJWck5b
         K8CPmglij6LJcSeiSxYLMGu1NAzkXoxFFyPkZP4XEWgFrYMhbFfKnh3mIvfUniq4qATC
         26SxMNErKKpuoH8ItTaD8u9G7RE50SIhH3zsZxxvElyr4oeXKHwPni6TyIpfri/zYggz
         PgjXidHEN0yb5ARl7M4UTcYCPI2r23c3N0Bs2zB6GvfrwKyqmSTDndh6Lfrem0l7vba8
         BCpIyj3XSf++/kNVELyEv4RF85GT3qXbSM8F3pYoqvdkkyCPQHoSMHc77wLNgjXxDuFP
         3JQQ==
X-Gm-Message-State: AOAM532UA825oQNKyRVy5Ax1n0th7lzPnwO35PaQ6a6CBWX/fu2AL40P
        d2gjNu0IERdfOuKteZd6ICgXQn3dglodpAqupF4S8nW0+Vmsoy4CmPavyqGwc+ZaQenMep7rtmx
        +HL9uoEr+L1QeiU6VsUKaALob
X-Received: by 2002:a05:600c:2f88:: with SMTP id t8mr1140775wmn.186.1594317110845;
        Thu, 09 Jul 2020 10:51:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyb8c8Um027PE4qgR05yIvGPjE72YLpKE1WfO/2Nt5q9OLncvJMT/L6sEMtjkQN6gL0G+2kcw==
X-Received: by 2002:a05:600c:2f88:: with SMTP id t8mr1140758wmn.186.1594317110623;
        Thu, 09 Jul 2020 10:51:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id 2sm5578474wmo.44.2020.07.09.10.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 10:51:50 -0700 (PDT)
Subject: Re: [PATCH v3 6/9] KVM: nSVM: move kvm_set_cr3() after
 nested_svm_uninit_mmu_context()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
References: <20200709145358.1560330-1-vkuznets@redhat.com>
 <20200709145358.1560330-7-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2782f686-1fd5-7042-1a4a-72875ebbf5cf@redhat.com>
Date:   Thu, 9 Jul 2020 19:51:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709145358.1560330-7-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/20 16:53, Vitaly Kuznetsov wrote:
> Note, the change is effectively a nop: when !npt_enabled,
> nested_svm_uninit_mmu_context() does nothing (as we don't do
> nested_svm_init_mmu_context()) and with npt_enabled we don't
> do kvm_set_cr3() but we're about to switch to nested_svm_load_cr3().

Thanks for pointing this out!

Paolo

