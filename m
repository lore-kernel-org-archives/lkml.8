Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795BEC55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 510B320706
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Phff+hqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgDYJxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 05:53:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40360 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726022AbgDYJxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 05:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587808381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iy6NQDz2bvlcDJdi3t6wYpiP8TNlTDnJAJ85f9gUoPw=;
        b=Phff+hqW6ClsR/03DfRrw+bScE1Ej6S7NQ272nuXdDi5UQaTikBLJYpKLos9nfdFEdkDLS
        aNRI5QVDySNLXirqIQEEfmdnb1QAbGr+FJ52OjBS4psHsIJWCLXHh5vCTlbJcehvtqayYR
        cmQO1Apo2utJyWczkzPPUQ8RkCkneGM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-h64WV22MMMO4TRI36rJbWg-1; Sat, 25 Apr 2020 05:52:49 -0400
X-MC-Unique: h64WV22MMMO4TRI36rJbWg-1
Received: by mail-wr1-f69.google.com with SMTP id y10so6460472wrn.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 02:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iy6NQDz2bvlcDJdi3t6wYpiP8TNlTDnJAJ85f9gUoPw=;
        b=bHZXgvEoltiyQFlmgQ8v9zDP5TS7MCx2VwfTT7WLQUUvawQLdgQv4hCMUQOAGKBnK/
         TRdW05lYmzeZWlewHHGAbrFImcmnl0eRW/hvzlXfnkDnFzip1cD6j9KqHTrlr0TyjYZZ
         NcyUvK2MeCnbr/S2oH1MfW0StQaWW3M6nyWv3wxH2KV+X2eZxB6eL4h053R0GDLI11+I
         7ZULE+7x29DZyZNAjmhyAlt6/o4kNLxSKsDhArgUbSEOTQhFn2bFookm54sdJIeGeCBu
         4KaYirZmUREJzBd9B6PiNHV9JYxPNBgyv+oiwBnAM3ERv4+8U26hMcISu04p0reGlzde
         C0DQ==
X-Gm-Message-State: AGi0PuYQyFdvGAh8ZCYO59przQaR7KupB9RW0AE646p1l8oHtpqu8BNp
        T9Eqvi13phZDpabeBTJy3+zhhhPAVAsJXnbBTI1piBYEiEDgHjIrEpR9SOFlBbkfurZlPypCg1/
        oHkgqcaDH9OVWd5wilqY3v0st
X-Received: by 2002:a1c:40c4:: with SMTP id n187mr14678366wma.28.1587808368108;
        Sat, 25 Apr 2020 02:52:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ1i6l3HYPsUNNYMgP5vLaP3Jp+6CJeidd7e8baenIOl0PDzANWn6IazIqsDn4jLvfEqaKLTg==
X-Received: by 2002:a1c:40c4:: with SMTP id n187mr14678349wma.28.1587808367849;
        Sat, 25 Apr 2020 02:52:47 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id y63sm6808373wmg.21.2020.04.25.02.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 02:52:47 -0700 (PDT)
Subject: Re: [PATCH] kvm: ioapic: Introduce arch-specific check for lazy
 update EOI mechanism
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     rkrcmar@redhat.com, joro@8bytes.org, jon.grimm@amd.com,
        borisvk@bstnet.org
References: <1587704910-78437-1-git-send-email-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b051913a-10f4-81d4-6ef8-19d586db61da@redhat.com>
Date:   Sat, 25 Apr 2020 11:52:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587704910-78437-1-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/20 07:08, Suravee Suthikulpanit wrote:
> commit f458d039db7e ("kvm: ioapic: Lazy update IOAPIC EOI") introduces
> the following regression on Intel VMX APICv.
> 
> BUG: stack guard page was hit at 000000008f595917 \
> (stack is 00000000bdefe5a4..00000000ae2b06f5)
> kernel stack overflow (double-fault): 0000 [#1] SMP NOPTI
> RIP: 0010:kvm_set_irq+0x51/0x160 [kvm]
> Call Trace:
>  irqfd_resampler_ack+0x32/0x90 [kvm]
>  kvm_notify_acked_irq+0x62/0xd0 [kvm]
>  kvm_ioapic_update_eoi_one.isra.0+0x30/0x120 [kvm]
>  ioapic_set_irq+0x20e/0x240 [kvm]
>  kvm_ioapic_set_irq+0x5c/0x80 [kvm]
>  kvm_set_irq+0xbb/0x160 [kvm]
>  ? kvm_hv_set_sint+0x20/0x20 [kvm]
>  irqfd_resampler_ack+0x32/0x90 [kvm]
>  kvm_notify_acked_irq+0x62/0xd0 [kvm]
>  kvm_ioapic_update_eoi_one.isra.0+0x30/0x120 [kvm]
>  ioapic_set_irq+0x20e/0x240 [kvm]
>  kvm_ioapic_set_irq+0x5c/0x80 [kvm]
>  kvm_set_irq+0xbb/0x160 [kvm]
>  ? kvm_hv_set_sint+0x20/0x20 [kvm]
> ....
> 
> This is due to the logic always force IOAPIC lazy update EOI mechanism
> when APICv is activated, which is only needed by AMD SVM AVIC.
> 
> Fixes by introducing struct kvm_arch.use_lazy_eoi variable to specify
> whether the architecture needs lazy update EOI support.

You are not explaining why the same infinite loop cannot happen on AMD.
 It seems to me that it is also fixed by adding a check for re-entrancy
in ioapic_lazy_update_eoi.  It's easy to add one since
ioapic_lazy_update_eoi is called with the ioapic->lock taken.

Paolo

