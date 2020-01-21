Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679B0C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 13:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3354022314
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 13:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMPp1uqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgAUNvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 08:51:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48406 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728708AbgAUNvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 08:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579614710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z+thaj6fraaz5u5SaFmzmpY7g+fCANo2RPX6WMKeeTI=;
        b=ZMPp1uqtgTQth73vjAEIqAHmizbUZ+LewsWKm5rR+WSoiohLmj/GRK/Q9cbz2+pJub7DAO
        mVyROobwefLAuYdjRsNGL9T+nZh7iLotL0B0Lb+Qd4slXHQZEstVow7AjnCiYL9DzuORzS
        O6nIdRGnD5P1obmPUQkhKrlg+CtYNG0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-9F5BZdGhNkqLNiP0zckk1A-1; Tue, 21 Jan 2020 08:51:49 -0500
X-MC-Unique: 9F5BZdGhNkqLNiP0zckk1A-1
Received: by mail-wr1-f72.google.com with SMTP id h30so1340176wrh.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 05:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z+thaj6fraaz5u5SaFmzmpY7g+fCANo2RPX6WMKeeTI=;
        b=JsE7xanH1ekOFBDKYuz7KRtIZjLlnn2rlOwWos/frU4Aue8+Yh01+Mm2lcDakeNH0J
         LBaN9FVFOh6YhY+9KL6xdt7cl/zud283WWE0ekA1PjzngSszHZsWHjZz7PrdFcV1/L+S
         tXAAYp/Q4OsBI0Il0wV104ZrSCNCx57XjMgjvdyjsD16dp0LPQTM8ntYsCfFx7B2Ouzs
         hqGm7OZtcs0ekS91UV+KHos5+sT6vZ9Ei+Lw88BJ5YT8LjAIrkcElXtv65DKsW792oFH
         a+BkYKrueM7Z8hgdTg4u6i3T8zCrk+KjvK21kYiNnGFDmbqjJbllf+5e9ikpvsQFHGSR
         bmxA==
X-Gm-Message-State: APjAAAXjcGOGdhhVb0seKou5bRY3ruBFsq5ce1jb6p13dBc+zErtuRxl
        6mp/Rp2GLm3LyHia98D3vIm6sCr9+syBVSsVrwjSye4EzdSobDO3u5O+fADnGr0m+9+LfiWVkc0
        F1WyscZLU6IVsjfPkC7YxL5Tw
X-Received: by 2002:a1c:9602:: with SMTP id y2mr4430222wmd.23.1579614708118;
        Tue, 21 Jan 2020 05:51:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqzUB73EGquW6vCktv8qGYr2Nk6qQyraAwTN0+HO2LIZ8PeFcJM3D2gQr9or8mDGO1aiJknCuw==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr4430206wmd.23.1579614707814;
        Tue, 21 Jan 2020 05:51:47 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id q3sm53733831wrn.33.2020.01.21.05.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 05:51:47 -0800 (PST)
Subject: Re: [PATCH 0/3] KVM: Clean up guest/host cache read/write code
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Andrew Honig <ahonig@google.com>,
        Barret Rhoden <brho@google.com>
References: <20200109235620.6536-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <50f1d58a-5ac8-be1f-9c31-a49e699f362b@redhat.com>
Date:   Tue, 21 Jan 2020 14:51:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200109235620.6536-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/20 00:56, Sean Christopherson wrote:
> Minor cleanup to fix the underlying crustiness that led to an uninitialized
> variable warning reported by Barret.
> 
> The first two patches are tagged with Fixes:, but I don't know that they're
> actually worth backporting to stable.  Functionally, everthing works, it's
> just a bit weird and AFAICT not what is intended.  It might be preferable
> to take Barret's patch[*] first and only mark that for stable, as it fixes
> the immediate issue without revamping __kvm_gfn_to_hva_cache_init().
> 
> [*] https://lkml.kernel.org/r/20200109195855.17353-1-brho@google.com
> 
> Sean Christopherson (3):
>   KVM: Check for a bad hva before dropping into the ghc slow path
>   KVM: Clean up __kvm_gfn_to_hva_cache_init() and its callers
>   KVM: Return immediately if __kvm_gfn_to_hva_cache_init() fails
> 
>  virt/kvm/kvm_main.c | 45 ++++++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
> 

Queued, thanks.

Paolo

