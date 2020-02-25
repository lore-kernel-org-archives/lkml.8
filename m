Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7F3C35E03
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451AD2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlOGuQog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbgBYOiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:38:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43216 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729436AbgBYOiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582641481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MMkMT41Ew2lYqvAVHcg6d6gwui9XO+kqAXnNWxZsaWg=;
        b=IlOGuQog9ugE2VFCWoeE9KLBaYPUD2OLVDbau4+wnivQXPJVqNDYEVvnv6iIXTdnpUK4Bo
        ftk0iTi6T3gfzbvAv3HljCLcg4ZPjW/hFX1JkP91SNxlTt3jI2HW4iq6NuP52jR/voYAZ5
        yVetSB3IV7iRdJ56fmtWgbCdRxz+Cpo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-7Bnc-p4yPsegAvsMrcQulA-1; Tue, 25 Feb 2020 09:37:59 -0500
X-MC-Unique: 7Bnc-p4yPsegAvsMrcQulA-1
Received: by mail-wm1-f71.google.com with SMTP id u11so1116121wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 06:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MMkMT41Ew2lYqvAVHcg6d6gwui9XO+kqAXnNWxZsaWg=;
        b=GWxSq9GMs4BYYUjOtqnIi1ayRIDU3qzlRCpwG8RpjgBzXZpZZhayO326HBSoAkRuPN
         ZKy1QfCr5e7d1M7ym2VzrqntQqMS1xGCswR15CX8SRmYGHWCq7BLdyGTRLJb9DUgFdUh
         I+M6anXy03VKwvLhuGglHV7xnAJLrkRwHPMziaFhNUGegY7LYDpZC3olQGGSB3C2pzIm
         /l1Nsl4suayB74R18Rpyt+2bbLkTfbp99RjS1FkNyIMPAi5eNpux5q5P6cCC9ias4+qh
         6uLPtZECGOG+O1zY6WfOujNZr3FEcRkXNxHEcWLrCcAhm5B1MaJBavBgkHHh/tUHgAaB
         n7Dg==
X-Gm-Message-State: APjAAAWRCvNA+IDUJ3a15+VsNeV4WXyJn32luFPi0J2Q2yBLINExd4g0
        Z+Dzi2V4lu5qnqostrIcbBjj0AAY0OzrlHydLiWIuBw1vERZ2jp1Umz4IjPjOWaaQTvUGUaDvi4
        KJt0FPMrXNcjTgThBlJV/ak6N
X-Received: by 2002:a5d:674d:: with SMTP id l13mr72035867wrw.11.1582641477572;
        Tue, 25 Feb 2020 06:37:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqyb1N/WwmYJ6393LEGUUxwEctjfX/NmXku6SX1zknILjB/nDw9XsgbBJwAP0GuDgbhVG0nT+g==
X-Received: by 2002:a5d:674d:: with SMTP id l13mr72035852wrw.11.1582641477374;
        Tue, 25 Feb 2020 06:37:57 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3577:1cfe:d98a:5fb6? ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
        by smtp.gmail.com with ESMTPSA id p12sm24467412wrx.10.2020.02.25.06.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 06:37:56 -0800 (PST)
Subject: Re: [PATCH 02/61] KVM: x86: Refactor loop around do_cpuid_func() to
 separate helper
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
 <20200201185218.24473-3-sean.j.christopherson@intel.com>
 <87sgjng3ru.fsf@vitty.brq.redhat.com> <20200207195301.GM2401@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <04fb4fe9-017a-dcbb-6f18-0f6fd970bc99@redhat.com>
Date:   Tue, 25 Feb 2020 15:37:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207195301.GM2401@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/20 20:53, Sean Christopherson wrote:
> 
>> 2) Return -EINVAL instead.
> I agree that it _should_ be -EINVAL, but I just don't think it's worth
> the possibility of breaking (stupid) userspace that was doing something
> like:
> 
> 	for (i = 0; i < max_cpuid_size; i++) {
> 		cpuid.nent = i;
> 
> 		r = ioctl(fd, KVM_GET_SUPPORTED_CPUID, &cpuid);
> 		if (!r || r != -E2BIG)
> 			break;
> 	}
> 

Apart from the stupidity of the above case, why would it be EINVAL?

I can do the change to drop the initializer when applying.

Paolo

