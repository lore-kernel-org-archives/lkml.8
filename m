Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A081C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A007206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rfeS1Uw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgFVKUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 06:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgFVKUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:20:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE91EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:20:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so16030558wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K1WHdNmDOX4BgFR//IfTLKehGJqrVesoSzoLydKqUHI=;
        b=rfeS1Uw1taWTRr/Gdwzfa6fudxK3gOylCvzERoZh1LAyDoT0O140GcXF/e7MRNtajq
         TewuP/PkZb6EC7OwWRUnw8dQxV0sOAP/6KM2moncHL1bnUWyJTr8H7oWsqAPi6va35V5
         UnjwUNrokqE66FBwwmX4FpsSoSyH2VLSmVxNVO9zSzb+KLCaRPuwo2LSI+6gkr2jO25I
         dpFzJz0MS7ZPrZNfY+z4mvucVmiO9xHNhHPTZxD4zXDYspek63rfwrnneDRWR9ngbdCq
         2Mxo/BU4atCUa5f5+EaFwoMj/AbhFN3tTTrAgBYhmYt49EiHyRunOWpRFh3Qgd0TG6OD
         /7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K1WHdNmDOX4BgFR//IfTLKehGJqrVesoSzoLydKqUHI=;
        b=KNDwZlxUA99WeGjMnYhC+OYJZ+kGJ3TRUATRTtJL1VGpiDClVlBZEa3izr1TmyxBfn
         +HWz9e+5KOeTpVtMPH9e8ilTTDCJ+Qv/KaktQSb+ltrs3eQixNvNEvhGR5sLM18HyvKS
         jrI9IAHygRXKUNTyzYPBVGSWY2xb9lRBiG1kT8+Jxf7VyTwsNUmTg+zpUvo2RdwknrXJ
         QJJFl1btJgbmis23ESDMh0fcx9ko6XH690GDWvzLsjdp4htZfPImrieBALhtCc2866fT
         tWGzxpCMzDnpDaMEln3gM8kwzQ+gLg6AaUSUO2JXN9sfMEhniFPLAG7iu96lx1kHdpZK
         mRCw==
X-Gm-Message-State: AOAM533n9sgojWvIfzbmy6UbQxrrpUemHIxvh+LeUTX9LJflDSdCDkBY
        Fca4J/Q5NlhWPO0Y0u0sQ1tirg==
X-Google-Smtp-Source: ABdhPJxa46K/Mbvsrk+5fxMUoe4KQE4DGTtB9HnW10GAVrdSftQMvPpwxbTt0fQruBPFR0WjoekYug==
X-Received: by 2002:adf:f542:: with SMTP id j2mr3995338wrp.61.1592821243187;
        Mon, 22 Jun 2020 03:20:43 -0700 (PDT)
Received: from google.com ([2a01:4b00:8523:2d03:49d8:6d83:2bcd:21c9])
        by smtp.gmail.com with ESMTPSA id j41sm18213045wre.12.2020.06.22.03.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 03:20:42 -0700 (PDT)
Date:   Mon, 22 Jun 2020 11:20:41 +0100
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com
Subject: Re: [PATCH v3 05/15] arm64: kvm: Build hyp-entry.S separately for
 VHE/nVHE
Message-ID: <20200622102041.myve2otyoj5q7j5s@google.com>
References: <20200618122537.9625-1-dbrazdil@google.com>
 <20200618122537.9625-6-dbrazdil@google.com>
 <5029f8fb4a7816e11de7469c09347c79@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5029f8fb4a7816e11de7469c09347c79@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> > -	void *dst = lm_alias(__bp_harden_hyp_vecs + slot * SZ_2K);
> > +	char *vec = has_vhe() ? __bp_harden_hyp_vecs
> > +			      : kvm_nvhe_sym(__bp_harden_hyp_vecs);
> 
> If we get this construct often, then something that abstracts
> the uggliness of the symbol duality would be nice...

Agreed, I do hope that this will end up being limited to finding the address of
the hyp-init vector once EL2 becomes self-contained. Even this vector selection
can be done in EL2 where the symbol duality does not exist.
If we were to hide it, there is a trade off between code "elegance" and clarity
of what's happening under the hood. I was thinking we could extract this
`has_vhe() ? foo : __kvm_nvhe_foo` as a `#define foo` but I do worry that
anybody debugging this code would be cursing my name. It would also not work
with other macros that take symbol names, notably kvm_ksym_ref. But that can be
rewritten to accept a pointer instead. The more verbose but less magic approach
is to have a bunch of different helpers for various situations, eg.
__pa_symbol_nvhe. What would be your preference?

-David
