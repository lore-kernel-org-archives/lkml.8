Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BC6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E7DD206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0wzv/v3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgFJXxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:53:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37235 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726722AbgFJXxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 19:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591833222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WI0+NbsJ1zacj1DISmUqJe9tzBi7AdJpLzC1uFJh4Cs=;
        b=H0wzv/v3BWCPA2djtVukAHnf43Pm8dLaD6+Et3jfxbDmP4FuIwbFwCMIEuY9usi+PEpbXC
        WdhJ3liVgdMjRxLivYm9TZx7lKWlk2KQUcb9qtIwTATOaQJ2TeN1e+Xyzf2KJvpDB6Gebo
        +1OVm/gTCN4T5FykoBS8irKMgjI5lfs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-j04VmEwoN5CeWZl27wQuYg-1; Wed, 10 Jun 2020 19:53:40 -0400
X-MC-Unique: j04VmEwoN5CeWZl27wQuYg-1
Received: by mail-wr1-f69.google.com with SMTP id p10so1753966wrn.19
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WI0+NbsJ1zacj1DISmUqJe9tzBi7AdJpLzC1uFJh4Cs=;
        b=HcDLJ1JEITC9WgPkdxfYyjV+/9NzHS2qOLxOjV2XdinyMhI5+oCKCZbv6kcLcb8Mz1
         qj6ES554EBIawQLvYcTzjW3lZo6sHQa8yj4x+dknH6c+uHoo0KIe1zIjrfPe4Eak21dE
         drrsTDqugdDeUPva0Dz/YnTOa5mD7UrUU3AB3p4eFh3VJbEruS7N6kHMt3Spd8AeS7N+
         m0dWBKXkfSGDlyRR5o21AhdCQ0Sp62EjztKh3BnkuNs8iZXmNQPW24lTtLUEMk1Vgrto
         4h9AVQBjPqz+XQIZtcqyspEvhxwWAYQt5ob/TyctiHgnD4hG53tyI/tvRBCuQeDQEX3C
         W09g==
X-Gm-Message-State: AOAM531mH+fveMTKnDXhNfkHFhDtDfMjkCj17nQ5hJ24/uOK85efqbkZ
        v46pyQvGb1CuKV+UnFliLaNP5AKOL/8e13/+3lQfMBbY3a3ETtzg008ZPZpkq0swg+MRrDRLejP
        nORIJSPIzTz8/4YeJ0PZdduOF
X-Received: by 2002:a5d:6789:: with SMTP id v9mr6785870wru.124.1591833219412;
        Wed, 10 Jun 2020 16:53:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGyH+9QSFaUyuUyAYSrKWRjuZk8Y1vF202/B03IwIpUI+dw/51oImN2L3Z89rIzK3JWB8I0g==
X-Received: by 2002:a5d:6789:: with SMTP id v9mr6785853wru.124.1591833219187;
        Wed, 10 Jun 2020 16:53:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29ed:810e:962c:aa0d? ([2001:b07:6468:f312:29ed:810e:962c:aa0d])
        by smtp.gmail.com with ESMTPSA id b132sm1588022wmh.3.2020.06.10.16.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 16:53:38 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: async_pf: Inject 'page ready' event only if
 'page not present' was previously injected
To:     Vivek Goyal <vgoyal@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
References: <20200610175532.779793-1-vkuznets@redhat.com>
 <20200610175532.779793-2-vkuznets@redhat.com>
 <20200610193211.GB243520@redhat.com> <20200610194738.GE18790@linux.intel.com>
 <20200610195725.GA263462@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <91bf7843-ec23-e89e-a61f-1e36a32af09c@redhat.com>
Date:   Thu, 11 Jun 2020 01:53:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200610195725.GA263462@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/20 21:57, Vivek Goyal wrote:
> I personally find it better that initialization of
> work->notpresent_injected is very explicit at the site where this 
> structure has been allocated and being initialized. (Instead of a
> a callee function silently initializing a filed of this structure).

I agree.

Paolo

