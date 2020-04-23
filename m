Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D17AC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 646012076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhZ71I2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgDWK35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:29:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27272 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727014AbgDWK34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587637795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v9AXR8INu2V1rXzlem4kdzH7dLRNBQB5Vc6BL374Yjc=;
        b=GhZ71I2hOUzwRtJgGDWbEfDU3Z7FVPVvQb84chqU2Zw40V2wceOTxe1COUIz5IpAq1uRyU
        4jmso28+otRGkE2tJg7CvmtY0tctMymJTs5BoI6VR1fB3TLA5cay1mICkSGERIturST7PP
        2KwKeaZqQeqwg4YuDfOX50r+Tda0/s0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-OkCP4SNCOAuopXw77MfKQQ-1; Thu, 23 Apr 2020 06:29:48 -0400
X-MC-Unique: OkCP4SNCOAuopXw77MfKQQ-1
Received: by mail-wr1-f69.google.com with SMTP id x15so2655631wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 03:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v9AXR8INu2V1rXzlem4kdzH7dLRNBQB5Vc6BL374Yjc=;
        b=Zf7tg25QIHWPLUKmUCln988EBYES+WhBqkULMJNQs+SEfOZCsmcgjGFcVgyndqMmpz
         uli+gsSeeDbNkkKXdpue+JeRKZxR6NMqLEekomdsWSbwqQUqkfp3k0SojgNCNgc+ItTd
         OAKiwW8vCxaxmARzDHfVgeSFwBpRZnY1oIjH2w7yrQVKpVs5Bt2xAq/0NzzpekmvAyoL
         UlbKTrqB+jIbFXyABkPj2JONbUeEu32udvuDiDgjL2esfOLxUE92JfU1Bu6oZE7TtnoR
         ys3Q1K3kfsvCQHP3JwXLhQNGuRwj5oYFzTylnck7NTVO5M9KP/WJW0HnryqiYUbkDDxi
         31+A==
X-Gm-Message-State: AGi0PubZ7xGtS/IIIWgMj5UINpPagjy5y4NkFZf35NZCInwXqHr5FNM1
        UaFZIMSdiCXbjZt+EyeJlKhGBGSbboyPit4uBcs0ILZaXgwI8yD4qOPpmi1VeVRXU/qPLqdDhU4
        n7GYzqPSw0QR0DHock/HYgE9I
X-Received: by 2002:adf:a3d5:: with SMTP id m21mr4322769wrb.54.1587637787646;
        Thu, 23 Apr 2020 03:29:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypIKDKQY6xB5YBU0fXjYucgfv1RSNisE2zdI//PsRQUExilnMvDayNiGTxi7DsmMMZbDdNW2ow==
X-Received: by 2002:adf:a3d5:: with SMTP id m21mr4322755wrb.54.1587637787471;
        Thu, 23 Apr 2020 03:29:47 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id x13sm3273966wmc.5.2020.04.23.03.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 03:29:46 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] KVM: VMX: Handle preemption timer fastpath
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Haiwei Li <lihaiwei@tencent.com>
References: <1587632507-18997-1-git-send-email-wanpengli@tencent.com>
 <1587632507-18997-6-git-send-email-wanpengli@tencent.com>
 <99d81fa5-dc37-b22f-be1e-4aa0449e6c26@redhat.com>
 <CANRm+CyyKwFoSns31gK=_v0j1VQrOwDhgTqWZOLZS9iGZeC3Gw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce15ea08-4d5d-6e7b-9413-b5fcf1309697@redhat.com>
Date:   Thu, 23 Apr 2020 12:29:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CyyKwFoSns31gK=_v0j1VQrOwDhgTqWZOLZS9iGZeC3Gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/20 11:56, Wanpeng Li wrote:
>> Please re-evaluate if this is needed (or which parts are needed) after
>> cleaning up patch 4.  Anyway again---this is already better, I don't
>> like the duplicated code but at least I can understand what's going on.
> Except the apic_lvtt_tscdeadline(apic) check, others are duplicated,
> what do you think about apic_lvtt_tscdeadline(apic) check?

We have to take a look again after you clean up patch 4.  My hope is to
reuse the slowpath code as much as possible, by introducing some
optimizations here and there.

Paolo

