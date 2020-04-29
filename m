Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46991C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F5EA20731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCtNWkBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgD2Kyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:54:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58085 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726781AbgD2Kyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588157683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1cJOcsITeGuuFSmyQcAgzotWfzaSh5Zzyy+QRSPuMAQ=;
        b=LCtNWkBgY0tqPL41QJR/6ek4ZyyhLzU+cLNz7Qjm3+BC7FG1mo1ehUi+R7afuOwtSn0NfL
        9pdCqI1PXJAe20QI41EjqewpRviPQwYrA8eEW4xpYaOTnj/xOL7X6NLJeCmbiacja/3TBw
        DeAiimFXNytZGj5gSMJBlAxL8dHmvTw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-NuK4hcLqPSWcawsjVymT5A-1; Wed, 29 Apr 2020 06:54:42 -0400
X-MC-Unique: NuK4hcLqPSWcawsjVymT5A-1
Received: by mail-wm1-f69.google.com with SMTP id 71so828847wmb.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 03:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1cJOcsITeGuuFSmyQcAgzotWfzaSh5Zzyy+QRSPuMAQ=;
        b=ZYoHRjfbhWpx/GRC8OYc6sZjLk+hMVokSXqtfBH43yMzpTPxqos6AXLF/G8n2ocZ9w
         GauCWJ7GvPjI0ghAeXx6voWHyaY2Nmtn7yyDz+6Ezp0VVfw1vAXaONUgJPZ01NtZuZJ3
         TeBkfqPsDadEmFJ2ne9p/RFhfTTvZLDooEcVubbVmLiyg/ViA44Lx/65maLBzYsExh/h
         STNt8TpKD1SkTS8P4moec3u2672Ow/uc+JJ2NoQ8EzUhkHmnAw60KN/Y2W5HvLXlANgx
         SNUudARWOKyuYQu509tLOaCLMzeOndNF7jUJEeG5B4B+wfSqc8JHmn6FHDCynkswpcJX
         Pl/A==
X-Gm-Message-State: AGi0PuaqRaEIcd9CviA1Mf3dGKx4k3vHkT3KBI/D9IwNqk5MpNXq2D+l
        9FozwyU6buaaVsO4ENXQzpz8wbY9h2Ut5SrxH3om0JKlQ5dyWYbIPG8BIMgtONJe5T4UWWF5zVr
        62LgM/BA0eueAAFYVhDoR6SI1
X-Received: by 2002:a5d:694a:: with SMTP id r10mr38689760wrw.228.1588157680822;
        Wed, 29 Apr 2020 03:54:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypJsj3uw9QwoYulMbmYbXR2zlrQYM4ikHzCxqwD+B6HI/f1xweUSyi8lML7WK+Ee38kRGCI1VA==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr38689739wrw.228.1588157680633;
        Wed, 29 Apr 2020 03:54:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac19:d1fb:3f5f:d54f? ([2001:b07:6468:f312:ac19:d1fb:3f5f:d54f])
        by smtp.gmail.com with ESMTPSA id d5sm29819654wrp.44.2020.04.29.03.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 03:54:39 -0700 (PDT)
Subject: Re: [PATCH RFC 3/6] KVM: x86: interrupt based APF page-ready event
 delivery
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
References: <20200429093634.1514902-1-vkuznets@redhat.com>
 <20200429093634.1514902-4-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <546bb75a-ec00-f748-1f44-2b5299a3d3d7@redhat.com>
Date:   Wed, 29 Apr 2020 12:54:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200429093634.1514902-4-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/20 11:36, Vitaly Kuznetsov wrote:
> +
> +	Type 1 page (page missing) events are currently always delivered as
> +	synthetic #PF exception. Type 2 (page ready) are either delivered
> +	by #PF exception (when bit 3 of MSR_KVM_ASYNC_PF_EN is clear) or
> +	via an APIC interrupt (when bit 3 set). APIC interrupt delivery is
> +	controlled by MSR_KVM_ASYNC_PF2.

I think we should (in the non-RFC version) block async page faults
completely and only keep APF_HALT unless the guest is using page ready
interrupt delivery.

Paolo

