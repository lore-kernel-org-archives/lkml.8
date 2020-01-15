Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A614C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012232077B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRBbbcPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgAOSAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:00:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20356 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726574AbgAOSAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579111203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2XapLbaOtcjtrElHHMAQ6OSRlBJ67a4EYmsF6AdwXZg=;
        b=dRBbbcPZrzgky2JoOpuTTQUjxkjh3ez+SBUhUU+lWhw/Otl0+inHTPPAxGCS1CXABbD3BE
        cY9buOI56UJcdMMdG9Uq2ySDnHIrW9iuk7uCQbURU/q/9Clw2pkbZliqs7pMC9jNeXFsHg
        KzUSInuYK2/VPyudysu6XEeodTb4hhk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-w6tOIuM1PgmuxL2nIqCYQw-1; Wed, 15 Jan 2020 13:00:02 -0500
X-MC-Unique: w6tOIuM1PgmuxL2nIqCYQw-1
Received: by mail-wm1-f70.google.com with SMTP id l11so1710958wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2XapLbaOtcjtrElHHMAQ6OSRlBJ67a4EYmsF6AdwXZg=;
        b=FdiI87kQmxi8ZHZrzoMmByDD0CsJz1zWHoleoV3D8487b+51wl/HifxUhJX3De6uFt
         Xd50VzoNTC5QgOF7WVdN+1/8t+NZMZsIYsvcyUHwwwxTHk4PEJgfk8xmaMXREaD8QcWu
         Z4SsyDIyCyms3lVerneuAkVBEJBHOgfSYjPKvLaVvUkwnRe62BO18JTY86OxTgbtNlD6
         8vwajDHBlJK6DmsM354z2ysNBaIsC73bf9u8yFJ7ky0t8mVOQtyU+G4GxR4L1tapiQPv
         QiQOzuxPH/vSbp1aG82Vwl2l9MRyU4Uk2kmvy0gGHKhmb+XwwNU4dOFUn3tghcbd4Aee
         c7FA==
X-Gm-Message-State: APjAAAVcQuLPUvHU5l3wSrfnznjG5/OD2bFJlQ+PTOZO2fM/M2Kr7Op+
        nw5H5G4yP4XS/9h3ww7tJNzeGacsC1CLLiUjkfF9QZnoeMErGD5CudhgrjCvIquYojcTUac2jjd
        fDm4wSiulUoip3AZTfVRnEjLO
X-Received: by 2002:a1c:ddc5:: with SMTP id u188mr1105008wmg.83.1579111200956;
        Wed, 15 Jan 2020 10:00:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqzdUK4jOChizY1OyBzEt6w49Iopmn3hI+6kXX9D66YP3w9/PZYQxXldJQx6hbbrlNINM/u8jw==
X-Received: by 2002:a1c:ddc5:: with SMTP id u188mr1104980wmg.83.1579111200755;
        Wed, 15 Jan 2020 10:00:00 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a? ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
        by smtp.gmail.com with ESMTPSA id f17sm794870wmc.8.2020.01.15.09.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 09:59:59 -0800 (PST)
Subject: Re: [PATCH 0/2] KVM: VMX: PT (RTIT) bug fix and cleanup
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Luwei Kang <luwei.kang@intel.com>
References: <20191210232433.4071-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <697cee10-cd6e-9bb6-608b-a20fc0c39f7f@redhat.com>
Date:   Wed, 15 Jan 2020 18:59:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191210232433.4071-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/19 00:24, Sean Christopherson wrote:
> Add a missing non-canonical check on writes to the RTIT address MSRs
> and tack on a cleanup patch.
> 
> ** ALL PATCHES ARE COMPLETELY UNTESTED **
> 
> Untested due to lack of hardware.
> 
> Sean Christopherson (2):
>   KVM: VMX: Add non-canonical check on writes to RTIT address MSRs
>   KVM: VMX: Add helper to consolidate up PT/RTIT WRMSR fault logic
> 
>  arch/x86/kvm/vmx/vmx.c | 57 ++++++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 24 deletions(-)
> 

Queued, thanks.

Paolo

