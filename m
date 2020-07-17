Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A57C43445
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A178220737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIK+O5YR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgGQQ6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgGQQ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:58:14 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9135C0619D2;
        Fri, 17 Jul 2020 09:58:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u5so5693588pfn.7;
        Fri, 17 Jul 2020 09:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kTW/vU9qPmPKn2Z7Y8y2u+6RPfS4JOq4IXRD9sDOkEw=;
        b=LIK+O5YRTH0+YYmEybGySPOV6j9XxXLC2+aJMdoS3bJoRVQRmPZc6Ciuuz5qhYFdaA
         AloS0c51m8IaynD02KZhF/YxFkcPhhkes7bGhxZIJBUUUOK4IbcRqSkyjdRI7waNnJSu
         ApaTIgiQXRw6M/HeIC7qk2MBkMWKBz2UvnQwb7ddxeiDi30tAydeg30G/luARMn0Ct23
         LIKnvppASD4cnGAB32kuzfGPq7byC39/nIC1+oc+Os81eULlOH2vUh21KXAf+UI+HnEL
         8iPzbQwbrENJ2E4N2fCyTcQAaDOlWBY5cHutIarjA01i2vQGXoRHyk675VKVElJhyRkd
         3sMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kTW/vU9qPmPKn2Z7Y8y2u+6RPfS4JOq4IXRD9sDOkEw=;
        b=F/utBM5MkzAYCXNUbPoXdKHrWe63bybyeER2pJ3D+TnlayqxgSGAZF06SG0oJ7VQdP
         TIc78MNbW75KuJ+F2pA9/VCEnLJxNLzgag8NgomJhViGS0/dHzKVh9f5REOf4YT2wYFt
         BPbNknoMnnR/F7XA2FHitIgjN7+PhgU9ketYtSAgYhFcnntA+cYNihw81RXv5qQ+PJKh
         cGnNdrtBrNp5JLW8Uml6GD4P9VQhjMDYY68Bt4e3Qbne2Ioqbyr+3kidrZWduZYFuE0/
         wRCb1rjsFFmUEuIXwDKZZsbN3V65MzkRDFnoMj/m4zJ073IkYpnuQ77Lvic/Rf81OQMH
         M1WQ==
X-Gm-Message-State: AOAM5332ii+T1Kyd8HAtn/Tg7nUJkwhX7nIMjZ1xQxLFOShDHIdEURBb
        HdE/FiApEOYV7+UpVcK5ZlVGwmfZ
X-Google-Smtp-Source: ABdhPJwp7YuDLAAWTOjsYPSUf0PF6prjtKgs0M5K4Sme12+cjSJrvh9vOQiH7T7JcxLNJCMirMGGnA==
X-Received: by 2002:aa7:8f2a:: with SMTP id y10mr8517075pfr.182.1595005093463;
        Fri, 17 Jul 2020 09:58:13 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s14sm2475872pjl.14.2020.07.17.09.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 09:58:12 -0700 (PDT)
Subject: Re: [PATCH 5/7] usb: bdc: driver runs out of buffer descriptors on
 large ADB transfers
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
References: <20200717152307.36705-1-alcooperx@gmail.com>
 <20200717152307.36705-6-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5bc7603c-0e1f-762f-0d67-1c817c03c5ca@gmail.com>
Date:   Fri, 17 Jul 2020 09:58:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717152307.36705-6-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/2020 8:23 AM, Al Cooper wrote:
> Version v1.0.40 of the Android host ADB software increased maximum
> transfer sizes from 256K to 1M. Since the STB ADB gadget driver
> requests only 16K at a time, the BDC driver ran out of buffer
> descriptors (BDs) if the queuing happens faster than the incoming
> 16K transfers. This issue is fixed by doubling the number of BDs
> that can be queued so that the entire 1M request can be queued
> without running out of buffers.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

You can certainly remove my SoB here, since you are carrying your own
patch, thanks!
-- 
Florian
