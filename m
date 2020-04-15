Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C498C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451872076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjydEm3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408865AbgDOOxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:53:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23078 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407866AbgDOOxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586962413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K5aShlaM4L7LBpzpuTEwY9oR96TrokeSvhA+JevS168=;
        b=JjydEm3K+xWc2nEV5L+8ZaX23sdIouTvuMz7Cz8Jnjz/rI4L/lTo9gxWzUYQ3SdNzaVfVB
        HXFEUYXmezcWWbE9/5BnInA/OY6JigarzpKICa7rJe0chUEGgkEc8SSrnfL95BeewS0odx
        YNlOEuVHhO0ayg8j8tpzXNUx7miRg8k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-5txRY81jPO-hE3qfR8-GTQ-1; Wed, 15 Apr 2020 10:53:32 -0400
X-MC-Unique: 5txRY81jPO-hE3qfR8-GTQ-1
Received: by mail-wr1-f70.google.com with SMTP id j16so16184wrw.20
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 07:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K5aShlaM4L7LBpzpuTEwY9oR96TrokeSvhA+JevS168=;
        b=ia9zhcpACeADIZO33z/yHwK8A+deSfNTNBbgNIKlFOGTPqNQeJTguautSUFk6ZEk5m
         36IxRj0oKZ2ORPQpfTPgrZHgxRcnCZxoktdd3bZ0Zpn7mXDJCRkjiVCTvCfX/bYzDb96
         cnzQzdfnJgjuBgEEBOgFXnLfx0CA7ERkoZ1BKBbp9yQcvqVqtcb9Fs8TuOK4jWtacYAL
         26cBgBI+OqCmda8rTxSUUBetW3gZ84SFsjfaY8VTs+R5XKcIONbcYJgT1xYvYOU7P/UV
         SlP0vXKvYnDs7Jh2R3hcSIKKOAWYW6ZvJCQQCnKRNe8gibR/Cxl9RnVN8sH7m36OAUSW
         S2LA==
X-Gm-Message-State: AGi0PubXK5kIgKa6wgdgKd8MDJkZ6487yoOoPCSgfJWXeEeGuqyjduoP
        dHG75OGzu0vL/nLBwwcpXPfKbxyujbPjsTiqAclmr3ukLkI3G7N28TjKCn4tFo2EZ/HQvNfNP8T
        pzlGMq29FsVBPFhrUtpJ1QsEL
X-Received: by 2002:a1c:4ca:: with SMTP id 193mr5676268wme.18.1586962410826;
        Wed, 15 Apr 2020 07:53:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypKgkkaOjvC7IzHh45gZluJBlRAB0EDDEKLC5J1nBzdDb/gCljFCcJsnBzwUJEmVbAtBvAy4Yw==
X-Received: by 2002:a1c:4ca:: with SMTP id 193mr5676247wme.18.1586962410610;
        Wed, 15 Apr 2020 07:53:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9066:4f2:9fbd:f90e? ([2001:b07:6468:f312:9066:4f2:9fbd:f90e])
        by smtp.gmail.com with ESMTPSA id p10sm22953476wrm.6.2020.04.15.07.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 07:53:30 -0700 (PDT)
Subject: Re: [PATCH] KVM: Optimize kvm_arch_vcpu_ioctl_run function
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
References: <20200413034523.110548-1-tianjia.zhang@linux.alibaba.com>
 <875ze2ywhy.fsf@vitty.brq.redhat.com>
 <cc29ce22-4c70-87d1-d7aa-9d38438ba8a5@linux.alibaba.com>
 <87a73dxgk6.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9e122372-249d-3d93-99ed-a670fff33936@redhat.com>
Date:   Wed, 15 Apr 2020 16:53:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87a73dxgk6.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/20 11:07, Vitaly Kuznetsov wrote:
> In case this is no longer needed I'd suggest we drop 'kvm_run' parameter
> and extract it from 'struct kvm_vcpu' when needed. This looks like a
> natural add-on to your cleanup patch.

I agree, though I think it should be _instead_ of Tianjia's patch rather
than on top.

Paolo

