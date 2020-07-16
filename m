Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA49C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790B1206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="bSlzrRXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgGPH1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgGPH1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:27:37 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6283C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:27:36 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c11so2744951lfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zPDRGSa50UmakAcCbGtdk+EyDTkt0fVgobaBWRA0X/4=;
        b=bSlzrRXjpKRPCl0hArlSuL0p66sGr+eTsxLNyQvOi9YB3Pjk9vOPe3d2OKG1DF9kPx
         CO1KN2bjOhfUZyk8ZcgsRvcgfv0U7EsODKgUnUNrNtPVPeZzh5rVBDJhJQdj+NNK9W9r
         EVVxv1Lg7/nWWVm0ZOr5n3C7KA0Kd3OUnIRJUxHNPBWUAmD9prbOFiGk59RkD/TGLLuP
         BwvwKl6n9rATW+k54GyLtBkxC7XcSaJ2FGF8E+P3XlSzhtmzZBw4imaG6E9McesxzIE6
         NVw58/IU//Ud31i+CqWs2uIvj9TqdunDiIzaNTbZykEZsRuWxlHFwBDiOefTpTAqXbeo
         +Dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zPDRGSa50UmakAcCbGtdk+EyDTkt0fVgobaBWRA0X/4=;
        b=hYADWWzRGofwOGN2WqOEEbsJcAtgTH5TCSsrkhEmHIBjA6mso+RZAptBz3c//fX61u
         WysC0D/2qg70OD/U3IBF//700IA6G3GSG9pKNRpiM/gMoUlwgkXlcXVRaO7fzm8hGXBJ
         307Tfw1a19FEiBSJ86+AF9BOXbMiJrJvEk6ONhYGewpHFMIIgUaa0sSYM9FSWXY3QNhX
         E1UPcKJM8By4tGISnu9tlyjmGb1ktKYUlld+hbRw/Hb0dwWjqki8A7T+Ima8NdyN3UgT
         I3KwVdcJ+Sg6Yf7E8PV8GxMjO2BadE6P+TW7iYcitpeqHawU+PuK0EPSBT2EuUGHF+aE
         wQkQ==
X-Gm-Message-State: AOAM533cby0AB52dGF+joRz6zcecxAr2znksJceo5JIZO/i1xPyfPKXL
        7atiHPvSRWOxnYLg4SVfA7eo3Q==
X-Google-Smtp-Source: ABdhPJzjgZSJHNOCVeLAWUGQMY4lBBLhOUXjm/PaVTPymlG/+KgEIckwdogSmLzxx8u074kW6hfL1A==
X-Received: by 2002:a19:8407:: with SMTP id g7mr1444144lfd.61.1594884455131;
        Thu, 16 Jul 2020 00:27:35 -0700 (PDT)
Received: from [192.168.1.9] ([83.68.95.66])
        by smtp.googlemail.com with ESMTPSA id v19sm1000788lfi.65.2020.07.16.00.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 00:27:34 -0700 (PDT)
Subject: Re: [PATCH v4 3/4] dt-bindings: arm-smmu: add compatible string for
 Marvell Armada-AP806 SMMU-500
To:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        joro@8bytes.org, gregory.clement@bootlin.com, robh+dt@kernel.org,
        hannah@marvell.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        nadavh@marvell.com, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com
References: <20200715070649.18733-1-tn@semihalf.com>
 <20200715070649.18733-4-tn@semihalf.com>
 <7147e4ae-30e2-5a2f-7fb0-4027e9adc94c@arm.com>
From:   Tomasz Nowicki <tn@semihalf.com>
Message-ID: <282a8963-c2c2-c68d-e77e-28da18096d71@semihalf.com>
Date:   Thu, 16 Jul 2020 09:27:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7147e4ae-30e2-5a2f-7fb0-4027e9adc94c@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.2020 12:36, Robin Murphy wrote:
> On 2020-07-15 08:06, Tomasz Nowicki wrote:
>> Add specific compatible string for Marvell usage due to errata of
>> accessing 64bits registers of ARM SMMU, in AP806.
>>
>> AP806 SoC uses the generic ARM-MMU500, and there's no specific
>> implementation of Marvell, this compatible is used for errata only.
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> Presumably Will can pick up these first 3 patches for 5.9 and #4 can go 
> via arm-soc.

Thanks Robin for review and valuable comments.

Tomasz
