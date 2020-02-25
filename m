Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA7BC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86E02176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWNbVOZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgBYIHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:07:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35252 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbgBYIHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582618025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oyV65P0wJT/QVCIMbi37mnuxu4JL3T8Bnc6cBnFgy0o=;
        b=QWNbVOZfatPX523AkEdNWQ4fRkdTd9jl9D8GTFBw+Lye37X/tZ4qCvlJo0JMwJjQlbrj1H
        b58xWE/KR0rM/18c25+NA7Njx15vE5K0KxF5mgF/Jt8Vh1g7pF8rByNDl1n47GH6xAgT4I
        xHF37FLPE22qVupHA/AxAZlCV3qFCDw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-VyLbiGXCPCuMYa4GMhmnqQ-1; Tue, 25 Feb 2020 03:07:03 -0500
X-MC-Unique: VyLbiGXCPCuMYa4GMhmnqQ-1
Received: by mail-wm1-f70.google.com with SMTP id 7so724346wmf.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 00:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oyV65P0wJT/QVCIMbi37mnuxu4JL3T8Bnc6cBnFgy0o=;
        b=omV0nG0J28cpIP4krrE+IBhOkXUEVcCcuYmd+mo5Y8qQhUBzyO7o7zYfLAddihja1z
         +q7zCBxKqEFV2EiyuXxCwlA+xHPdIs4fzy4eqZUUiPbLyoliCAx6s4LXvHH1v+Av6yQY
         amgLpEhTPaAceB9/heNIA4hq51ufyLHDNkg+KHNLRVPgS+Yy9ujHBPaJN89E5WQfuSuB
         U3oYkm8VYm+OJL5b7Ob4rdWo0wJkQEzOyJnN8lmhE8BEK46xeG/XFcT6k44L4NBA2riE
         QasNoDVmfulk2u5/58exjukTzlf31+W24SE5BpgDGX3dcl6da9+ebrOcFKN1MyddmDgr
         6Rxg==
X-Gm-Message-State: APjAAAW3Ur8w6UB4PVsYSs4PzvY5WYfAUr74QYDuRo9yAMi9Tl7Pcfy6
        S8MmLTqyTjhOsufuaXKqKl7PujIv7UIQQ4vr1uSRWza/DCktcCMpTcwMdpzNKA/pvipfmVI6mh1
        iAIjsJhUs5FdsTlZIOIaBA15i
X-Received: by 2002:adf:cc8b:: with SMTP id p11mr21179195wrj.8.1582618022681;
        Tue, 25 Feb 2020 00:07:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqyIVScXiu1RVWc//crX4pYvYp3oCYcgROaw86pP31PI4FMtJoAhCFDPukMCIBNUsmAJ+M+F9w==
X-Received: by 2002:adf:cc8b:: with SMTP id p11mr21179169wrj.8.1582618022431;
        Tue, 25 Feb 2020 00:07:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:60c6:7e02:8eeb:a041? ([2001:b07:6468:f312:60c6:7e02:8eeb:a041])
        by smtp.gmail.com with ESMTPSA id b67sm3133434wmc.38.2020.02.25.00.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 00:07:01 -0800 (PST)
Subject: Re: [PATCH] KVM: LAPIC: Recalculate apic map in batch
To:     Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1582022829-27032-1-git-send-email-wanpengli@tencent.com>
 <87zhdg84n6.fsf@vitty.brq.redhat.com>
 <CANRm+Cyx+J+YK8FzFBV8LRNPeCaXPc93vjFdpA0D_hA+wrpywQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f433ff7e-72de-e2fd-5b71-a9ac92769c03@redhat.com>
Date:   Tue, 25 Feb 2020 09:07:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CANRm+Cyx+J+YK8FzFBV8LRNPeCaXPc93vjFdpA0D_hA+wrpywQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/20 01:47, Wanpeng Li wrote:
>> An alternative idea: instead of making every caller return bool and
>> every call site handle the result (once) just add a
>> KVM_REQ_APIC_MAP_RECALC flag or a boolean flag to struct kvm. I
>> understand it may not be that easy as it sounds as we may be conunting
>> on valid mapping somewhere before we actually get to handiling
> Yes.
> 
>> KVM_REQ_APIC_MAP_RECALC but we may preserve *some*
>> recalculate_apic_map() calls (and make it reset KVM_REQ_APIC_MAP_RECALC).
> Paolo, keep the caller return bool or add a booleen flag to struct
> kvm, what do you think?

A third possibility: add an apic_map field to struct kvm_lapic, so that
you don't have to add bool return values everywhere.

Paolo

