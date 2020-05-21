Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABDBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDACC20671
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVfvBYL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgEUIk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 04:40:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51182 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728688AbgEUIk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 04:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590050426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dOW7B8nLICvI2QSpCheBsPrgf3sHzyca7R6p70npClk=;
        b=PVfvBYL3IvPrWAu7uE4r2EPHM2Hs6B3n7fODfLQoJpcd/xO1y25CvKblu/ipyTOuX8XSN+
        7JuhtzgX1FWgzjT34wA/AxCHKTbrReqvWI3HNeAPTB8vbaDZ8Pil33J8k4hlDnY9fOCpZf
        xLam97TB4CzBlVYopVnFESRge9NznuQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-Ul_2ZY9wPPOZwDNe8oNJIg-1; Thu, 21 May 2020 04:40:24 -0400
X-MC-Unique: Ul_2ZY9wPPOZwDNe8oNJIg-1
Received: by mail-wm1-f71.google.com with SMTP id g10so2441775wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 01:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dOW7B8nLICvI2QSpCheBsPrgf3sHzyca7R6p70npClk=;
        b=i/Q3T/Wd/Frp1mTXPpu8szPZhAbxBmyf9WUSyIreXDBQ9Jhsw3+7kYI+t3WREvMVK1
         IS7lkG1tCybjBP/YxXhLImqXx6DUR1uJpI3oSKLK0w1p1m8UMmrewtCeQaxvdnh06iPh
         cBWGPBMb3SFelWGuKm/2ipbp52Pc096mmosySvw4S113k/EVEr7+xg4vspkjukfZz97+
         OUbWgc774kfj2wM1oQxZdFq/RrG276PxmFlXTWPTjnkwnBbSGxbJ8L1fV99ePiH3S4Au
         Hnvi82kmysYzX6hBBX7ZzNn1ztBMnhszKVKGaf4xDML5Dpsj9zngMREy7Wtot8Tg7Peh
         nybw==
X-Gm-Message-State: AOAM532apkAK9NFQntReKJeeeg4SlEZz+s8eKai/Zd1KXri4TwZJ3RXS
        iBRRai9KZ+5vV1a3EAFlKk+L5S4DZRO/uWm9O4MlofxlN70UMkQII2gryb63abMxwGUnGBJyZkk
        AQ7//l0rbVn+vsBDPXWEqr6J4
X-Received: by 2002:a7b:c193:: with SMTP id y19mr7935733wmi.158.1590050422639;
        Thu, 21 May 2020 01:40:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxukfKVUk2qDd/EsYglDEd1qglHM6q51pYRYREmlhXPiE9KQzqCcOX8bFxDroTR47/pAlGPuw==
X-Received: by 2002:a7b:c193:: with SMTP id y19mr7935709wmi.158.1590050422401;
        Thu, 21 May 2020 01:40:22 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
        by smtp.gmail.com with ESMTPSA id x18sm5169145wru.72.2020.05.21.01.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 01:40:21 -0700 (PDT)
Subject: Re: [PATCH 2/2] kvm/x86: don't expose MSR_IA32_UMWAIT_CONTROL
 unconditionally
To:     Tao Xu <tao3.xu@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200520160740.6144-1-mlevitsk@redhat.com>
 <20200520160740.6144-3-mlevitsk@redhat.com>
 <b8ca9ea1-2958-3ab4-2e86-2edbee1ca9d9@redhat.com>
 <81228a0e-7797-4f34-3d6d-5b0550c10a8f@intel.com>
 <c1cbcfe4-07a1-a166-afaf-251cc0319aad@intel.com>
 <ad6c9663-2d9d-cfbd-f10d-5745731488fa@intel.com>
 <6c99b807-fe67-23b5-3332-b7200bf5d639@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3642373d-8d1d-de80-d3db-e835a8f29449@redhat.com>
Date:   Thu, 21 May 2020 10:40:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6c99b807-fe67-23b5-3332-b7200bf5d639@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/20 08:44, Tao Xu wrote:
> 
> I am sorry, I mean:
> By default, we don't expose WAITPKG to guest. For QEMU, we can use
> "-overcommit cpu-pm=on" to use WAITPKG.

But UMONITOR, UMWAIT and TPAUSE are not NOPs on older processors (which
I should have checked before committing your patch, I admit).  So you
have broken "-cpu host -overcommit cpu-pm=on" on any processor that
doesn't have WAITPKG.  I'll send a patch.

Paolo

