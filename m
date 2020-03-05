Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CD7C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384B120637
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOWS+u5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgCEQnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:43:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39436 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgCEQnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583426588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I9DAtl+FSyCFHYDQsK2Du0TBkiXUFV5Bx439VCb735M=;
        b=DOWS+u5ECntN0+twRcEIDsyv/mqwuJy+PJ+IrxKEV1n/flHJChTe9kWVJWStljuJOwDZJe
        RTBAps2y8LEmDXbmHXVD1M3pb/+y3/mMclt97h0CHIGB3BXL1WHlcp4G4KLtxCfBVbGH+v
        K+CSAIM85rsCYA+TD7GbzrtNGQjiNc4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-092UltPZN9G7NekbN6qiFg-1; Thu, 05 Mar 2020 11:43:03 -0500
X-MC-Unique: 092UltPZN9G7NekbN6qiFg-1
Received: by mail-wr1-f69.google.com with SMTP id o9so2525396wrw.14
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 08:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I9DAtl+FSyCFHYDQsK2Du0TBkiXUFV5Bx439VCb735M=;
        b=YUTK9ZIaxK2z/v5SApZsIPym9ip1AMZf/dxNnDD9VzuNaGb0X9RHtSJif4Rtz53aV/
         d6yHp1qBAw207PEjO9JJKjH+Yiuoq9+dEdR6nj1ScPdxzCWpdwWtoJ+F4+F9pJHRV5b4
         +JVg3CaoKE/gL8xc26nbeHPXbTBXXEhiBrO9A89bzvRW0ytgV6u0XT58KOh7eJtyhO0R
         Ld9LSnvJkV7Jzox6si5s1lVjtlDfCbT/dQwJWuC/0SVpPLcqYnA+Fs/e1GAjIaViDrw6
         G2Lne8KOwlD4nF/VYkospwpf37t9LcTStLEbpOweEAHiACqiilQU85JJEbcVncBWOpuS
         nwHw==
X-Gm-Message-State: ANhLgQ0dWwUFQgZ+VBNRZIilMDtVK8WPbrENWide14gI+ySWpuQ2uVdM
        I/yYOpCzNZ1EtrLz6gpLTrtodQQqpAYA9Xz5aYLfw8IYO0fh3QZEBajTkiQLlTXtZUEZkhl5N4B
        JGxWuO7YajLxgxqTwfvuSAG4a
X-Received: by 2002:a5d:4004:: with SMTP id n4mr9624736wrp.48.1583426581723;
        Thu, 05 Mar 2020 08:43:01 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuczSqaBpycmHn4lDUE/pzvhjBs8yMsn8vI4F0+nvjWjdCvFBpk6DqMYK0U/zOcUaFc2Q1epA==
X-Received: by 2002:a5d:4004:: with SMTP id n4mr9624713wrp.48.1583426581431;
        Thu, 05 Mar 2020 08:43:01 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id t1sm49390231wrs.41.2020.03.05.08.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 08:43:00 -0800 (PST)
Subject: Re: [PATCH v2 0/7] KVM: x86: CPUID emulation and tracing fixes
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pu Wen <puwen@hygon.cn>
References: <20200305013437.8578-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6071310f-dd4b-6a6d-5578-7b6f72a9b1be@redhat.com>
Date:   Thu, 5 Mar 2020 17:42:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305013437.8578-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/20 02:34, Sean Christopherson wrote:
> 
> In theory, everything up to the refactoring is non-controversial, i.e. we
> can bikeshed the refactoring without delaying the bug fixes.

Even the refactoring itself is much less controversial.  I queued
everything, there's always time to unqueue.

Paolo

> v2:
>   - Use Jan's patch to fix the trace bug. [Everyone]
>   - Rework Hypervisor/Centaur handling so that only the Hypervisor
>     sub-ranges get the restrictive 0xffffff00 mask, and so that Centaur's
>     range only gets recognized when the guest vendor is Centaur. [Jim]
>   - Add the aforementioned bug fixes.
>   - Add a patch to do build time assertions on the vendor string, which
>     are hand coded u32s in the emulator (for direct comparison against
>     CPUID register output).
>   - Drop the patch to add CPUID.maxphyaddr emulator helper. [Paolo]
>   - Redo refactoring patches to land them after all the bug fixes
>     and to do the refactoring without any semantic changes in the
>     emulator.

