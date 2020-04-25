Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E9EC55191
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C35F420714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+kFM2j3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgDYTQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 15:16:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45726 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726192AbgDYTQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 15:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587842180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ajW83cPmwSdOeR1VWQQEGhPP3tbajGWXOutPh+OWcCo=;
        b=i+kFM2j3jroUZG966cGab2G+Af9Lbb1eRiGwqdV423AqZr6u7dbXC5HuZW+Vvdq7dre9wv
        l3Z3ptdnmcotu5j3skPfbXc+sK0Q+3Fm0XWrflzTPnwRU5xuWDe6e/Zzivcy3iqYARem1e
        ZEY/OpmyhWWuqiRavFSu2lc/NwzTYls=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-83oaVsqPPwi9icNyi1a7Ow-1; Sat, 25 Apr 2020 15:16:18 -0400
X-MC-Unique: 83oaVsqPPwi9icNyi1a7Ow-1
Received: by mail-wm1-f69.google.com with SMTP id f81so6389025wmf.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 12:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ajW83cPmwSdOeR1VWQQEGhPP3tbajGWXOutPh+OWcCo=;
        b=ohjdL5iNiF2Gm+Dj2aS/66LtunwV/KAAg171pfxGU95pDTJWiUrfsDRKPsr8DTa5dk
         NzG1ycz/nA0lYrRyTM4x3e/KHPkvwHEkY3qTMfVl58AtmBJq9vJqGJTqP8Xad3sb4Mkv
         bah3zwx3KanCrPr0Q2gL2pT5fIKllo1XjBLZTVQG41HdvIyVkBizjLlHCxZ++POQpumU
         GhTJG9mN7ObKmBFPYjGwpdR9vKL2uXKF2PAgJ7ZizIPvyEc464DMLOms4QL92V4BQLZb
         MwzFE0PHi0N4ZiJNjB5PyIixwCai/aeZAMqT7BVUJ4R+XKKEj9G8byOp40T7QrgMxKYl
         fG2A==
X-Gm-Message-State: AGi0PuZ/6cyc17uGpnKA5r0QbCO/GAS1pvHoI4tAyPRCCKNkaw1wTHyb
        k4o+b2MEyVzzK5Az9LPRsx9rMG4zJ8xHD9Xq0JTRMUT0PV3wjA77nHBTx7cttiJw7bOFmeaQEUm
        vrytMOmx1wo12ueiZbGeUKF4j
X-Received: by 2002:a5d:5001:: with SMTP id e1mr18996367wrt.27.1587842177344;
        Sat, 25 Apr 2020 12:16:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypIslrnrTCUpVt5mn/A0rA0ebcrzDNEHzKVQ09XyEpYeCTU1+Fo5jDEho79nKUV/iuLclvvUMA==
X-Received: by 2002:a5d:5001:: with SMTP id e1mr18996358wrt.27.1587842177133;
        Sat, 25 Apr 2020 12:16:17 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id p6sm13751690wrt.3.2020.04.25.12.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 12:16:16 -0700 (PDT)
Subject: Re: [RFC PATCH 1/3] kvm: x86: Rename KVM_DEBUGREG_RELOAD to
 KVM_DEBUGREG_NEED_RELOAD
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm <kvm@vger.kernel.org>, Nadav Amit <namit@cs.technion.ac.il>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20200416101509.73526-1-xiaoyao.li@intel.com>
 <20200416101509.73526-2-xiaoyao.li@intel.com>
 <85cb5946-2109-28a0-578d-bed31d1b8298@redhat.com>
 <08C6D1FB-A4F7-49FA-AC46-5323C104840A@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8223a7e2-5d4a-b427-c44f-d76450f16748@redhat.com>
Date:   Sat, 25 Apr 2020 21:16:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <08C6D1FB-A4F7-49FA-AC46-5323C104840A@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/20 18:54, Nadav Amit wrote:
>> I wonder if KVM_DEBUGREG_RELOAD is needed at all.  It should be easy to
>> write selftests for it, using the testcase in commit message
>> 172b2386ed16 and the information in commit ae561edeb421.
> I must be missing something, since I did not follow this thread and other
> KVM changes very closely.
> 
> Yet, for the record, I added KVM_DEBUGREG_RELOAD due to real experienced
> issues that I had while running Intel’s fuzzing tests on KVM: IIRC, the DRs
> were not reloaded after an INIT event that clears them.

Indeed, but the code has changed since then and I'm not sure it is still
needed.

> Personally, I would prefer that a test for that, if added, would be added
> to KVM-unit-tests, based on Liran’s INIT test. This would allow to confirm
> bare-metal behaves as the VM.

Yes, that would be good as well of course.

Paolo

