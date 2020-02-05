Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6800DC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C66020674
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhVOemNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgBEQzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:55:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26062 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727081AbgBEQzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580921750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k4MVBpJvu2dSV+rRvdIP9GW4lozYekAvYZ8weTGnL0Q=;
        b=fhVOemNagBVBtA4h/IP3f1oQj+y4XfD9pHxkYHCOsW1sZw/cbkrJ2kmxiIpOHZElE5JLMH
        1z+/avqLelQUS63Yse38DJ2LEDSsgRCCJZZ68cjj2kCovvUXHm8IUokYVfnO7zdcqYi7nS
        t8ZN+iSt35GE5v5LsCgyw83XC/cCVlc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-KkjLULNKPCqVijrissAvhw-1; Wed, 05 Feb 2020 11:55:35 -0500
X-MC-Unique: KkjLULNKPCqVijrissAvhw-1
Received: by mail-wr1-f70.google.com with SMTP id x15so1456025wrl.15
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 08:55:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=k4MVBpJvu2dSV+rRvdIP9GW4lozYekAvYZ8weTGnL0Q=;
        b=egvlMHide380AKyjG2qSjhemKNwt5MXAzPbwx9cskwWgWZL9RmPVcFHobvPhjkhR29
         GN/o2X5Q85bhY4Am4trYqTgY3xokmwrypRQvjF6tk87BXl9O+3zwknJhd4MKfgnWR6z6
         uj182wtF0TEnAAtwzvQRwjx1cXGtNKLUi1Eb/QKeX+MukDy3HB9BlNpQSTcZ6WX+enRy
         PSYUE4de+6SiO9/UYeuYA2m8sH/roAMj935ywgmMoiuTHId2YPZVwk1Kk7vnRg3iRuL6
         l2OEDlq1BViX7un49q1FBgX3K6UnzOlLYVRTyJCya3iZQsG8hRUqB6FxwXrW2TeKnvd7
         d9+Q==
X-Gm-Message-State: APjAAAXwExf15ZOaxUknvNclnQ5mYfGINsHrfJJ68CUz3ySV26j6prOO
        NK7c51w13hgZHv8Fs4yaTPCoC1a8cdA+HoNnvG9t+u0t8UksCjMybYrqo0hgHA9+Xltr4logUzJ
        /sxyUvlS8qALWwC28xIbYBozL
X-Received: by 2002:a5d:5345:: with SMTP id t5mr31667145wrv.0.1580921734228;
        Wed, 05 Feb 2020 08:55:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqzQQGZFn8f+vjgX1oOiNfRFBunHlzYyc7eIL09p/fJ5XAIKuxHd5/z7XrQWRsaDossHo7DJAg==
X-Received: by 2002:a5d:5345:: with SMTP id t5mr31667128wrv.0.1580921734068;
        Wed, 05 Feb 2020 08:55:34 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 18sm209330wmf.1.2020.02.05.08.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 08:55:33 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 04/26] KVM: x86: Add a kvm_x86_ops hook to query virtualized MSR support
In-Reply-To: <20200205153508.GD4877@linux.intel.com>
References: <20200129234640.8147-1-sean.j.christopherson@intel.com> <20200129234640.8147-5-sean.j.christopherson@intel.com> <87eev9ksqy.fsf@vitty.brq.redhat.com> <20200205145923.GC4877@linux.intel.com> <8736bpkqif.fsf@vitty.brq.redhat.com> <20200205153508.GD4877@linux.intel.com>
Date:   Wed, 05 Feb 2020 17:55:32 +0100
Message-ID: <87tv45j7nf.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Wed, Feb 05, 2020 at 04:22:48PM +0100, Vitaly Kuznetsov wrote:
>> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>> 
>> > On Wed, Feb 05, 2020 at 03:34:29PM +0100, Vitaly Kuznetsov wrote:
>> >> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>> >> 
>> >> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> >
>> > Stooooooop!  Everything from this point on is obsoleted by kvm_cpu_caps!
>> >
>> 
>> Oops, this was only a week old series! Patches are rottening fast
>> nowadays!
>
> Sorry :-(
>
> I dug deeper into the CPUID crud after posting this series because I really
> didn't like the end result for vendor-specific leafs, and ended up coming
> up with (IMO) a much more elegant solution.
>
> https://lkml.kernel.org/r/20200201185218.24473-1-sean.j.christopherson@intel.com/
>
> or on patchwork
>
> https://patchwork.kernel.org/cover/11361361/
>

Thanks, I saw it. I tried applying it to kvm/next earlier today but
failed. Do you by any chance have a git branch somewhere? I'll try to
review it and test at least AMD stuff (if AMD people don't beat me to it
of course).

-- 
Vitaly

