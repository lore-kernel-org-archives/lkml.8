Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99FFC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 00:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EED20719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 00:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnIsEK0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgCZA2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 20:28:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49364 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727537AbgCZA2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 20:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585182488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SDXVjwabGcLnnuvHuXD+2C6fjzzt3JFDASzYAhuMkEg=;
        b=UnIsEK0kpVT2PVwowl+OmW0hNq3NIMNXRpP75dX+eGFs3NtXGl/vSDtHlJeT6LFY0Rp0Xt
        XDrNx6wFtEpZdJYoX9a4LzFBUJY3bRIOt1np2ve21xWtTvywVzfEGgyHiKZ4V07nnxeerO
        /OD4tuZ3rU3ZzOhBBXN9r8lWB/u+LKg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-o9laSwEnPfCue4lp289TLQ-1; Wed, 25 Mar 2020 20:28:06 -0400
X-MC-Unique: o9laSwEnPfCue4lp289TLQ-1
Received: by mail-wm1-f71.google.com with SMTP id f207so1688542wme.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 17:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SDXVjwabGcLnnuvHuXD+2C6fjzzt3JFDASzYAhuMkEg=;
        b=uF4PvESbpmAKJMSW+SgEu2PMJfw0VqdEvMxv8Ls87z9cwQhe9nHdLzoy2oHZHWAyvb
         ZwIUgKjt7ItH9sMm4oIvSih9QTC6hO7IBjgZUfLJp7GurmjmjybCrxzoOCUjtKNBELm7
         KxKH/IOFfbEO+ecGPMNqaT8NWZlIe4cOVGc9bcf1zSsywomrQy44SMLIoMuKDVJi3x0m
         QkakRTEOgzqJljo43zQNH+7POhBx0Xu3urcoKfxsU5h6MJM0CeZB5R1qq5E03QS1m6iB
         HnroXaXge9uCuD/u/x45GCrn4TFCH/XVwMQxRniJgqLsDmJMtr0wdpQ6otclYGTl+/oj
         QIpQ==
X-Gm-Message-State: ANhLgQ3mqwE66K0uif+Zl+ZdIfA9BdjTNsZL53kujsfAZPlbn8HF9WKF
        ZgliLK+4EEYEn3ccGYAX5sThEM5+Ftw73KrRFeVJSZAQlj2V9OQLPIOy4k7ps9KDt7RgptY1zsQ
        PwbmXFUw4BFPZuIdvyqLLnhDY
X-Received: by 2002:a1c:cc0a:: with SMTP id h10mr186281wmb.127.1585182485154;
        Wed, 25 Mar 2020 17:28:05 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtAeCtfvyg1e/6on18f0iRgwGs0bFCeegTp5Koi0KhHlOdFq4kOD9JbFWu4AHOeYtV60i0H1Q==
X-Received: by 2002:a1c:cc0a:: with SMTP id h10mr186264wmb.127.1585182484845;
        Wed, 25 Mar 2020 17:28:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e4f4:3c00:2b79:d6dc? ([2001:b07:6468:f312:e4f4:3c00:2b79:d6dc])
        by smtp.gmail.com with ESMTPSA id b82sm972243wmb.46.2020.03.25.17.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 17:28:04 -0700 (PDT)
Subject: Re: [PATCH] KVM: LAPIC: Also cancel preemption timer when disarm
 LAPIC timer
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1585031530-19823-1-git-send-email-wanpengli@tencent.com>
 <708f1914-be5e-91a0-2fdf-8d34b78ca7da@redhat.com>
 <CANRm+CwGT4oU_CcpRcDhS992htXdP4rcO6QqkA1CyryUJbE6Ug@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5582f554-5ae9-4cb9-d8e9-f1ff57fca35c@redhat.com>
Date:   Thu, 26 Mar 2020 01:28:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CwGT4oU_CcpRcDhS992htXdP4rcO6QqkA1CyryUJbE6Ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/20 01:20, Wanpeng Li wrote:
>> There are a few other occurrences of hrtimer_cancel, and all of them
>> probably have a similar issue.  What about adding a cancel_apic_timer
> Other places are a little different, here we just disarm the timer,
> other places we will restart the timer just after the disarm except
> the vCPU reset (fixed in commit 95c065400a1 (KVM: VMX: Stop the
> preemption timer during vCPU reset)), the restart will override
> vmx->hv_deadline_tsc. What do you think? I can do it if introduce
> cancel_apic_timer() is still better.

At least start_apic_timer() would benefit from adding hrtimer_cancel(),
removing it from kvm_set_lapic_tscdeadline_msr and kvm_lapic_reg_write.
 But you're right that it doesn't benefit from a cancel_apic_timer(),
because ultimately they either update the preemption timer or cancel it
in start_sw_timer.  So I'll apply your patch and send a cleanup myself
for start_apic_timer.

Thanks,

Paolo

