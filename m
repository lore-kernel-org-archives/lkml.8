Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604ACC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 15:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CBF24656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 15:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mr9+gK5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgAVPJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 10:09:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58732 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725827AbgAVPJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 10:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579705740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gs0hLkIZ3duxwFToMJ4ktrx5qsitsIbBNuQxZL9XjEY=;
        b=Mr9+gK5hSg9yTm41pnynNNIdaSwz6xJ5yYaVRJFLe4q+qjovgkqZaq/VO0UQ6iGhDouP1s
        nlP937HXra9yi8mj/ZrfkcEyshbFq1X4qLMdLDjrkUkpLoDOizqUBvdnhzU5I7eqNweqBx
        IKBbsbk97WER33G9QE9yzndi9LFdVnk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-xZi_QI4QMsG_aIDs96DT_A-1; Wed, 22 Jan 2020 10:08:58 -0500
X-MC-Unique: xZi_QI4QMsG_aIDs96DT_A-1
Received: by mail-wr1-f72.google.com with SMTP id k18so3214209wrw.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 07:08:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Gs0hLkIZ3duxwFToMJ4ktrx5qsitsIbBNuQxZL9XjEY=;
        b=X1CsPCgQIcsQ/eZL8OujjNFk0gDAXOnROhsDwgn8tyjTx/FxyBJGCD9gMFjxK+Zh6p
         UcmCBPNyJDoewyBgtDErB2hCW3eXpltrv/SixsvDPwjMg9pXFkKTH8PCpEYsZX8MW7Ms
         8ScHsXbSOPXoEP/gH73UZyQHSZMcOf5z0HXbyue/TK2cxI2w1nDt2WozPrygfb3S5VcG
         AzK/KrTd5Tmt8oXleYkRyR4vxDBDBbJI5Ma9UWLiXeuQNEbE62/+fDzRU99CHpNv++Qe
         1FjE1nqf0ebfjbY5KWv7jTn5QuXp102xMeLsCFaqwMHTaJtqHZD17jzAoTxFyIGbO/cj
         /FIQ==
X-Gm-Message-State: APjAAAWFBv/7ep7+7USwUIYUhW1xpxipYKF/vpt0+ieiiobNhKb8c6NX
        kkGnBt0WNNh8lBQ1j96UkHa9FYLBVBJpo4zti1y966EOOKZh7IKupFD7uCmV3kGKEGRVH5GFYJb
        Zglu5cv1cqrD1DPC7v5wfLdif
X-Received: by 2002:a1c:61c1:: with SMTP id v184mr3600985wmb.160.1579705737469;
        Wed, 22 Jan 2020 07:08:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxHQQ7M+5VlXhyTxrA6AqZnQ80yqWJgIp5dIPVzFm5/1K8pZKKmyUgPXC6mh2/XwH9oKiihw==
X-Received: by 2002:a1c:61c1:: with SMTP id v184mr3600962wmb.160.1579705737142;
        Wed, 22 Jan 2020 07:08:57 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b128sm4353614wmb.25.2020.01.22.07.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 07:08:56 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH RFC 2/3] x86/kvm/hyper-v: move VMX controls sanitization out of nested_enable_evmcs()
In-Reply-To: <9c126d75-225b-3b1b-d97a-bcec1f189e02@redhat.com>
References: <20200115171014.56405-1-vkuznets@redhat.com> <20200115171014.56405-3-vkuznets@redhat.com> <6c4bdb57-08fb-2c2d-9234-b7efffeb72ed@redhat.com> <20200122054724.GD18513@linux.intel.com> <9c126d75-225b-3b1b-d97a-bcec1f189e02@redhat.com>
Date:   Wed, 22 Jan 2020 16:08:55 +0100
Message-ID: <87eevrsf3s.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 22/01/20 06:47, Sean Christopherson wrote:
>>> Yes, it most likely is and it would be nice if Microsoft fixed it, but I
>>> guess we're stuck with it for existing Windows versions.  Well, for one
>>> we found a bug in Hyper-V and not the converse. :)
>>>
>>> There is a problem with this approach, in that we're stuck with it
>>> forever due to live migration.  But I guess if in the future eVMCS v2
>>> adds an apic_address field we can limit the hack to eVMCS v1.  Another
>>> possibility is to use the quirks mechanism but it's overkill for now.
>>>
>>> Unless there are objections, I plan to apply these patches.
>> Doesn't applying this patch contradict your earlier opinion?  This patch
>> would still hide the affected controls from the guest because the host
>> controls enlightened_vmcs_enabled.
>
> It does.  Unfortunately the key sentence is "we're stuck with it for
> existing Windows versions". :(
>
>> Rather than update vmx->nested.msrs or filter vmx_get_msr(), what about
>> manually adding eVMCS consistency checks on the disallowed bits and handle
>> SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES as a one-off case by simply
>> clearing it from the eVMCS?  Or alternatively, squashing all the disallowed
>> bits.
>
> Hmm, that is also a possibility.  It's a very hacky one, but I guess
> adding APIC virtualization to eVMCS would require bumping the version to
> 2.  Vitaly, what do you think?

As I already replied to Sean I like the idea to filter out unsupported
controls from eVMCS but unfortunately it doesn't work: Hyper-V actually
expects APIC virtualization to work when it enables
SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES (I have no idea how without
apic_access_addr field but). I checked and at least Hyper-V 2016 doesn't
boot (when >1 vCPU).

-- 
Vitaly

