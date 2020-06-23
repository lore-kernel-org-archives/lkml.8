Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E88AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0737820724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJaZY71+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbgFWLgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:36:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52082 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732493AbgFWLez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592912094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZODIgcS19tFSBJajrqs8sj77Yz+AdpEOnLNxiRzpiI=;
        b=OJaZY71+eQIJXJ2hEmA/F6eZm/VUD9SDfPEA4wVMAiSg0CoG8cmG/bj4OuT52y31GxzBrK
        E4vwWlRS+NqsolWK9ACfOT2Tl9e/8kjPN7afWiYpldk+Pb1gUQkUsFsam8leTJZ9Vepx+y
        4Vcl+q+gOTAEuKFwWsBiLvJX5T4epQw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-p3X3Wuh2OUSXhJYEJEaVxQ-1; Tue, 23 Jun 2020 07:34:53 -0400
X-MC-Unique: p3X3Wuh2OUSXhJYEJEaVxQ-1
Received: by mail-wr1-f71.google.com with SMTP id b14so14805269wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 04:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+ZODIgcS19tFSBJajrqs8sj77Yz+AdpEOnLNxiRzpiI=;
        b=EJKEkAUayKctTog5J0Zg000+kR7lPerH3jwtqGCcsyyER/8ioaNbM6+EbfYcCcdIv9
         A1IPax8E3OTv6CKchhjw4TpTY57E60LaktAFUsQwQSOIGdsdm6IhONHZVFsB9EP2a4bg
         zAO6FfG21jCypTvPhN4asHBSI7sWpXI8s1eK2IBOyajNX7rir2BHQZ0Ozms6Mwfpxd4N
         RE93FfF61yj+AaDRr5gFtQJOSE3dzBLvzz6YXqt+a2PaBxDKORIZWWxrg1CAUhpvjM+R
         BeD5T3zEHUoE/cONxiHXOPTzsXs1evSdSJYEK8bk4E7wXo80yC4q5IlT5j5/oV42M3AS
         dTVw==
X-Gm-Message-State: AOAM5310JQ8MXABirM4YoXI0xGzyeLH7d7oWjDV05VfPzptP9OIC593Q
        sCIfTdfnzZ5FX6urGQfMZllZ17wL8yzaiK8ucJLvkkRcVvcqSnMEkQd5sxejzqyrqJpCe+xu+SB
        fXeSrBNT6QaEwRharGzDo5u8K
X-Received: by 2002:a1c:8186:: with SMTP id c128mr24972074wmd.114.1592912091692;
        Tue, 23 Jun 2020 04:34:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynO7onTieU0CMyosFaYIQpTPTslvzmAYKwjyQbwn2Whk9jT8Rb16JfG2tl/W0NzUrq0KbaBg==
X-Received: by 2002:a1c:8186:: with SMTP id c128mr24972060wmd.114.1592912091442;
        Tue, 23 Jun 2020 04:34:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24f5:23b:4085:b879? ([2001:b07:6468:f312:24f5:23b:4085:b879])
        by smtp.gmail.com with ESMTPSA id f186sm3325254wmf.29.2020.06.23.04.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 04:34:50 -0700 (PDT)
Subject: Re: [PATCH] kvm: lapic: fix broken vcpu hotplug
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, kvm@vger.kernel.org, wanpengli@tencent.com
References: <20200622160830.426022-1-imammedo@redhat.com>
 <c00acf88-0655-686e-3b8c-7aad03791f20@redhat.com>
 <20200623131343.01842ee5@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1677b9af-fe23-242c-3160-9d9e6c1412c6@redhat.com>
Date:   Tue, 23 Jun 2020 13:34:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200623131343.01842ee5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/20 13:13, Igor Mammedov wrote:
>>> +	apic->vcpu->kvm->arch.apic_map_dirty = true;
>>>  	kvm_lapic_set_base(vcpu, vcpu->arch.apic_base);
>>>  	/* set SPIV separately to get count of SW disabled APICs right */
>>>  	apic_set_spiv(apic, *((u32 *)(s->regs + APIC_SPIV)));
>>>   
>> Queued, but it's better to set apic_map_dirty just before the call to
>> kvm_recalculate_apic_map, or you can have a variant of the race that you
>> pointed out.
> Here I was worried about failure path as well that is just before normal
> kvm_recalculate_apic_map(), and has its own kvm_recalculate_apic_map().
> 
> but I'm not sure if we should force map update in that case.
> 

In that case kvm_lapic_set_base and apic_set_spiv will take care of it
(and if it kvm_apic_state_fixup writes LDR, it succeeds and you go down
the other path).

Paolo

