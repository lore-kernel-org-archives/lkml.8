Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63385C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D75208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7xw0WXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388201AbgE1LOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:14:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43396 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388080AbgE1LOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590664444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=acpHxn1a0do1eYSDNn0Gj48JIN5rgon7KXnl2Z/Teo8=;
        b=Y7xw0WXiHEHQIhT2bjq91wOHPfPQwA89ylTlhlq12nEm9tvZlaTKwmYhpZwg4CS95tHe0f
        USU2VAi4SnM1XQ9bghdi0kvohbiw5DDN4KUn+KKdScQw1psF8qYPb4XuJBGjRccz9wn/F8
        W15k92yiy6Ic+FKXfyT+x3YX/7yWask=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-T3WXmPhmPpq1_29llSJ7-A-1; Thu, 28 May 2020 07:14:03 -0400
X-MC-Unique: T3WXmPhmPpq1_29llSJ7-A-1
Received: by mail-ed1-f72.google.com with SMTP id bo26so11334712edb.22
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=acpHxn1a0do1eYSDNn0Gj48JIN5rgon7KXnl2Z/Teo8=;
        b=eozQ5MPmlXZIvzR+VKRmvbMGUgtG6UijTFtlB2bTKjgbYYsCxSdev6NvlgE/kzGp53
         r9qHOZbR3yzE935IgqkN/EHLWBnjutddnhBEB3FeaUQjDOZuRVD6eghIea54zI5ynGEs
         9/dFRAhih9davg9z49V2ji4aDktcsUX7OSTkP9Yngl0EUYMNozFiCX2BNkOPTiTHCwTn
         zPLQnxgxWk3txEJ3KZCDS6UhR1ZNgcJNquuKmdLmdfv0EVIAE9pAVn3fear+ddXkUIc2
         RhGPnZq3Jl0k66j7IKSIAYYtY0eVSSNX4np5E23cmHuL/GrW5VI/BKSXyKRC9MRbK5Pe
         7y3g==
X-Gm-Message-State: AOAM530qE1Wzc0Ndwo6DLE805/dL8XhvG0n0QwF5TGo1SEfQw6nc7gRs
        QrrNEuQnig5rLnn4+8uSMZtDnYwFFZlS9cdtfUhijgJsS4KAj/EUXV2Yz9ERVaddw5L1yaxb61F
        DXOIewaGozO5FjHsyUCMo8kn4
X-Received: by 2002:aa7:d79a:: with SMTP id s26mr691036edq.202.1590664441905;
        Thu, 28 May 2020 04:14:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcIxMeWbuUuJrdgZ6nC5IX8oVcCIpZYD5OLHWNuGYJPlq8iLJvJHCCYGlH5ttb3a/cZT7dUw==
X-Received: by 2002:aa7:d79a:: with SMTP id s26mr691015edq.202.1590664441737;
        Thu, 28 May 2020 04:14:01 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id cq27sm3509764edb.41.2020.05.28.04.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 04:14:01 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Vivek Goyal <vgoyal@redhat.com>, Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] KVM: x86: deprecate KVM_ASYNC_PF_SEND_ALWAYS
In-Reply-To: <551b75f7-b022-313d-fac4-8b3dd83fe76c@redhat.com>
References: <20200525144125.143875-1-vkuznets@redhat.com> <20200525144125.143875-11-vkuznets@redhat.com> <551b75f7-b022-313d-fac4-8b3dd83fe76c@redhat.com>
Date:   Thu, 28 May 2020 13:14:00 +0200
Message-ID: <87zh9s2txj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 25/05/20 16:41, Vitaly Kuznetsov wrote:
>> Concerns were expressed around APF events delivery when CPU is not
>> in user mode (KVM_ASYNC_PF_SEND_ALWAYS), e.g.
>> https://lore.kernel.org/kvm/ed71d0967113a35f670a9625a058b8e6e0b2f104.1583547991.git.luto@kernel.org/
>> 
>> 'Page ready' events are already free from '#PF abuse' but 'page not ready'
>> notifications still go through #PF (to be changed in the future). Make the
>> probability of running into issues when APF collides with regular #PF lower
>> by deprecating KVM_ASYNC_PF_SEND_ALWAYS. The feature doesn't seem to be
>> important enough for any particular workload to notice the difference.
>
> This has been disabled already in guest code, but I don't see a
> particular reason to deprecate it in the host too.  Supporting it on the
> host is just one line of code; if it's a problem *for the guest*, you
> just don't use KVM_ASYNC_PF_SEND_ALWAYS.
>
> Also, note that #VE will always be delivered to the guest even at CPL0;
> the decision on whether to do sync or async page fault at CPL0 will move
> to the guest, but enabling #VE will probably _require_ the
> KVM_ASYNC_PF_SEND_ALWAYS bit to be set (and KVM_ASYNC_PF_DELIVERY_AS_INT
> as well).

I actually missed the fact that guest side is already disabled (I can
see it now in the queue), feel free to ignore this patch then.

-- 
Vitaly

