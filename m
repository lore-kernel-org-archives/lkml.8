Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C480DC54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A477C2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKNLFdBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgCYQIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:08:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:21739 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbgCYQIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585152487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQO5Ewg01ixtL/pUvCaQWy2hwzdcfLmoIS7TRCLSyP4=;
        b=VKNLFdByTUBLL29Z27PGJzOciSuW43SphXMteyWoGePZvjvzqf+CImIcsUiw6YDCQ6OIq2
        jpmDvExk+oJ/6jUGaRKB0OKW+smOnikMMjUOu8u0lluT1B/kK5LoYsIuh4V6JqtnOroSq+
        KRo9AuQC4AChJoiyNsPbKQ1b8UiG8I4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-6xv-odLeMwWEDgEDT66WBw-1; Wed, 25 Mar 2020 12:08:06 -0400
X-MC-Unique: 6xv-odLeMwWEDgEDT66WBw-1
Received: by mail-wr1-f70.google.com with SMTP id d1so1351170wru.15
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 09:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KQO5Ewg01ixtL/pUvCaQWy2hwzdcfLmoIS7TRCLSyP4=;
        b=TtIqiqTgiSblqMBJb+vnBJKB2YBxzPTdtP9x6bWc2hVF3PD4jYz/upP6J4X2wLfvI4
         Fw9OJJgwNPy8p9NSCUXBibIgz/wLsuk6BhdSq+H+Ss2jWWXWLlKt0DpgncPby6D4Uz7V
         ZeeLdfJ5vhXICHwN7kNPvFdBmhccWEi1XCi80bgpY4rlYRVs+D3P3vqhOkOM+NPicmlg
         kDFYwXrihvl4cH6oaWbafYKVgq8xTtN7YT+YsFghP52gdDOfbAY6EQFbWaewMhAB10dX
         MWJIB6unhqhYYLVRlA2oaGXXOv5CmatfnlPfQSrGvK6aUMfkCHzeipYpVg54QEIH/Xy0
         5LFQ==
X-Gm-Message-State: ANhLgQ1ct55eTUsKLy18SHycV0I/GTusI6z4Vg+vyGOE6H9y0uYpuxob
        kBrvoxo46ad9Y+5blhm1ron8OSRm5hvAN6/Co3KBwFbyqAAKR8Efs661/JZydWOvIKggcx71DQh
        l0ZFlIlufYymXuVBn0nIp7Bln
X-Received: by 2002:adf:f386:: with SMTP id m6mr4273260wro.107.1585152485053;
        Wed, 25 Mar 2020 09:08:05 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs2RbBSSENYa1saW4WvfsxYiIaG52scS5B1XDE46lVvH86KlHN01LnBRy1sc44INfcBCW6dIA==
X-Received: by 2002:adf:f386:: with SMTP id m6mr4273243wro.107.1585152484873;
        Wed, 25 Mar 2020 09:08:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e4f4:3c00:2b79:d6dc? ([2001:b07:6468:f312:e4f4:3c00:2b79:d6dc])
        by smtp.gmail.com with ESMTPSA id k185sm9788103wmb.7.2020.03.25.09.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 09:08:04 -0700 (PDT)
Subject: Re: linux-next: Tree for Mar 25 (arch/x86/kvm/)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200325195350.7300fee9@canb.auug.org.au>
 <e9286016-66ae-9505-ea52-834527cdae27@infradead.org>
 <d9af8094-96c3-3b7f-835c-4e48d157e582@redhat.com>
 <064720eb-2147-1b92-7a62-f89d6380f40a@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <85430f7e-93e0-3652-0705-9cf6e948a9d8@redhat.com>
Date:   Wed, 25 Mar 2020 17:08:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <064720eb-2147-1b92-7a62-f89d6380f40a@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/20 16:57, Randy Dunlap wrote:
>> Randy, can you test it with your compiler?
> Nope, no help.  That's the wrong location.
> Need a patch for this:
>>> 24 (only showing one of them here) BUILD_BUG() errors in arch/x86/kvm/cpuid.h
>>> function __cpuid_entry_get_reg(), for the default: case.

Doh, right.  I think the only solution for that one is to degrade it to
WARN_ON(1).

Paolo

