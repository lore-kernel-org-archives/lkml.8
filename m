Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73497C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 13:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F23D2071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 13:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUNLV25q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgDYNTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 09:19:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28975 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726060AbgDYNTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 09:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587820770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZURiLBETOzpWxA+m+Ly+zcrAkCfuj4ARVrSBfsuIAdg=;
        b=dUNLV25qYQXn5GRNAZJUuT0wBn5WdiFx4vknSkgb8ubRBPFbSV1C76wwMU2xh7f/rm7Fh+
        vio3d3xSLO8HJW32bOUI9vnM9ctqIg2SBRHiMrmiluXIXhNg8+3VQ/olQY3tVMYUgb3zJS
        LorlUJavV/ycQDqtSKqQBAP7w8xaKhY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-WkiLUkXUPJCf9Iq7Z2YeZw-1; Sat, 25 Apr 2020 09:19:28 -0400
X-MC-Unique: WkiLUkXUPJCf9Iq7Z2YeZw-1
Received: by mail-wm1-f72.google.com with SMTP id 14so5825734wmo.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 06:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZURiLBETOzpWxA+m+Ly+zcrAkCfuj4ARVrSBfsuIAdg=;
        b=mLmiZSbtmAyVdNUdrlXF0eqHfeBEVi3D9106+FKC6avbbsUq8U6FgfxjFCiIZz75ib
         ndBinPPCmhgRhQBYsT6YQolST+TCQzuvW36TmwuD8JQmQyTuTARRyNTD5rbl5YTc01o2
         HxGI+WuhFmg84Bqc0RoxebISvCK0/RtJtBoCfYjyGuEqaY1870TOzShFgqj8IVblChw+
         sATtb+q0zxACgto/alSuw9Y2yfw/Ki/56ohlW13hNNz3EyfxQJYV45wBwJp2DaHwWSG6
         dRUd4MoU8u+eOCwZqQFyomjJcG1AwFv+RCLTNreZS+qlNEUf92LLWQuqPcHybqVEKTsZ
         4hVQ==
X-Gm-Message-State: AGi0PuZYL7XnbtK1krugeSunv52gldvd01yzIZcrbW4oLyADRg372pSn
        Yl2xJdc1BVFEGjm3GnqoWzLt8pzLEvtnvfQuD+8xbaml4wCeNUiLjE9hnjyFOlIEi5VX0kaBMFu
        a//dEs/8SFjaUK7h+KV65WMgw
X-Received: by 2002:a7b:c642:: with SMTP id q2mr16619781wmk.41.1587820766823;
        Sat, 25 Apr 2020 06:19:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypJXwcuRtpHk4zpLOp3jvcBubezJLdQBQ3UTl4H8+n7Honsj/U58BP1wRrfhHGtK6n55KUIt+Q==
X-Received: by 2002:a7b:c642:: with SMTP id q2mr16619766wmk.41.1587820766602;
        Sat, 25 Apr 2020 06:19:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d0a0:f143:e9e4:2926? ([2001:b07:6468:f312:d0a0:f143:e9e4:2926])
        by smtp.gmail.com with ESMTPSA id a125sm7153885wme.3.2020.04.25.06.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 06:19:26 -0700 (PDT)
Subject: Re: [PATCH v11 5/9] KVM: X86: Refresh CPUID once guest XSS MSR
 changes
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmattson@google.com, yu.c.zhang@linux.intel.com
References: <20200326081847.5870-1-weijiang.yang@intel.com>
 <20200326081847.5870-6-weijiang.yang@intel.com>
 <20200423173450.GJ17824@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6e1076a5-edbf-e8fe-dd99-fbb92f3cc8d0@redhat.com>
Date:   Sat, 25 Apr 2020 15:19:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200423173450.GJ17824@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/20 19:34, Sean Christopherson wrote:
>>  	if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
>>  		supported_xss = 0;
>> +	else
>> +		supported_xss = host_xss & KVM_SUPPORTED_XSS;
> Silly nit: I'd prefer to invert the check, e.g.
> 
> 	if (kvm_cpu_cap_has(X86_FEATURE_XSAVES))
> 		supported_xss = host_xss & KVM_SUPPORTED_XSS;
> 	else
> 		supported_xss = 0;
> 

Also a nit: Linux coding style should be

	supported_xss = 0;
	if (kvm_cpu_cap_has(X86_FEATURE_XSAVES))
		supported_xss = host_xss & KVM_SUPPORTED_XSS;

Paolo

