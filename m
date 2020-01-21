Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC1CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE0D21569
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMp2OwuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgAUPKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:10:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57351 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727255AbgAUPKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579619435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLNqv137Ty3zBX/5Bsp+2Ypr44jpbB2i9ogizbwLSF8=;
        b=TMp2OwuSvAYOg/tnDm2ccl7Ypp0CIiMMcIiWT9xmq7CFUUy3rMVgG8H1JsNxMQg/Ku5zAv
        FI0FwCBuQ8/QwcKMJKbORIFcaP25ZB+JsOo1e1m8mKZURmQvtgNbDYz/Y3R1aBBCttcZO9
        WhaekUcbiM3dPQEh0yXHQL43V+z8pwQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-52uRSYRTMdaJ3r8S4HN-LA-1; Tue, 21 Jan 2020 10:10:33 -0500
X-MC-Unique: 52uRSYRTMdaJ3r8S4HN-LA-1
Received: by mail-wm1-f70.google.com with SMTP id p5so469053wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 07:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dLNqv137Ty3zBX/5Bsp+2Ypr44jpbB2i9ogizbwLSF8=;
        b=ljQ/8NH2Q5A+3PHbAZ+0QPVxFhgc+PVbpaA+4KW1I/g99+E4x5P/jw5hbjAGIfiO0b
         b9y0BZVe/6VLJhcgC3UNg/kseyFfOI4knQJRSJ4ImkYAbfbWnI5pElYgdBt0o+n4mqtG
         mL7wc6934GrqrfqROzyqaYuHDM+4m2yZmYWNn8b+77AiA2w2IPNGUrWQqpUjcQ0gzQSA
         KBIQnCCKObsHDxPOXFcL6ddTFiUriCOueAWeJFg5gnAvh4Gv6ciErZkWvfCWJjJJHcNo
         Xnw29g3T1mH+LSe6A5BOoV+WD8EJ06FvK4kwpyXSBtc6s/0T9nIqF65LlICXxi8DrdkL
         aMiw==
X-Gm-Message-State: APjAAAURL/niG2NjOBig0AbPUUnZIKWLhaLvt7m3cY4NerZwpaYnO+nX
        iXRibeqxNmZC+yhtAiREXCRO2DJuQsR+9EPuJepc0NC5fRVqANWrQkQ0b9nYmkGC428qiFZqXOn
        Dh7YOQxH2tR1QJ6bQ/me3s56C
X-Received: by 2002:a5d:484d:: with SMTP id n13mr5658181wrs.420.1579619431916;
        Tue, 21 Jan 2020 07:10:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxEyxfwVY/ROHiQo6nFEJMG0NaKySaBG+B/YnTEdUCo5yvn8VFW7mI2ukJg01QncMPDMI9zQ==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr5658133wrs.420.1579619431579;
        Tue, 21 Jan 2020 07:10:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id h2sm53828069wrv.66.2020.01.21.07.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 07:10:31 -0800 (PST)
Subject: Re: [PATCH 00/14] KVM: x86/mmu: Huge page fixes, cleanup, and DAX
To:     Barret Rhoden <brho@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        syzbot+c9d1fb51ac9d0d10c39d@syzkaller.appspotmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Zeng <jason.zeng@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
References: <20200108202448.9669-1-sean.j.christopherson@intel.com>
 <e3e12d17-32e4-84ad-94da-91095d999238@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d7d0801b-79be-a5e7-a376-abd92b5c09b2@redhat.com>
Date:   Tue, 21 Jan 2020 16:10:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <e3e12d17-32e4-84ad-94da-91095d999238@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/20 20:47, Barret Rhoden wrote:
> Hi -
> 
> On 1/8/20 3:24 PM, Sean Christopherson wrote:
>> This series is a mix of bug fixes, cleanup and new support in KVM's
>> handling of huge pages.  The series initially stemmed from a syzkaller
>> bug report[1], which is fixed by patch 02, "mm: thp: KVM: Explicitly
>> check for THP when populating secondary MMU".
>>
>> While investigating options for fixing the syzkaller bug, I realized KVM
>> could reuse the approach from Barret's series to enable huge pages for
>> DAX
>> mappings in KVM[2] for all types of huge mappings, i.e. walk the host
>> page
>> tables instead of querying metadata (patches 05 - 09).
> 
> Thanks, Sean.  I tested this patch series out, and it works for me.
> (Huge KVM mappings of a DAX file, etc.).

Queued, thanks.

Paolo

