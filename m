Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409BAC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1480A20863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ao6Lfk0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgCCQhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:37:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31032 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729784AbgCCQhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583253437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RJWF1eWFLN+jPR+BNc53F9U0SopZ95T6MW9CaJ7Lt0E=;
        b=ao6Lfk0lM0Cbri9M1WjXgOaRW8Wf9XR82thsFPvoUrgosSOAu9AgnH4739PJAEwnTJJIDC
        Dkn70ttXME+yYis08gsG6exRLXExlDOUdN8qb848B5TKsgm6LYi2bmenGcNhQf2tZji6IP
        sSphS19c8iwYJhBhof1Yt+lHwHtWTnI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-bDNdF_iwMOKb_n0cdycjkQ-1; Tue, 03 Mar 2020 11:35:56 -0500
X-MC-Unique: bDNdF_iwMOKb_n0cdycjkQ-1
Received: by mail-wr1-f69.google.com with SMTP id z16so1456826wrm.15
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 08:35:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=RJWF1eWFLN+jPR+BNc53F9U0SopZ95T6MW9CaJ7Lt0E=;
        b=Y0Qv+50zQJV9owlmiaKDtXmKOVBPDPAIXIRfq8W5lWy/U9xxY1qgSo1HSfnk+UCgPA
         FlAv9C3VZKL2ZEHPQELQXUIFENeJk6jy19CLObFB3F5NKsEgDKX5xMEdHImy57FbTR6v
         iaUtWi6ibKXBvYxgMfZWVwwPuhJzr/cuVeUnA8fkQ7aCs+32zXuwKbd/RUx3Tl9EvlEA
         CDajMV1EJnWpC5kpMmED9yvYXLVPh3xLbEUwBe8gOAQ3rtQtw+OFJH5oTEqDm3PWq+ZB
         gO3VGXdJeL0px2ztiWTRaun9BcPxtQm2RBimJrvEN/nSw+PsSXp9AURqkyJKM1Fr0t9g
         WuZw==
X-Gm-Message-State: ANhLgQ2l0MSbKJrhHLRvaybkClJTM2yQARS15U48xosQfr8VaxwHkX2f
        aLYmKPw/XE8lMUZrPbKH6XT7WjOJWDYo/vh4O+mRtAfJaPoyrIr1wkuKDYJO1KOMAxfIVw7JQyh
        w4xlT0MY7jTvd+avjSZRiOqie
X-Received: by 2002:a5d:568f:: with SMTP id f15mr6309080wrv.202.1583253355027;
        Tue, 03 Mar 2020 08:35:55 -0800 (PST)
X-Google-Smtp-Source: ADFU+vukv9qnKRFBfr4HwvHP2NBCSoxyOtoOb2QQaTYSs0loSmJRYXOG1lAS0tc+8mfrnfWjuyssLA==
X-Received: by 2002:a5d:568f:: with SMTP id f15mr6309068wrv.202.1583253354840;
        Tue, 03 Mar 2020 08:35:54 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f17sm24125202wrj.28.2020.03.03.08.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 08:35:54 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Bandan Das <bsd@redhat.com>, Oliver Upton <oupton@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: x86: clear stale x86_emulate_ctxt->intercept value
In-Reply-To: <4f933f77-6924-249a-77c5-3c904e7c052b@redhat.com>
References: <20200303143316.834912-1-vkuznets@redhat.com> <20200303143316.834912-2-vkuznets@redhat.com> <4f933f77-6924-249a-77c5-3c904e7c052b@redhat.com>
Date:   Tue, 03 Mar 2020 17:35:53 +0100
Message-ID: <87zhcxe6qe.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 03/03/20 15:33, Vitaly Kuznetsov wrote:
>> Commit c44b4c6ab80e ("KVM: emulate: clean up initializations in
>> init_decode_cache") reduced the number of fields cleared by
>> init_decode_cache() claiming that they are being cleared elsewhere,
>> 'intercept', however, seems to be left uncleared in some cases.
>> 
>> The issue I'm observing manifests itself as following:
>> after commit 07721feee46b ("KVM: nVMX: Don't emulate instructions in guest
>> mode") Hyper-V guests on KVM stopped booting with:
>> 
>>  kvm_nested_vmexit:    rip fffff802987d6169 reason EPT_VIOLATION info1 181
>>     info2 0 int_info 0 int_info_err 0
>>  kvm_page_fault:       address febd0000 error_code 181
>>  kvm_emulate_insn:     0:fffff802987d6169: f3 a5
>>  kvm_emulate_insn:     0:fffff802987d6169: f3 a5 FAIL
>>  kvm_inj_exception:    #UD (0x0)
>
> Slightly rephrased:
>
> After commit 07721feee46b ("KVM: nVMX: Don't emulate instructions in guest
> mode") Hyper-V guests on KVM stopped booting with:
>
>  kvm_nested_vmexit:    rip fffff802987d6169 reason EPT_VIOLATION info1 181
>     info2 0 int_info 0 int_info_err 0
>  kvm_page_fault:       address febd0000 error_code 181
>  kvm_emulate_insn:     0:fffff802987d6169: f3 a5
>  kvm_emulate_insn:     0:fffff802987d6169: f3 a5 FAIL
>  kvm_inj_exception:    #UD (0x0)
>
> "f3 a5" is a "rep movsw" instruction, which should not be intercepted
> at all.  Commit c44b4c6ab80e ("KVM: emulate: clean up initializations in
> init_decode_cache") reduced the number of fields cleared by
> init_decode_cache() claiming that they are being cleared elsewhere,
> 'intercept', however, is left uncleared if the instruction does not have
> any of the "slow path" flags (NotImpl, Stack, Op3264, Sse, Mmx, CheckPerm,
> NearBranch, No16 and of course Intercept itself).

Much better, thanks) Please let me know if you want me to resubmit.

-- 
Vitaly

