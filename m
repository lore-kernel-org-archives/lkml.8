Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263E9C35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1FB21556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHZQOumw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgBYIuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:50:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47004 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729648AbgBYIuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582620631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PfzRSAhNpMIZNUliXJZ4oDUC0c3OWA7vYT/+v41x+3I=;
        b=aHZQOumwRxv9Hx/pVbQiIO8xaK3V3oWDASYgEsuPqrx+PJqVSxBbn/hHGTAij3KbDw88/U
        v7v3Q8fHh44IOF5yCrJ4dI/aUPUeZO7EOqXnAbfEAFYkE+BCjEvFmCZe4559eKQiiZr9jB
        Iy6FvDrvUgNFZifokv6JHxsZngP8YE4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-JmYFYLL8NQibHprXLYOJ_w-1; Tue, 25 Feb 2020 03:50:29 -0500
X-MC-Unique: JmYFYLL8NQibHprXLYOJ_w-1
Received: by mail-wm1-f72.google.com with SMTP id t17so772104wmi.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 00:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PfzRSAhNpMIZNUliXJZ4oDUC0c3OWA7vYT/+v41x+3I=;
        b=o5ww0fdnZp7DbF/coUKMA2KF7kWq7QMOM+hho0BVCrPKeqmM/kKpZ4RKurMks+t6qV
         dDmIhEcPpAOUtxav8RiYunnSjfvUmBVHzs9HLsw9XP7SDKX788Nn9TynOLL+A9fLZ1D+
         +pFGnehlFniNiEyqvXV8GZZ9FIamqpDHZq327eQ+wE/Ygiej0a8nvC4a/YEccxXpQqk6
         6B8Y58XNsSZTBD3VRCyouyKPi7yCoWEubTYkYTtQRcm2FkMh/BgFI8RIrsGOUZpgyMxz
         9GrsY5vllLjR989db2Fv1M0hG1xOGw25UfKggp5LWEyqQTMwX/diI/yAAg2GHKFIwhHk
         EKyw==
X-Gm-Message-State: APjAAAXDxTkIfnCMHfe2W9ypFiAXl5Gv+MGPX8y6Xu7b+sPevdgLlL4A
        voSS4FzyjYZjQMFjv2Tfbhv3q2Z86/5CiXIqag6QBlMHog/b9DuVCep4PJVmif1QWaI135OqY4L
        jOLst0TGwWq/7BxVsr8DvSnbu
X-Received: by 2002:a05:600c:21c6:: with SMTP id x6mr4012143wmj.177.1582620628150;
        Tue, 25 Feb 2020 00:50:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqzBcE5aPvjcBl0lbyqVeaRSSFw5z6sebEMNIGS0xDSLjtady1JxoFmhPyD4kYKlkklPdJTbpw==
X-Received: by 2002:a05:600c:21c6:: with SMTP id x6mr4012119wmj.177.1582620627901;
        Tue, 25 Feb 2020 00:50:27 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3577:1cfe:d98a:5fb6? ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
        by smtp.gmail.com with ESMTPSA id p5sm22492743wrt.79.2020.02.25.00.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 00:50:27 -0800 (PST)
Subject: Re: [PATCH] KVM: LAPIC: Recalculate apic map in batch
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1582022829-27032-1-git-send-email-wanpengli@tencent.com>
 <87zhdg84n6.fsf@vitty.brq.redhat.com>
 <CANRm+Cyx+J+YK8FzFBV8LRNPeCaXPc93vjFdpA0D_hA+wrpywQ@mail.gmail.com>
 <f433ff7e-72de-e2fd-5b71-a9ac92769c03@redhat.com>
 <CANRm+CwfaZHHPyxC1qz_uq6ayw6vg2n0apLPoPH5dKXyy4FLeg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <629c37b6-2589-9073-369c-7026ebf13a51@redhat.com>
Date:   Tue, 25 Feb 2020 09:50:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CANRm+CwfaZHHPyxC1qz_uq6ayw6vg2n0apLPoPH5dKXyy4FLeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/20 09:31, Wanpeng Li wrote:
> On Tue, 25 Feb 2020 at 16:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 19/02/20 01:47, Wanpeng Li wrote:
>>>> An alternative idea: instead of making every caller return bool and
>>>> every call site handle the result (once) just add a
>>>> KVM_REQ_APIC_MAP_RECALC flag or a boolean flag to struct kvm. I
>>>> understand it may not be that easy as it sounds as we may be conunting
>>>> on valid mapping somewhere before we actually get to handiling
>>> Yes.
>>>
>>>> KVM_REQ_APIC_MAP_RECALC but we may preserve *some*
>>>> recalculate_apic_map() calls (and make it reset KVM_REQ_APIC_MAP_RECALC).
>>> Paolo, keep the caller return bool or add a booleen flag to struct
>>> kvm, what do you think?
>>
>> A third possibility: add an apic_map field to struct kvm_lapic, so that
>> you don't have to add bool return values everywhere.
> 
> This apic_map field is boolean, right?

Right, and the name should really be apic_map_dirty.

Paolo

