Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E30C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5B4246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFqy5aQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgB1HDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 02:03:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26767 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726407AbgB1HDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 02:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582873421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OV9TVzYiK7fy5Df/XLhzIPFheh7WMpe9u5ayB8vjOrA=;
        b=EFqy5aQgOO4eQ3VP6zo/ox1e+0rHqtydSIfXAsfGGDn7TLA9SeClXCOmZAieCyKu2otCKT
        Xb52B522b6fwlV6kYhEesISxOt9jrm4uHQaCtelEZAfHDrD5qKjlDicZgra5pA5BFWrNYX
        M2/rRGRVFewQW1fRru77Sn3rfIeb7ao=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-07-M9m4AMySQ1pxhtpzO5w-1; Fri, 28 Feb 2020 02:03:39 -0500
X-MC-Unique: 07-M9m4AMySQ1pxhtpzO5w-1
Received: by mail-wr1-f69.google.com with SMTP id y28so913751wrd.23
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 23:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OV9TVzYiK7fy5Df/XLhzIPFheh7WMpe9u5ayB8vjOrA=;
        b=HPIw/kTAzgpkRTdwDomWVa5yCCnpkFetFNQpupG/9vNc61Zf5PydOLdR90054NH1nO
         OkO/WvZ1trq30KcmuEw8ZVPGGR18tk2i2AymwaPldh51wGOiWg1Bty+DbQVo3NOObPSO
         Q2J3SU/stnAtIFyH4RYdP9W3LNJehDrC7QhW1+zhQS0LGi2yY7EpsmRMqclNMx259SyH
         L0R9hB6Gce6dHjsSsMhO8Lkawt/34g9rgFtzG5xqcKlKW9810B3flIG5TaIlWbRGgcSD
         Rp0/CpGZocyubfKiHbcQInA/nbvdOURsg3P39/TL5usftKL8D7jZTWsZFu061UAIi8j6
         eN6A==
X-Gm-Message-State: APjAAAXgQoN8xcpIC/urMwm+W8BEad/y1JY9fuNt/7TpOZvyTlsyBBQm
        DDbkiIHIMv5Iggr+H/As+FGELZCiRn+IzbUq8wwMwuU2N86E36hUqPfRkS1E9oOQWHGLU+iNfcA
        I4LDv+7dBcQ/lS6nFU4RccvLi
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr3233338wru.127.1582873418474;
        Thu, 27 Feb 2020 23:03:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqztcbbkyVtgEGOtL0OapteA9GCHua/jgQhBMowijROGhgz2+TEXljndEJ+I7KchOoasqdeR1w==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr3233315wru.127.1582873418240;
        Thu, 27 Feb 2020 23:03:38 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:30cb:d037:e500:2b47? ([2001:b07:6468:f312:30cb:d037:e500:2b47])
        by smtp.gmail.com with ESMTPSA id b82sm834482wmb.16.2020.02.27.23.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 23:03:37 -0800 (PST)
Subject: Re: [PATCH 39/61] KVM: SVM: Convert feature updates from CPUID to KVM
 cpu caps
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
 <20200201185218.24473-40-sean.j.christopherson@intel.com>
 <0f21b023-000d-9d78-b9b4-b9d377840385@redhat.com>
 <20200228002833.GB30452@linux.intel.com>
 <20200228003613.GC30452@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <052d2bdf-d2da-36c0-2fb5-563b5bf5f2ed@redhat.com>
Date:   Fri, 28 Feb 2020 08:03:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228003613.GC30452@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/20 01:36, Sean Christopherson wrote:
> Regarding NRIPS, the original commit added the "Support next_rip if host
> supports it" comment, but I can't tell is "host supports" means "supported
> in hardware" or "supported by KVM".  In other words, should I make the cap
> dependent "nrips" or leave it as is?
> 

The "nrips" parameter came later.  For VMX we generally remove guest
capabilities if the corresponding parameter is on, so it's a good idea
to do the same for SVM.

Paolo

