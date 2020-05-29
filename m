Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B33C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21F132074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xp+FpzNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgE2JsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 05:48:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40014 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726799AbgE2JsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 05:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590745699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f6w/D95eveaUv1V0PC/H4Q2Slese/OFGRios5LqI3Lo=;
        b=Xp+FpzNSig6u6XpQeRDVCu08pG9SZU1pkJBd1viCvCmkXu0jmPnJcVNPkybA+vaeoeRWjH
        Ky3xEa33kvBO+9ZCGKIGTreFRWvirjEuBUhsGa3ddFMS2aTX7oDMAq1qZh23zjgEKQ+gSn
        lDsN6OevHGTbIs7EhPRSnkIMk7yQ1Mo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-QsT52tpSPSGJagWJ6VLDMA-1; Fri, 29 May 2020 05:48:17 -0400
X-MC-Unique: QsT52tpSPSGJagWJ6VLDMA-1
Received: by mail-wr1-f69.google.com with SMTP id o1so812059wrm.17
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 02:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f6w/D95eveaUv1V0PC/H4Q2Slese/OFGRios5LqI3Lo=;
        b=oq6N8jD4RLMbxfX3YaJPQPYwj7kfEBUXlEDskrM0ynQCkC6/3tyqRmmjqzS6T1/E7U
         Zegr3wE6H+iAW0Of2A1VyWe/FQprXDO0GXXiMfUplUphVHnSOoyUF/qLwWaYGnZ5h3SA
         KtzHwD6QWk7AAbljygJf65z6xCrsiOIhElvQQoH9fjxwY9VwxcFFZw77UGsENYn8DN8A
         3lJXbcVAg3EfUdCCVKTqdVUuDJUpYFCBhBMQ89LBI1iQnM0Qwwgfgup3Y/Qt0b6mH4TR
         /2paE49so2QnrhopEDF2jru7PYD/kudJyEYJbKgRatl0oO7F5dBYvlKm44XvlB1YiQ9R
         mFzQ==
X-Gm-Message-State: AOAM53055ORCyUC0ZQlIeCrQ37//I/smzv45iaXsbZHBWRicMe22fe7U
        LpXkxcYL4plYNPKxr3BoLj+yxqKxpaesnEeEd7Cl8+zgfNJWTOnv3e3k8CfWYWTopHzZk68Xi3e
        Il/WXNoc8a+WObutGB1RTTG6v
X-Received: by 2002:a05:6000:124e:: with SMTP id j14mr7990026wrx.154.1590745695771;
        Fri, 29 May 2020 02:48:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwY5u800IehczM/cQdM/5qPUlY08WZ5sRKP7f3fL0jBY9tgOmWNoklBLDcXU/RONPfyNhc2eg==
X-Received: by 2002:a05:6000:124e:: with SMTP id j14mr7990004wrx.154.1590745695574;
        Fri, 29 May 2020 02:48:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b096:1b7:7695:e4f7? ([2001:b07:6468:f312:b096:1b7:7695:e4f7])
        by smtp.gmail.com with ESMTPSA id k26sm10567358wmi.27.2020.05.29.02.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 02:48:15 -0700 (PDT)
Subject: Re: [PATCH v4 6/7] KVM: MIPS: clean up redundant 'kvm_run' parameters
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Huacai Chen <chenhuacai@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>, paulus@ozlabs.org,
        mpe@ellerman.id.au,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        cohuck@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org, hpa@zytor.com,
        Marc Zyngier <maz@kernel.org>, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        christoffer.dall@arm.com, Peter Xu <peterx@redhat.com>,
        thuth@redhat.com, kvm@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20200427043514.16144-1-tianjia.zhang@linux.alibaba.com>
 <20200427043514.16144-7-tianjia.zhang@linux.alibaba.com>
 <CAAhV-H7kpKUfQoWid6GSNL5+4hTTroGyL83EaW6yZwS2+Ti9kA@mail.gmail.com>
 <37246a25-c4dc-7757-3f5c-d46870a4f186@linux.alibaba.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30c2ac06-1a7e-2f85-fbe1-e9dc25bf2ae2@redhat.com>
Date:   Fri, 29 May 2020 11:48:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <37246a25-c4dc-7757-3f5c-d46870a4f186@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/20 08:24, Tianjia Zhang wrote:
>>>
>>>
> 
> Hi Huacai,
> 
> These two patches(6/7 and 7/7) should be merged into the tree of the
> mips architecture separately. At present, there seems to be no good way
> to merge the whole architecture patchs.
> 
> For this series of patches, some architectures have been merged, some
> need to update the patch.

Hi Tianjia, I will take care of this during the merge window.

Thanks,

Paolo

