Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63ACC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8F02077B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhxVtzG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgAOR4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:56:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28114 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728998AbgAOR4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579110970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GV34jCRlj0bUW9Hdc3YVHkEhV3RRfTTy/yTNeGCUOBw=;
        b=DhxVtzG0B0ypYDj/o9pxyAaJB1hwU8yOLoojNf4edseVwZz2V2X5326yehnFO6xB9Smfa/
        Rp1HiwWiWLC6CV1jpWsGpdvdW8BKZ12VfyRtXPu98V9mjGXsW/U3oFHjRNGLz+nBMRDBnV
        JhumhBbwmFfL7lsX03+q0G8a1AGETq0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393--fhFM0iLNcOm7VfUK-dBnA-1; Wed, 15 Jan 2020 12:56:09 -0500
X-MC-Unique: -fhFM0iLNcOm7VfUK-dBnA-1
Received: by mail-wr1-f71.google.com with SMTP id c6so8218797wrm.18
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 09:56:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GV34jCRlj0bUW9Hdc3YVHkEhV3RRfTTy/yTNeGCUOBw=;
        b=TjohhhUcc5734dAKG4dyyymyYSlAcXFkqx59sxvmglYpJsalYPrQol49UzmM5Z5MlZ
         hGehjoqZwWorAj8KXVyYIbUmnRyzNk0lM1DWNm64PJQZuqI2WUbmXYkoAD3bXW5Mb61b
         HJDoIw2iMZHxIKlqa7DkoiQg9bWO1beNECd9TA2fV+2AovU2oq/Ox+Ng1ed4ctMqJemi
         RigPjekGgepHTmNVboqp7pzRPl6BNhTVd4oGrmBVwBKBqSuhxVE00mIoAAQ9o1QX11qG
         zRhZPk8YDq6oVdr2ESBV55gBljGGOzZS79gHGPnhDo9z7jWWN0eRbXAM+A3C7hk0VlvQ
         U3bA==
X-Gm-Message-State: APjAAAWUR4SQZSweY8bysfV2Ya2AJuawrQUNhzU+igGeNg6SUo4EV3Za
        4rZAPrCoXc28Rn2pu0juH2yC0XSCxEylDprnBsJhVqVqiZg/VHIhPgyAEIZPI9Y1oVIW1/AksT2
        Zd3QA1YCFDSUAV9CQRohqINfT
X-Received: by 2002:a1c:6809:: with SMTP id d9mr1192001wmc.70.1579110967952;
        Wed, 15 Jan 2020 09:56:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqy5jRb9sG9tgaQjC6Z2Vyf9uE+ik/Rcaq0+f+pFjwJrsjDeAZCwq5eCQZSoEbLS+qz7DEnDEw==
X-Received: by 2002:a1c:6809:: with SMTP id d9mr1191984wmc.70.1579110967776;
        Wed, 15 Jan 2020 09:56:07 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a? ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
        by smtp.gmail.com with ESMTPSA id p18sm747151wmg.4.2020.01.15.09.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 09:56:07 -0800 (PST)
Subject: Re: [PATCH 0/6] Fix various comment errors
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <1576045585-8536-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cb8d499a-59c9-4b48-2823-ed5339035af8@redhat.com>
Date:   Wed, 15 Jan 2020 18:56:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1576045585-8536-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/19 07:26, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> Fix various comment mistakes, such as typo, grammar mistake, out-dated
> function name, writing error and so on. It is a bit tedious and many
> thanks for review in advance.
> 
> Miaohe Lin (6):
>   KVM: Fix some wrong function names in comment
>   KVM: Fix some out-dated function names in comment
>   KVM: Fix some comment typos and missing parentheses
>   KVM: Fix some grammar mistakes
>   KVM: hyperv: Fix some typos in vcpu unimpl info
>   KVM: Fix some writing mistakes
> 
>  arch/x86/include/asm/kvm_host.h       | 2 +-
>  arch/x86/kvm/hyperv.c                 | 6 +++---
>  arch/x86/kvm/ioapic.c                 | 2 +-
>  arch/x86/kvm/lapic.c                  | 4 ++--
>  arch/x86/kvm/vmx/nested.c             | 2 +-
>  arch/x86/kvm/vmx/vmcs_shadow_fields.h | 4 ++--
>  arch/x86/kvm/vmx/vmx.c                | 8 ++++----
>  virt/kvm/kvm_main.c                   | 6 +++---
>  8 files changed, 17 insertions(+), 17 deletions(-)
> 

Queued, thanks.

Paolo

