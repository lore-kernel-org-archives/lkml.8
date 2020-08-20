Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2438C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA9022B4E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ex6EaKKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbgHTKf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:35:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51481 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731388AbgHTKSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597918717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ks6Vmm7jkQp97PF98e15DQTqLGcM4ICVk2CkEB67KBg=;
        b=Ex6EaKKRNuhFIIi9yHUiqPwuFWdb11cR1N5iVYAzQbSjo8cJVm8gSYlPxZhzgt9NK0gH18
        TKqBHmKll31jnf2TolCrkd+M0ZLtsfpfnumt0dPteLyvYAe70xzt/mJgTyB6y9BhrB0aOo
        TAKh2bVTfnJDGg7ngki4HBWMTrwMl2I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-9Y_U1lzmMXSnv3QjdmgnNA-1; Thu, 20 Aug 2020 06:18:35 -0400
X-MC-Unique: 9Y_U1lzmMXSnv3QjdmgnNA-1
Received: by mail-wr1-f71.google.com with SMTP id m7so486294wrb.20
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 03:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ks6Vmm7jkQp97PF98e15DQTqLGcM4ICVk2CkEB67KBg=;
        b=kpONtRmdqg5MLDGN2mDDKV4eRexQaqCWaRB0+sSbaZ4zalQFyLWU3ok4+9Iqb9eipf
         twACZWyK3wpZMvvKHHBo25wnzr1zWAzMzLL2L0AMFC7j5JhparrD+p0YRjvQO25MvpXS
         Su7a6oFKgKPBrJosgb9ly85pI9je4WprM7Q3Y8GL5Nk4/Ij4QQ71vt9xFC+pahT69Gth
         EacuUhrDkEeVfkbUysByZZ7p39YHdcbWhLUGT9y5mMCpfL2IebFgqFDy9ryWfpFrWG3X
         LcmOTP+60q30kSX8vEU3Tz1EiWkFoPSHKtkdRci9IhAoM882meMNbUt8+ed/8pv91jvU
         Y7rA==
X-Gm-Message-State: AOAM5321sKOmJVUxrgDeFX5ezX3DBMb3m3Zhz0uQm8YYHvbEJE449zxC
        a4l+EUDDjIsz6NMDYfWv8ExhrYq+Y/CsHUM4Lighi8IJ8w/SaObl5bZRVL/apdQgtCzKmGKThOS
        5NRwbSUmDCaLGc28eUPTxfEaD
X-Received: by 2002:a1c:de41:: with SMTP id v62mr2939596wmg.163.1597918711321;
        Thu, 20 Aug 2020 03:18:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbot6hubXE5I5zNDOSnTrvtsfmtrg53QJyDVNw19vVjiZS7ReblTt/IIGb0cMLxSkI2HCmCw==
X-Received: by 2002:a1c:de41:: with SMTP id v62mr2939573wmg.163.1597918711112;
        Thu, 20 Aug 2020 03:18:31 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id m14sm3267389wrx.76.2020.08.20.03.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 03:18:30 -0700 (PDT)
Subject: Re: [PATCH 8/8] KVM: nSVM: read only changed fields of the nested
 guest data area
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20200820091327.197807-1-mlevitsk@redhat.com>
 <20200820091327.197807-9-mlevitsk@redhat.com>
 <53afbfba-427e-72f5-73a6-faea7606e78e@redhat.com>
 <33166884f54569ab47cc17a4c3e01f9dbc96401a.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be88aaae-c776-32d2-fa69-00c6aace787d@redhat.com>
Date:   Thu, 20 Aug 2020 12:18:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <33166884f54569ab47cc17a4c3e01f9dbc96401a.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/20 12:05, Maxim Levitsky wrote:
>> You probably should set clean to 0 also if the guest doesn't have the
>> VMCBCLEAN feature (so, you first need an extra patch to add the
>> VMCBCLEAN feature to cpufeatures.h).  It's probably best to cache the
>> guest vmcbclean in struct vcpu_svm, too.
> Right, I totally forgot about this one.
> 
> One thing why I made this patch optional, is that I can instead drop it,
> and not 'read back' the saved area on vmexit, this will probably be faster
> that what this optimization does. What do you think? Is this patch worth it?
> (I submitted it because I already implemented this and wanted to hear opinion
> on this).

Yeah, good point.  It's one copy either way, either on vmexit (and
partly on vmentry depending on clean bits) or on vmentry.  I had not
considered the need to copy from vmcb02 to the cached vmcb12 on vmexit. :(

Let's shelve this for a bit, and revisit it once we have separate vmcb01
and vmcb02.  Then we might still use the clean bits to avoid copying
data from vmcb12 to vmcb02, including avoiding consistency checks
because we know the vmcb02 data is legit.

Patches 1-5 are still worthwhile, so you can clean them up and send them.

Paolo

