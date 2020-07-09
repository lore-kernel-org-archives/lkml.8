Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE2BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B712B20775
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wyrzt0tU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGISlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:41:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60090 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726286AbgGISlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594320093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yrog4kNVLv14gHPE6cxcCNEgoYv6zXzH5cGxxa/OAZY=;
        b=Wyrzt0tUqozVIa2CMVljA1Msv7L9e/lj2tkyY2gLNODZaIMr81Y282Nompv0G30TanhFls
        xKRsbRp6CY+4TaogyM9qmqSGCSHeGn3QXagIZnBY1+LDlHzxvEUWI0UYL9QB6q3MvdCNIa
        7Ou4p0+Yb+8nFZNAi9RNcfoUxMIHLIM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-WoxtECebP0iF_TNIEcUWAQ-1; Thu, 09 Jul 2020 14:41:32 -0400
X-MC-Unique: WoxtECebP0iF_TNIEcUWAQ-1
Received: by mail-wm1-f72.google.com with SMTP id l5so3042037wml.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yrog4kNVLv14gHPE6cxcCNEgoYv6zXzH5cGxxa/OAZY=;
        b=MmRwXMz44hMKxKH3i2XWF6PNbBuax5AN8bUgGv5eqKa5V4A3NT+onrEWupF40kPjJ+
         kKZTb45NpvpiIn0+c1fjKBZG9g8j/TuWmEJMfIyJY4bPFpukuJtD7D/fV2x5ARTAAt5Q
         3Srsyr74OZ41S8CriQLp+/YThR+W0Go6jXkNdGQkJm6mIf6MNvbWHjShyKzryZq3nuCe
         KENLyiKR1Y2E+r3fTqMGfb78hpS0mINJ6c8GfRTurRiFHHbs96JIpnxUxkkgTQss9lDY
         pxhl5/kNzxHTk1amYuEWbFBc85P+l9hEpqCcZWNyTWCeGb13cIp3wbKSPNCOMAMg5LsP
         Rtiw==
X-Gm-Message-State: AOAM530okbJ9lblL3TaP0BYR8+Vl/48Wz6XqGuEeaH3l9wVhuZhsyXRx
        I7LnjWXvuOEZBq7GWT9hbLDk5EvooYWOUht40DG17ZUg4rKGGTs/SNUDw+hzKsUblwldtZAFzuA
        Q47oelTPWx/D0fitNX7T4cowx
X-Received: by 2002:a5d:68c7:: with SMTP id p7mr68029852wrw.16.1594320090378;
        Thu, 09 Jul 2020 11:41:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5YRD9Q0mxA3lflFoAyXPxrfqh8BMKXlV8oRf/72ycXWIrO5lzKOihwddGLNRG15BuHyZlcg==
X-Received: by 2002:a5d:68c7:: with SMTP id p7mr68029833wrw.16.1594320090103;
        Thu, 09 Jul 2020 11:41:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id j15sm6523281wrx.69.2020.07.09.11.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 11:41:29 -0700 (PDT)
Subject: Re: [PATCH] KVM: nSVM: vmentry ignores EFER.LMA and possibly
 RFLAGS.VM
To:     Jim Mattson <jmattson@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20200709095525.907771-1-pbonzini@redhat.com>
 <CALMp9eREY4e7kb22CxReNV83HwR7D_tBkn2i5LUbGLGe_yw5nQ@mail.gmail.com>
 <782fdf92-38f8-c081-9796-5344ab3050d5@redhat.com>
 <CALMp9eRSvdx+UHggLbvFPms3Li2KY-RjZhjGjcQ3=GbSB1YyyA@mail.gmail.com>
 <717a1b5d-1bf3-5f72-147a-faccd4611b87@redhat.com>
 <CALMp9eThSjLY92-WURobbJBHRKLxGuYPLBWMnq+=FxxYHquTiw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a341f7ca-4739-db84-74e0-27859bba9eeb@redhat.com>
Date:   Thu, 9 Jul 2020 20:41:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eThSjLY92-WURobbJBHRKLxGuYPLBWMnq+=FxxYHquTiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/20 20:40, Jim Mattson wrote:
> On Thu, Jul 9, 2020 at 11:31 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 09/07/20 20:28, Jim Mattson wrote:
>>>> That said, the VMCB here is guest memory and it can change under our
>>>> feet between nested_vmcb_checks and nested_prepare_vmcb_save.  Copying
>>>> the whole save area is overkill, but we probably should copy at least
>>>> EFER/CR0/CR3/CR4 in a struct at the beginning of nested_svm_vmrun; this
>>>> way there'd be no TOC/TOU issues between nested_vmcb_checks and
>>>> nested_svm_vmrun.  This would also make it easier to reuse the checks in
>>>> svm_set_nested_state.  Maybe Maxim can look at it while I'm on vacation,
>>>> as he's eager to do more nSVM stuff. :D
>>>
>>> I fear that nested SVM is rife with TOCTTOU issues.
>>
>> I am pretty sure about that, actually. :)
>>
>> Another possibility to stomp them in a more efficient manner could be to
>> rely on the dirty flags, and use them to set up an in-memory copy of the
>> VMCB.
> 
> That sounds like a great idea! Is Maxim going to look into that?
> 

Now he is!

Paolo

