Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCBFC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03DB207FD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdkNycRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgCFKP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:15:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55778 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726025AbgCFKP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583489725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R8cCEdC5FaVv+MdnVESNIfOZjXxz+5prIcEo1XcPS0s=;
        b=KdkNycRPZR2tz20TZRQYUZNZx3hVaU8BpnyI78N1CaEjSZGSdpsDJyzA6LvZQWhBb12oaB
        G+L5tnhSODDSiaU6Aujjgbl864mCaNsZ2PdTwjd0ssc//QNe0XBshk2cTIUpB0mYgNPbou
        UqCo3SXtMe3p2cIUYhZQwNzLF70OPM4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-ZHj_nNz4PFOe5A5aseBotQ-1; Fri, 06 Mar 2020 05:15:24 -0500
X-MC-Unique: ZHj_nNz4PFOe5A5aseBotQ-1
Received: by mail-wr1-f69.google.com with SMTP id q18so800174wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 02:15:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=R8cCEdC5FaVv+MdnVESNIfOZjXxz+5prIcEo1XcPS0s=;
        b=uddn7RWDGesQz5ijZCWFBZ2IVKeUSXc9NQxUz1qDgeBjrDjsskCw3RKd2gXyQIlslx
         gA5W8HUUSklo9QljsR4xgwzHM3g9l/bvviOuEKUkrN9uSKp2ncL/lU4hUwkHZaW0V6tu
         vatAx5zCmS443QPy4WZzdApskds9oZ00E781My7NBZCTVAWJLq3mLi85MZY49PNJU84U
         LjAYzHawn3lqEBXl5ApC6Jl1aPeM5K015FNxduK089yDIO8ISGhzAI5z2Ubxt1uHRZdR
         8XBTL04q8yJwU4Um1uOXhgzoeEoQJIxDJJ+QLohN1Z7w3kYNEmHYTSSyqaOl6ynY+/YY
         TCbg==
X-Gm-Message-State: ANhLgQ0hGoO5lWK5O3ydWoQ8OCmZEvdp/jeY2YN5Aa3Q4xGKNVQImp3C
        J0gA3dZxXaptIR1PS9ZZUuFZC4mRkVPIRYW6fDq8RUKi2ZQb0Q9CADoFSfyKbUOinXwUXumLxUB
        J6WlOCIfxxVKTEMdzmfRQ6VpK
X-Received: by 2002:adf:f58c:: with SMTP id f12mr3213691wro.22.1583489722135;
        Fri, 06 Mar 2020 02:15:22 -0800 (PST)
X-Google-Smtp-Source: ADFU+vu8zlAWdb1cgYZu04XUt1QbGIL0sJCkz9ENy7Jgx3MKegXXX1wp00ARy8EXOG7ML94pK8W+lw==
X-Received: by 2002:adf:f58c:: with SMTP id f12mr3213666wro.22.1583489721922;
        Fri, 06 Mar 2020 02:15:21 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id m11sm1461332wrn.92.2020.03.06.02.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 02:15:21 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        linmiaohe <linmiaohe@huawei.com>
Cc:     "rkrcmar\@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson\@intel.com" <sean.j.christopherson@intel.com>,
        "jmattson\@google.com" <jmattson@google.com>,
        "joro\@8bytes.org" <joro@8bytes.org>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "bp\@alien8.de" <bp@alien8.de>, "hpa\@zytor.com" <hpa@zytor.com>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] KVM: VMX: Use wrapper macro ~RMODE_GUEST_OWNED_EFLAGS_BITS directly
In-Reply-To: <2cde5e91-b357-81f9-9e39-fd5d99bb81fd@redhat.com>
References: <f1b01b4903564f2c8c267a3996e1ac29@huawei.com> <1e3f7ff0-0159-98e8-ba21-8806c3a14820@redhat.com> <87sgiles16.fsf@vitty.brq.redhat.com> <2cde5e91-b357-81f9-9e39-fd5d99bb81fd@redhat.com>
Date:   Fri, 06 Mar 2020 11:15:20 +0100
Message-ID: <87lfodeqmf.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 06/03/20 10:44, Vitaly Kuznetsov wrote:
>>>> Define a macro RMODE_HOST_OWNED_EFLAGS_BITS for (X86_EFLAGS_IOPL |
>>>> X86_EFLAGS_VM) as suggested by Vitaly seems a good way to fix this ?
>>>> Thanks.
>>> No, what if a host-owned flag was zero?  I'd just leave it as is.
>>>
>> I'm not saying my suggestion was a good idea but honestly I'm failing to
>> wrap my head around this. The suggested 'RMODE_HOST_OWNED_EFLAGS_BITS'
>> would just be a define for (X86_EFLAGS_IOPL | X86_EFLAGS_VM) so
>> technically the patch would just be nop, no?
>
> It would not be a nop for the reader.
>
> Something called RMODE_{GUEST,HOST}_OWNED_EFLAGS_BITS is a mask.  It
> tells you nothing about whether those bugs are 0 or 1.  It's just by
> chance that all three host-owned EFLAGS bits are 1 while in real mode.
> It wouldn't be the case if, for example, we ran the guest using vm86
> mode extensions (i.e. setting CR4.VME=1).  Then VIF would be host-owned,
> but it wouldn't necessarily be 1.

Got it, it's the name which is causing the confusion, we're using mask
as something different. Make sense, let's keep the code as-is then.

-- 
Vitaly

