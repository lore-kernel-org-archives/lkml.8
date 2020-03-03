Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AFEC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F54E20838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhVcgt2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgCCOeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:34:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28780 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729126AbgCCOeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583246053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cAECegmA0wMswJz0VGyHZTs27RHr8iBmN3HXQbf5sSI=;
        b=GhVcgt2IpbCVY47JbYVbrz/2ij2UH/IuhvBKnO5BF+MZHD4beP0vvP1M3c4zcUbYw8PiZn
        YQ5PcmqrYt6INcuSCs5/TNDVthm2oni7IysoraZdx8LXqvoaZFxhv7w5CQPLuo+1vsBvTi
        RbKjU0etsxV3VCASWInvV4owxjDLCLY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-vZS7zRPkNaGcXOhDSdC_5g-1; Tue, 03 Mar 2020 09:34:11 -0500
X-MC-Unique: vZS7zRPkNaGcXOhDSdC_5g-1
Received: by mail-wm1-f71.google.com with SMTP id f207so1162110wme.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 06:34:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cAECegmA0wMswJz0VGyHZTs27RHr8iBmN3HXQbf5sSI=;
        b=PjUNTX5d4e4s8gAXPtJB4PGT+JaPd76ciUBqyLr3AYU8Otx0i6dsBBtUkZc1GcLQ7Z
         gCdJeDd1MqJgj+CIJGdpjlbEGrW8so8YKEwY6N/so4K9tFyixXyzvHnzJdoSuIpewsFe
         UHbXMzuRraZi780PRpgG54wIpFAAUrSrh2B2YY+3ALvpWsReZivV+k/33z67MDi0JhRL
         Qsr5p0DFEWDj/+meKCpxiGOLDs9D1nhrpZAZagustbAlpU+S/qCsLF6aSl/QkdbaXGhP
         3Ii2wYvH6aL1JWbEMsPEwkxpJ0s+ii21N5nL8Kz9h2hOxinyeoLPEF7ElO0zEq5va1vk
         eteg==
X-Gm-Message-State: ANhLgQ0najc2s+nZFi2JjGwZRkliSmoAvv580ZuqB8pNyGlSp+RIpEuW
        z9xlnsgYmFmPBckN5E4IfXcUhp1IedS/JPt1PKGcNE1l+umoEMTF4M/O1LOXzVusodmatcAY96c
        TX1Vkyg0bIR2Ox026oUimDBcL
X-Received: by 2002:a1c:2d86:: with SMTP id t128mr1310631wmt.38.1583246050152;
        Tue, 03 Mar 2020 06:34:10 -0800 (PST)
X-Google-Smtp-Source: ADFU+vs4Xhhl22Q6UveZHccZdqz7Hiv0gpABcJv3zhrPJc3f3VR/4ZTJvCmJCVZWGmA8KaX2/Dcm/g==
X-Received: by 2002:a1c:2d86:: with SMTP id t128mr1310615wmt.38.1583246049954;
        Tue, 03 Mar 2020 06:34:09 -0800 (PST)
Received: from [192.168.178.40] ([151.20.254.94])
        by smtp.gmail.com with ESMTPSA id t133sm4741832wmf.31.2020.03.03.06.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 06:34:09 -0800 (PST)
Subject: Re: [PATCH v2 21/66] KVM: x86: Use supported_xcr0 to detect MPX
 support
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200302235709.27467-1-sean.j.christopherson@intel.com>
 <20200302235709.27467-22-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c2faf73b-56e4-a398-430d-ad6f0afed6e4@redhat.com>
Date:   Tue, 3 Mar 2020 15:34:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302235709.27467-22-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 00:56, Sean Christopherson wrote:
>  
>  bool kvm_mpx_supported(void)
>  {
> -	return ((host_xcr0 & (XFEATURE_MASK_BNDREGS | XFEATURE_MASK_BNDCSR))
> -		 && kvm_x86_ops->mpx_supported());
> +	return supported_xcr0 & (XFEATURE_MASK_BNDREGS | XFEATURE_MASK_BNDCSR);
>  }

Better check that both bits are set.

Paolo

