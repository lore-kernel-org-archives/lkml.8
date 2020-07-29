Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AEDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD3E206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izATLkqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgG2IX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:23:27 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:20584 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727044AbgG2IX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596011005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8lrqZhx4wIlIKGfI1v+EKqO6jc0hqmda+j4PZMrvWEE=;
        b=izATLkqoGsmn4NG6MP7HxZydLZv+7lEfCEEwa7nofJYBi+idgLTcpHMgWzgWEP07esXa8C
        f5L9WvT7cLQ9N4h704UtbI0zELjZo0z6Hd67gptJjLBUcGkZejw7woN6ek+t+Ju1hvnVgn
        Sv/3byYdJZLX2gX2O05Gzf/+VF/RAKo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-4TWJnCvjNrid5busosThhg-1; Wed, 29 Jul 2020 04:23:23 -0400
X-MC-Unique: 4TWJnCvjNrid5busosThhg-1
Received: by mail-ed1-f72.google.com with SMTP id l5so3933812eds.16
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=8lrqZhx4wIlIKGfI1v+EKqO6jc0hqmda+j4PZMrvWEE=;
        b=d+noKtEWc6NuSKKj0USToNvtzVr8bOLvUpfRKUrgeq+v39plTmymGZt81+qbPvtu/h
         KQeEyHVjZQmeRVX1CrT32YdFmBc+terlNhtGHRhQ3DeJSBI6r8ZeMjr9MFnqo9GeqTJv
         xqSGIQKPl1E75wYdcRNTnuMkuVwDQpJJFFfZsLcPzYkz5oRVEX2xajYM2IePCiqY3oC6
         gGldaYqkJ60owoteG2BVScNbB2EyotiPbXFWx6a3fQNO4tYAjNQ9wvViSVjpDj8Jlq5o
         voR4SDnOhvEf9wtXRbUkUNLsLU5dCb5rwY2ESm+blQ+J3X5hD7eSdsF9WCvLoHl7Pm0r
         O+FA==
X-Gm-Message-State: AOAM530Q46FWVKKaE6hMWmyCDQNDWBQuqoBe7mGrUpPeM4VTD8SNevi5
        WrbqXTUFEcddp8k7HqnbeA2Sc+DwCU1cPH9qFUxSO8BXTjYnV8VC0zjI5wR+Q5KkuLPxwQ1AluI
        jo6j0k41or5vOVjaICVMGCEvd
X-Received: by 2002:a17:906:c096:: with SMTP id f22mr19924871ejz.159.1596011002578;
        Wed, 29 Jul 2020 01:23:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrtor48PKaJPzhZluQN3DnUZRQ0VogdZPOhAt3ZNs96b8Wg1nFDHyxjUTEMO1FmMqAUc0VVA==
X-Received: by 2002:a17:906:c096:: with SMTP id f22mr19924858ejz.159.1596011002411;
        Wed, 29 Jul 2020 01:23:22 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id g9sm609366ejf.101.2020.07.29.01.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 01:23:21 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>, Alexander Graf <graf@amazon.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Aaron Lewis <aaronlewis@google.com>
Subject: Re: [PATCH] KVM: x86: Deflect unknown MSR accesses to user space
In-Reply-To: <CALMp9eQ3OxhQZYiHPiebX=KyvjWQgxQEO-owjSoxgPKsOMRvjw@mail.gmail.com>
References: <20200728004446.932-1-graf@amazon.com> <87d04gm4ws.fsf@vitty.brq.redhat.com> <a1f30fc8-09f5-fe2f-39e2-136b881ed15a@amazon.com> <CALMp9eQ3OxhQZYiHPiebX=KyvjWQgxQEO-owjSoxgPKsOMRvjw@mail.gmail.com>
Date:   Wed, 29 Jul 2020 10:23:20 +0200
Message-ID: <87y2n2log7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Tue, Jul 28, 2020 at 5:41 AM Alexander Graf <graf@amazon.com> wrote:
>>

...

>> While it does feel a bit overengineered, it would solve the problem that
>> we're turning in-KVM handled MSRs into an ABI.
>
> It seems unlikely that userspace is going to know what to do with a
> large number of MSRs. I suspect that a small enumerated list will
> suffice.

The list can also be 'wildcarded', i.e. 
{
 u32 index;
 u32 mask;
 ...
}

to make it really short.

-- 
Vitaly

