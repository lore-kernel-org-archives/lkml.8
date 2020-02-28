Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C90AC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F180E246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOpr2zYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgB1HET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 02:04:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32661 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726792AbgB1HET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 02:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582873458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wDK5v3JELBYbzScP70VagskcY+TULqJ1040U3p5KyU=;
        b=QOpr2zYFZPXUjuZCqGUN7GObhdyGOnJF1bOV+zqTpnmI1f3jgmDyiLXl1nKFmA0GvMJC4s
        a1KGZO0SietPUPyrOH2ykJdxkUQtKNtgetHTDTdIqC/AO5Hcok0ISs5NMXz+nfsQ2KHTzA
        UMUaaDNws+IeLlTePzF9trAnwQxbIM8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-OAayI6MaPQeQjt16J0fTrw-1; Fri, 28 Feb 2020 02:04:16 -0500
X-MC-Unique: OAayI6MaPQeQjt16J0fTrw-1
Received: by mail-wm1-f72.google.com with SMTP id w3so324987wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 23:04:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+wDK5v3JELBYbzScP70VagskcY+TULqJ1040U3p5KyU=;
        b=IMg7jdPA/X+NmmPpx+o9Zh9yUZtsXQ9ljKKjjJ8AqYrVX2wutwcbUMRwbWouTxethX
         Rp6aunM1S9DDeZ/YOyoe2/CmDYAlZJ1WQkdwPnoH5ZGDUImzfd1ywCjUR02ZU89khZ80
         oDGW/okSJyYAxEwCiPqzeI8nEcyXEtkiOoda3XCVzuW+A2UmZFMc+N/ge8cGtuuH0IXU
         WSeXrFfwulyKdX2RdqVWg52Sqmq8S2sfQPNiUnzZvs3gHr0xcmFMFTdLzaWxh4OnYwlB
         mi9YzTWHA8HE/NZTE/HGXm0wRRbxXzLILVXxMqntNHVnI+AJ1ZVBnqw6kargTqKYx6Vj
         5YjA==
X-Gm-Message-State: APjAAAWJ3Qn0wVFQrERhBoSPY+TUVQZ4IEpdWciIKoc5j1EXhIMrKxxr
        Bn6gQlJ3m37d91vTVcc70iUD60KPuGCipBPcQYuLc1j28kuePkUjXm+aQ3sbC53pRFZKD499q2G
        OZDcAhxnTeaDXibwASH6zIOHc
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr3281418wrq.396.1582873454829;
        Thu, 27 Feb 2020 23:04:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqzQVZ/7fZL2ZzN/bDi6zA7jOHNwrZ0h3OSN8bKNmZ3Le37bG23FEb+zNCXuFX3S311ukX0aLA==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr3281394wrq.396.1582873454605;
        Thu, 27 Feb 2020 23:04:14 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:30cb:d037:e500:2b47? ([2001:b07:6468:f312:30cb:d037:e500:2b47])
        by smtp.gmail.com with ESMTPSA id o18sm6214853wrv.60.2020.02.27.23.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 23:04:13 -0800 (PST)
Subject: Re: [PATCH 00/61] KVM: x86: Introduce KVM cpu caps
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
 <87wo8ak84x.fsf@vitty.brq.redhat.com>
 <a52b3d92-5df6-39bd-f3e7-2cdd4f3be6cb@redhat.com>
 <20200228013724.GD30452@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <67038178-623d-3e66-a0e4-f57610f2a5d5@redhat.com>
Date:   Fri, 28 Feb 2020 08:04:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228013724.GD30452@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/20 02:37, Sean Christopherson wrote:
>>> Would it be better or worse if we eliminate set_supported_cpuid() hook
>>> completely by doing an ugly hack like (completely untested):
>> Yes, it makes sense.
> Works for me, I'll tack it on.  I think my past self kept it because I was
> planning on using vmx_set_supported_cpuid() for SGX, which adds multiple
> sub-leafs, but I'm pretty sure I can squeeze them into kvm_cpu_caps with
> a few extra shenanigans.
> 

We can add it back for full CPUID leaves; it may even make sense to move
PT processing there (but not in this series).

Paolo

