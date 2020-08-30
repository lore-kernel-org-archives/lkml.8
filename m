Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31261C433E7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 09:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10842207BB
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 09:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnBi0CKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgH3Jw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 05:52:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45670 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726264AbgH3Jwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 05:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598781168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CMkU+ayG9L0but2trh3KXSaT/21HI/OkkHJggUMtR4s=;
        b=PnBi0CKD0Fk34OoKMPYtPR3uJ1fw9UiacjHc+Zd+8ISGUDdPoj+d/xTSjPToUpiPpdbOXX
        vFblvHoG+KruZ3DwrKfhwaqO+BWstShAZwQz47N2xQodwzNFcvUZT6E5ncdxN/zVEkKcVE
        /5+mnEs9U3o9kpfA9a+EBxYg5w/M6a0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-YTt7XyGzMu6rqsya8IkJzg-1; Sun, 30 Aug 2020 05:52:46 -0400
X-MC-Unique: YTt7XyGzMu6rqsya8IkJzg-1
Received: by mail-wr1-f71.google.com with SMTP id f14so1867372wrm.22
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 02:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CMkU+ayG9L0but2trh3KXSaT/21HI/OkkHJggUMtR4s=;
        b=dR4i3ADfhCmw7Y3IYtLseVFgHcI9N6MjPBrWtx2Lc2IfqTiwRX8ZhwiR03DTUO0RyB
         beL7sov/vbRJ9mU/DboZrsOEadvgeqb+VFG0wApscCjpIZu3OuJ6f4sJ9POMWa+893HU
         1PIRCzyD4B+FEUmERGTt7R9g1b+fUKi86keGZaqWoY1ZJxlKyDUZyLEuW+6LL/aCUIZN
         YApQi9jZ09qhVjD4BmLTuW5n13O8HDsAUN1qaE69sd7x1qMrN57B++0LqeTAHrCtgrg2
         ykmXBgjwlNb1ucLm6Lg8oSwDBzqcrp7uHU413/m2wPOC3oUQZCyScT5lJYk6GjlaTeI0
         8JJQ==
X-Gm-Message-State: AOAM5307VcVhcZHkXiqQac/nWo7ViQOdZI668W+Y84H79NVB0yyEu3yQ
        T7tNcb3QwtPxcekVQd83CBHHSKeu4qalHI2I+6G2ITuJ7yUAwbgA1TqahVz9JpvXFwfhsbrj0tk
        KP4IhYxuF+pHujfheOyUh+iNG
X-Received: by 2002:adf:b306:: with SMTP id j6mr5702941wrd.279.1598781164775;
        Sun, 30 Aug 2020 02:52:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXOhZ7ViZzfafJn3Iw5fXJyfwgbvXBQ0gQrqm4R0MlaFsmI3OelMzCKNjjMyQ2G3uYIpfUyw==
X-Received: by 2002:adf:b306:: with SMTP id j6mr5702925wrd.279.1598781164574;
        Sun, 30 Aug 2020 02:52:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9d8:ed0a:2dde:9ff7? ([2001:b07:6468:f312:9d8:ed0a:2dde:9ff7])
        by smtp.gmail.com with ESMTPSA id t14sm7448920wrg.38.2020.08.30.02.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2020 02:52:44 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: nVMX: fix the layout of struct
 kvm_vmx_nested_state_hdr
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Peter Shier <pshier@google.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200713162206.1930767-1-vkuznets@redhat.com>
 <CALMp9eR+DYVH0UZvbNKUNArzPdf1mvAoxakzj++szaVCD0Fcpw@mail.gmail.com>
 <CALMp9eRGStwpYbeHbxo79zF9EyQ=35wwhNt03rjMHMDD9a5G0A@mail.gmail.com>
 <20200827204020.GE22351@sjchrist-ice>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e9327d67-3342-8a6e-c981-a53acbd04e9b@redhat.com>
Date:   Sun, 30 Aug 2020 11:52:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200827204020.GE22351@sjchrist-ice>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/20 22:40, Sean Christopherson wrote:
> Paolo pushed an alternative solution for 5.8, commit 5e105c88ab485 ("KVM:
> nVMX: check for invalid hdr.vmx.flags").  His argument was that there was
> no point in adding proper padding since we already broke the ABI, i.e.
> damage done.
> 
> So rather than pad the struct, which doesn't magically fix the ABI for old
> userspace, just check for unsupported flags.  That gives decent odds of
> failing the ioctl() for old userspace if it's passing garbage (through no
> fault of its own), prevents new userspace from setting unsupported flags,
> and allows KVM to grow the struct by conditioning consumption of new fields
> on an associated flag.

In general userspace (as a hygiene/future-proofing measure) should
generally zero the contents of structs before filling in some fields
only.  There was no guarantee that smm wouldn't grow new fields that
would have occupied the padding, for example.  The general solution we
use is flags fields and checking them.

(The original KVM_GET/SET_NESTED_STATE patches did add a generic flags
fields, but not a VMX-specific one).

Paolo

