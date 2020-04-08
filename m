Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3D7C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA28020730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsgDXVDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbgDHQu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:50:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39064 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726754AbgDHQu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586364628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GEFzxGugHwTrvuv37BPHzwDk2hATRin4OSCD/6R76Ww=;
        b=JsgDXVDKj2/Mdw41JqGJqS/B7N8MBCkASjBFIFoup+yBQKZrCmPcwr45sPRe1krsJ40mIX
        qRhueoyq7jMjQugJiL+9AFBZRv2YZ7wK3rFoO+GLYwOkUF+alCa3FDnlQWXsBNoOfmSIxV
        0Q85FoNl3kQAnzGd2l+FE/8FGdRgssY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-qxLObCJwOrOT1quOIWZjtQ-1; Wed, 08 Apr 2020 12:50:26 -0400
X-MC-Unique: qxLObCJwOrOT1quOIWZjtQ-1
Received: by mail-wr1-f69.google.com with SMTP id y6so4626145wrq.21
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 09:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GEFzxGugHwTrvuv37BPHzwDk2hATRin4OSCD/6R76Ww=;
        b=sEkjr2AEuAmmv6LS2ECP58EXUhk82lRWq9bZouIamE+gVyzjhVfY8aXSETG6mxNUsG
         XPzvh05H2Z6ZikOaQLtQOoZhOzzMEm/Y2eqde3AQu7G8ttGKsPlFq5FVJtvZ3MuP2Y96
         vU3kNWEKYsRVRK2R71P1kYQreXersRUdiBXtsPCxZQeJczZ4daoCrA8Sms35NjPOEbz/
         UK5TDe+Itqbrll2l5FDoZkFIlf7uxywBTH1lGKzJAw+ugTcKcUxGuhwUZVT6DiQUcjSi
         k65kGulUfK8EYvxh4WzACKzsc5r6i5CDZn4nvDH08/4m0ACF5kiJXIc6vfMvTxe+i3c+
         9uuQ==
X-Gm-Message-State: AGi0PubdSSPhuPAXP4fTShCjrSCprgl/UBN9dVIeU/Sq67OuwalGDPp1
        jgKtZElNTwui2syBAcAMJeDUpmfVUwF26NLHs+oCef0Q0iVIlz4SyzQ6LrXBZ3FRbVTbLiD7OMd
        zk9MCkTfUeIwYYWIHXv36F4Yy
X-Received: by 2002:a5d:4649:: with SMTP id j9mr10108917wrs.71.1586364625094;
        Wed, 08 Apr 2020 09:50:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypIfCXLt0kF7cyjpECu6nvaYx1McBhi3w+mzdWBDI5wsboGKzNwv/AeI5PDPDHt+4X21+78plA==
X-Received: by 2002:a5d:4649:: with SMTP id j9mr10108883wrs.71.1586364624737;
        Wed, 08 Apr 2020 09:50:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9c71:ae6b:ee1c:2d9e? ([2001:b07:6468:f312:9c71:ae6b:ee1c:2d9e])
        by smtp.gmail.com with ESMTPSA id b82sm193680wmh.1.2020.04.08.09.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 09:50:24 -0700 (PDT)
Subject: Re: [PATCH v2] x86/kvm: Disable KVM_ASYNC_PF_SEND_ALWAYS
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>, stable <stable@vger.kernel.org>
References: <20200407172140.GB64635@redhat.com>
 <772A564B-3268-49F4-9AEA-CDA648F6131F@amacapital.net>
 <87eeszjbe6.fsf@nanos.tec.linutronix.de>
 <ce81c95f-8674-4012-f307-8f32d0e386c2@redhat.com>
 <874ktukhku.fsf@nanos.tec.linutronix.de>
 <274f3d14-08ac-e5cc-0b23-e6e0274796c8@redhat.com>
 <20200408153413.GA11322@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce28e893-2ed0-ea6f-6c36-b08bb0d814f2@redhat.com>
Date:   Wed, 8 Apr 2020 18:50:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200408153413.GA11322@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/20 17:34, Sean Christopherson wrote:
> On Wed, Apr 08, 2020 at 10:23:58AM +0200, Paolo Bonzini wrote:
>> Page-not-present async page faults are almost a perfect match for the
>> hardware use of #VE (and it might even be possible to let the processor
>> deliver the exceptions).
> 
> My "async" page fault knowledge is limited, but if the desired behavior is
> to reflect a fault into the guest for select EPT Violations, then yes,
> enabling EPT Violation #VEs in hardware is doable.  The big gotcha is that
> KVM needs to set the suppress #VE bit for all EPTEs when allocating a new
> MMU page, otherwise not-present faults on zero-initialized EPTEs will get
> reflected.
> 
> Attached a patch that does the prep work in the MMU.  The VMX usage would be:
> 
> 	kvm_mmu_set_spte_init_value(VMX_EPT_SUPPRESS_VE_BIT);
> 
> when EPT Violation #VEs are enabled.  It's 64-bit only as it uses stosq to
> initialize EPTEs.  32-bit could also be supported by doing memcpy() from
> a static page.

The complication is that (at least according to the current ABI) we
would not want #VE to kick if the guest currently has IF=0 (and possibly
CPL=0).  But the ABI is not set in stone, and anyway the #VE protocol is
a decent one and worth using as a base for whatever PV protocol we design.

Paolo

