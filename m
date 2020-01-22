Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40E1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BA22467A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLrOaBl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgAVOfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:35:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44933 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725884AbgAVOfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579703740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xFtBnuA8Z1Te0Pu/OG4AJ4ugC7ZoC2Bg8KQUirpZDDM=;
        b=VLrOaBl86SEIsndCKu3+vEO2V7zkTZzcD2ufggckiNOiy4jJo/O9vcnAm3ssDrz7l+4omy
        r45iWYRnvIfD+1pRdZbA9lx0tSIJd4+u6GfE1WTpkfNOncAYB7D8aZypkE1zbrFC1FshGM
        tEIYvQATXqmPvGhpbUWGSaiNlfBxtK8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-kHUnbOJAODy0hNh2sZsXMQ-1; Wed, 22 Jan 2020 09:35:39 -0500
X-MC-Unique: kHUnbOJAODy0hNh2sZsXMQ-1
Received: by mail-wr1-f71.google.com with SMTP id f15so3175604wrr.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 06:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xFtBnuA8Z1Te0Pu/OG4AJ4ugC7ZoC2Bg8KQUirpZDDM=;
        b=lVzZDSDciSefTQ6p6D6SZoWYSPeUCIsheKJfFEhD61cTILn2OYEyafkutmV3J45eLd
         LVURY1gMBx8BaP9+hJGPilB2hlM0WZHBpfB1uYN5W+KkiqvbLjOVqiX39WNcpSkviR1Q
         Baaw+EUQxPD2SSj6VaTAZG27qpyKSOzI50078pwZc5eEfn4u8+i2U161k2uoZWoMU5CH
         KFkH5JtcjHxX/UrjHLBudvM4iqv8LgQSOfV0qU2Pf2QfQcYVK3bdTG+6u/bP6cWyFi6r
         jbHY8CAccbiZYxsjtxakWJaZzJQvSLTlo1M7plDZY9sYmJ0Y8mUhlIJY+JDTXX6uDrFQ
         mJmQ==
X-Gm-Message-State: APjAAAXZZptfkkYGcoBzm8lufYZkVlx/cMCuOxfGFTFZvt9qjXGQNhdv
        LRdVONmTLkev9aodGYmKUPLxp4V0bqJHT0mmJ2iY6KaIl6TXE2PGpYSGwHpGK2OV1snPGhgytHW
        Vn2DkvNHa926WMi6aLqLGfA2N
X-Received: by 2002:adf:e40f:: with SMTP id g15mr11373876wrm.223.1579703738025;
        Wed, 22 Jan 2020 06:35:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxzVOuWpdVsL4u5Kc9GOTrtAXCJ9my4RfvoGG0hvJeCTDXsX7s7a0PNoQ87r7UEkiMImwavMg==
X-Received: by 2002:adf:e40f:: with SMTP id g15mr11373849wrm.223.1579703737717;
        Wed, 22 Jan 2020 06:35:37 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id 124sm4540042wmc.29.2020.01.22.06.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 06:35:37 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: fix overlap between SPTE_MMIO_MASK and
 generation
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <1579623061-47141-1-git-send-email-pbonzini@redhat.com>
 <CANgfPd8fq7pWe00fKm7QEiOAVFuubSQ-jJxEM1sCKzqJk9rSzw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <41696542-3022-c794-cc43-66aa0aff5b46@redhat.com>
Date:   Wed, 22 Jan 2020 15:35:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CANgfPd8fq7pWe00fKm7QEiOAVFuubSQ-jJxEM1sCKzqJk9rSzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/20 18:24, Ben Gardon wrote:
> BUILD_BUG_ON((MMIO_SPTE_GEN_HIGH_MASK |
> MMIO_SPTE_GEN_LOW_MASK) & SPTE_SPECIAL_MASK)
> 

Yes, this is a better assertion.  I've replaced it in the patch.

Paolo

