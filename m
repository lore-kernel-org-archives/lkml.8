Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE93C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981DE246A3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Unb+r7E+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgB0SAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:00:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22947 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726805AbgB0SAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:00:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582826438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B1a+jNTb4Orz5c9qxW8szumduw/KGeqpv62VeNode+w=;
        b=Unb+r7E+Mm9gZnfZxfuwRFHtoqGhCHCRhsue5jjjJ8CsimX03HATy3Tq6sSiljiJTj4hY9
        3DtNDB8pmkhvzSs0BZov53v9sc6AaONy73PIQNxQ4Ryg8JzJs7CwMRJw+mUKyDos95YmgL
        flCpjFBkTJc6yQ3sk+3NeeXgSrfYUAQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-t0uidZAxOLylW34OIusRoA-1; Thu, 27 Feb 2020 13:00:37 -0500
X-MC-Unique: t0uidZAxOLylW34OIusRoA-1
Received: by mail-wm1-f71.google.com with SMTP id x9so69306wmc.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:00:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B1a+jNTb4Orz5c9qxW8szumduw/KGeqpv62VeNode+w=;
        b=qNzKzlIf1LwCUcFp4KwtGUEbmUwOH/LgoCgl6dOnOrn62uyFbjWuPwP6WuesNyOQxK
         2FVCri0/sKFJuzY6N2BUe5FxT9DNhSzpsTLgIev8yLxyx8Rz8clX6vx3CTTJ4dKqQxBt
         FSwp9QNMMTib6fncbMHzXmzxdzB5Xm5zM+c0SZ15Ba3NJJubgGfyNdOz45BsBt8YR3kr
         nGA37WeIV1BuYZZY2cWzUyYbtccD9UBURvkAhbSEBbnUR+E+77sQ+cMz6Bw53+y9BUKS
         XLOxf1I490bL5STXN/4JNLYUYgg7m4W7qpXez9pOhuocA5yhu56nckQHYip++pymF2eY
         ksgA==
X-Gm-Message-State: APjAAAVm7qlRjYqIiy69z8f2oyWMt58nt0IVc+qP2Wn9poiITsFVDDlJ
        FwV25pfECGinMYgFFaH7OJ+WK4qkSFXoKltBXiKkatibKY9gOinzHcHVwpg+0o0TTnIHuPH+WFw
        Bz02sAA1eSa3CcbuUxLFjWeCO
X-Received: by 2002:adf:e506:: with SMTP id j6mr34517wrm.309.1582826435242;
        Thu, 27 Feb 2020 10:00:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxEXgel+e/Cr10Eg2mSUgtpkv3oomTVYQQ91dnsRyuh9Zrri6FyoSRaQfd8YKoTsQFnJzluA==
X-Received: by 2002:adf:e506:: with SMTP id j6mr34495wrm.309.1582826435009;
        Thu, 27 Feb 2020 10:00:35 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:30cb:d037:e500:2b47? ([2001:b07:6468:f312:30cb:d037:e500:2b47])
        by smtp.gmail.com with ESMTPSA id p26sm8207428wmc.24.2020.02.27.10.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 10:00:34 -0800 (PST)
Subject: Re: [PATCH 5/5] KVM: x86: mmu: Add guest physical address check in
 translate_gpa()
To:     Mohammed Gamal <mgamal@redhat.com>, kvm@vger.kernel.org
Cc:     sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        linux-kernel@vger.kernel.org
References: <20200227172306.21426-1-mgamal@redhat.com>
 <20200227172306.21426-6-mgamal@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f81e0503-bc35-d682-4440-68b81c10784f@redhat.com>
Date:   Thu, 27 Feb 2020 19:00:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227172306.21426-6-mgamal@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/20 18:23, Mohammed Gamal wrote:
> In case of running a guest with 4-level page tables on a 5-level page
> table host, it might happen that a guest might have a physical address
> with reserved bits set, but the host won't see that and trap it.
> 
> Hence, we need to check page faults' physical addresses against the guest's
> maximum physical memory and if it's exceeded, we need to add
> the PFERR_RSVD_MASK bits to the PF's error code.

You can just set it to PFERR_RSVD_MASK | PFERR_PRESENT_MASK (no need to
use an "|") and return UNMAPPED_GBA.  But I would have thought that this
is not needed and the

                if (unlikely(FNAME(is_rsvd_bits_set)(mmu, pte, walker->level))) {
                        errcode = PFERR_RSVD_MASK | PFERR_PRESENT_MASK;
                        goto error;
                }

code would have catch the reserved bits.

> Also make sure the error code isn't overwritten by the page table walker.

Returning UNMAPPED_GVA would remove that as well.

I'm not sure this patch is enough however.  For a usermode access with
"!pte.u pte.40" for example you should be getting:

- a #PF with PRESENT|USER error code on a machine with physical address
width >=41; in this case you don't get an EPT violation or misconfig.

- a #PF with RSVD error code on a machine with physical address with <41.

You can enable verbose mode in access.c to see if this case is being generated,
and if so debug it.

The solution for this would be to trap page faults and do a page table
walk (with vcpu->arch.walk_mmu->gva_to_gpa) to find the correct error
code.

Paolo

