Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F19C47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 12:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C494120820
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 12:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJxCBHMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgEIMyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 08:54:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51580 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726782AbgEIMyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 08:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589028886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nx7i4+sm5IylK0DJFpKkbPDe53y6Qh0HUjzPyqbwKfk=;
        b=CJxCBHMSySR8tsNDozFztiD4XfrkeT3lTzM6800XS3CKAQQ8GEERlJdviJTc7pAFdLS65c
        /4Z7MZoxwNz7q+pdm6o0F9ak9HpS1MzVS/mycc2OLGJZ1tr4iNRu5t4GpT8bWXw/b0Gh0F
        5fHngSzmxsUbfOjO9AwFZumPX/Cz3N0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-zmJ8_DFDO8-3fhoJSH3fCw-1; Sat, 09 May 2020 08:54:45 -0400
X-MC-Unique: zmJ8_DFDO8-3fhoJSH3fCw-1
Received: by mail-wr1-f69.google.com with SMTP id a3so2358315wro.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 05:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nx7i4+sm5IylK0DJFpKkbPDe53y6Qh0HUjzPyqbwKfk=;
        b=nfGkSq68SlLfpPdd3hzP/9Y0ibbdiEFuScoHlgo3eA7Jhja7oC9QfAUz7TyNrst97W
         xhZ5xuByDNxLgO969N/MvO8cROo91ayv7DWArm6/cH0jphmZwbhqFDeQZgt2lePb4Lwc
         wq1RokgVUTjuqgceqBIvmBFg6LAlEIe5Lo1ZxQGHc0rERuQkDQhsm6zr6zPXP08JJ+xZ
         ttkobodRItZZamVP5iEFEU6M+XmkVp0azVh/0d9lbE4uT02zoA3C2co+Oe4BgRlPoTVy
         KvikZjJsmY3ML2RpPQdYZol6Rqxmj+9YRd2vLA4Cf2bxvWcurzOWYgE0h99BR+ohUz0U
         yIYw==
X-Gm-Message-State: AGi0PuZ+z/nF9scmguPAWO3N6gY1DYgpbHXLI197uLkW1p3CEBWym5uR
        V78vFQG3HU3e7sbwJHg9mX8TMpfIZ8eSiwy/CRRmJSZxEHp6V0JL9gHKGcdD8N0b9HfGbVlFn2g
        8/6twNJmuKb2LfHkmqR/ZZx57
X-Received: by 2002:adf:f00e:: with SMTP id j14mr1684161wro.252.1589028883789;
        Sat, 09 May 2020 05:54:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypLCMfgaKo+9i2/6L1tsiD3080IT0rU+1LLK7ZOFUIy/ZAt/k7wVzyOi7AwLmhlYZuCqzXuyCw==
X-Received: by 2002:adf:f00e:: with SMTP id j14mr1684141wro.252.1589028883550;
        Sat, 09 May 2020 05:54:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cb4:2b36:6750:73ce? ([2001:b07:6468:f312:1cb4:2b36:6750:73ce])
        by smtp.gmail.com with ESMTPSA id g15sm110949wro.71.2020.05.09.05.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 05:54:43 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: VMX: Invoke kvm_exit tracepoint on VM-Exit due
 to failed VM-Enter
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200508235348.19427-1-sean.j.christopherson@intel.com>
 <20200508235348.19427-2-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <551ed3f8-8e6c-adbd-67ff-babd39b7597f@redhat.com>
Date:   Sat, 9 May 2020 14:54:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200508235348.19427-2-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/20 01:53, Sean Christopherson wrote:
> Restore the pre-fastpath behavior of tracing all VM-Exits, including
> those due to failed VM-Enter.
> 
> Fixes: 032e5dcbcb443 ("KVM: VMX: Introduce generic fastpath handler")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Squashed, thanks.  Though is it really the right "Fixes"?

Paolo

