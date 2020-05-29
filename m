Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52647C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ADF3207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJxM1O0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgE2LMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:12:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43067 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725790AbgE2LME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590750723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9M/dfx/AlUONwh5MphhAji3d3cM3kUpcCH4+D+us/Ew=;
        b=QJxM1O0Ub52xPJ5rYY8sYjbJBLtCMwfAnuDJb5MKX3nY9Amo9JrLir8b2J81qSL3Wjz9p/
        EeczS8jZAWE5KZLmvX5rhpyEdS1TgSWY0pe8fF1JaD3b0Vsfz+pb09Q/qgS/oGPGixDo4u
        0Ga3BrP93l2lh4sSz0itZ26OKhOJXxs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-7gwBcquZNkSNAm1888XoGw-1; Fri, 29 May 2020 07:12:01 -0400
X-MC-Unique: 7gwBcquZNkSNAm1888XoGw-1
Received: by mail-wr1-f69.google.com with SMTP id 3so905904wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 04:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9M/dfx/AlUONwh5MphhAji3d3cM3kUpcCH4+D+us/Ew=;
        b=YOV6k3qvttzaIPSVk497krl8YCk3FIlb4UJA7+Q1CJ0qYyGEd3eUg/bRv/28tTdQHL
         v7gZpq+di6Yq1GapP0uSPcPT5HyDjw+XCL1zV56m1Deovv3wR7Z7CqmhZA+dfjcDfxip
         VQorwE0A/iMJk3rWvN84hS8/u7UmHlqtQodz9OV5m7JC0+pU5dn2bD9qzSQgilABlMom
         k67jx3Od2ujt0grRmru985UdV9798yxBwx5zCF4gickCgtRy2kFWIQaR4WxEDqcvglI+
         fT2TffifhZumoC/qrOwz25XrqygeMWioZMTAn/VmWH0MiDUioQYpEa0MrEWspCa/OWoh
         WGAQ==
X-Gm-Message-State: AOAM531DMBH16ENbU45jneCLRgbZP85fKQCuHXmLEnrnaY0qLje0UH/E
        rmDCv2tAySqzWWR0mhx6cEGlty5LIYXON28cWqjZ9RKWQqGPm/mtPirzhMrj8eALcAZJWF0X2p4
        Gj+nU8P/yN4UNiSsB8c9TI/kR
X-Received: by 2002:a7b:c5cc:: with SMTP id n12mr8037160wmk.69.1590750720112;
        Fri, 29 May 2020 04:12:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXn3TKEVztYoQ/UzuKg90zh74+FaWzUOHiQ5op3FdCYq5th45LuGb7iOizyYyyR3rfbSOLuQ==
X-Received: by 2002:a7b:c5cc:: with SMTP id n12mr8037141wmk.69.1590750719880;
        Fri, 29 May 2020 04:11:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b096:1b7:7695:e4f7? ([2001:b07:6468:f312:b096:1b7:7695:e4f7])
        by smtp.gmail.com with ESMTPSA id t8sm9309944wro.56.2020.05.29.04.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 04:11:59 -0700 (PDT)
Subject: Re: [PATCH RFCv2 9/9] arm64: Support async page fault
To:     Marc Zyngier <maz@kernel.org>, Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        shan.gavin@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-10-gshan@redhat.com>
 <81adf013-3de7-23e6-7648-8aec821b033c@redhat.com>
 <a6addc25-29af-3690-8392-efa5e8381e98@redhat.com>
 <8ab64c6a-582b-691d-79ab-21cdc0455cd3@redhat.com>
 <6a4a82a4-af01-98c2-c854-9199f55f7bd3@redhat.com>
 <6965aaf641a23fab64fbe2ceeb790272@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0bfb944-b50a-608a-7dcc-5a409cdc4524@redhat.com>
Date:   Fri, 29 May 2020 13:11:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6965aaf641a23fab64fbe2ceeb790272@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/20 11:41, Marc Zyngier wrote:
>>>
>>>
>>> For x86 the advantage is that the processor can take care of raising the
>>> stage2 page fault in the guest, so it's faster.
>>>
>> I think there might be too much overhead if the page can be populated
>> quickly by host. For example, it's fast to populate the pages if swapin
>> isn't involved.

Those would still be handled by the host.  Only those that are not
present in the host (which you can see through the MMU notifier) would
be routed to the guest.  You can do things differently between "not
present fault because the page table does not exist" and "not present
fault because the page is missing in the host".

>> If I'm correct enough, it seems arm64 doesn't have similar mechanism,
>> routing stage2 page fault to guest.
> 
> Indeed, this isn't a thing on arm64. Exception caused by a S2 fault are
> always routed to EL2.

Is there an ARM-approved way to reuse the S2 fault syndromes to detect
async page faults?

(By the way, another "modern" use for async page faults is for postcopy
live migration).

Thanks,

Paolo

