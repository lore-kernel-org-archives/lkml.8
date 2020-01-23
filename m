Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906F8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6349A21835
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OgPUz7Lm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgAWQQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:16:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37895 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729009AbgAWQQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579796188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5sIIr88lSbFA0BlG1nNmj6Enx5IlWKEvDOlX33MYcGs=;
        b=OgPUz7LmUbGyz4fgdndoshzS2s2d6N4us8vnQsh3vRcHhV9t/iPw98bDJtsXQrDO11xrqA
        QybRvn1qZWWiyGpDsUfkamP4Hw0uCTa+AEnkuWJXwMC+L2tJNU1w6XGCEHRU5D3y8cnZ3H
        LluBH73yaxvF5vEoDQ7Ab8bX+wK9j/E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-IjOkF_JHNOaY2oyOgRjHow-1; Thu, 23 Jan 2020 11:16:24 -0500
X-MC-Unique: IjOkF_JHNOaY2oyOgRjHow-1
Received: by mail-wm1-f69.google.com with SMTP id m21so729437wmg.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 08:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5sIIr88lSbFA0BlG1nNmj6Enx5IlWKEvDOlX33MYcGs=;
        b=b8hFB7yd/VY34YSJH2gterawGT73pAxvxixe+IwbqNhzJtCwyqXcl5oG/m9v7gslL5
         Rav/lhZoVYTF8LPU5pNlLjiA/4OrKFAJEU0J5SEmGOih8ofQex532PutSd8ijOR6Zn1v
         BI4OG0729NvgJ6FzpABf7IPwqYWjfevVeb83/rfSB9yclG3pLjhZ4VacpgEGaLV9ppXm
         FwX2lvCMMw4/zUyuqJ9iR8LLTH9RNmApn9n9dY0LhgoWbarrxieDKeqiE4YnG5gJNNWj
         RRZyOGOhUmKYkypTd/2d9+RX4AjKdMzkvH14AjiLHy9O+j+aZHNRVfKxh6y5BCdu7YpS
         v4sA==
X-Gm-Message-State: APjAAAWrBn+CYVxMIvPLUVeFW3KICcFzsSp1u/gaInkxnD2c48RBnWsu
        AH3krvhS0n89JXzZ8a9xMQrxzds5QAgLi8PnZcEm1aZCY0ijl2xRKirmsU4d6zmLd2RUN1bOf+C
        Ql/BYqzC0gHdj46pWmewfHyp/
X-Received: by 2002:a1c:1b42:: with SMTP id b63mr2167997wmb.16.1579796182461;
        Thu, 23 Jan 2020 08:16:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxSF26kJs+JPMSG10GEDEcJjNLaTdakZx0Dm0y+GVghiwYl96TqI7gbcuuqv9s25ojTDMfPCg==
X-Received: by 2002:a1c:1b42:: with SMTP id b63mr2167981wmb.16.1579796182282;
        Thu, 23 Jan 2020 08:16:22 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id a9sm3117714wmm.15.2020.01.23.08.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 08:16:21 -0800 (PST)
Subject: Re: [RESEND] Atomic switch of MSR_IA32_UMWAIT_CONTROL
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Tao Xu <tao3.xu@intel.com>, Jingqi Liu <jingqi.liu@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200123154526.GC13178@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0146cafa-9713-59a7-00b7-87add0ab0738@redhat.com>
Date:   Thu, 23 Jan 2020 17:16:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200123154526.GC13178@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/20 16:45, Sean Christopherson wrote:
> cc'ing KVM and LKML this time...
> 
> Why does KVM use the atomic load/store lists to load MSR_IA32_UMWAIT_CONTROL
> on VM-Enter/VM-Exit?  Unless the host kernel is doing UWMAIT, which it
> really shouldn't and AFAICT doesn't, isn't it better to use the shared MSR
> mechanism to load the host value only when returning to userspace, and
> reload the guest value on demand?
> 

To clarify, laziness also on part of the reviewer, aka me.

Paolo

