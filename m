Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A982C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CC42073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579609099;
	bh=Yyd+FLIHbRrh3jsQMDM0yDT3z9LFpjQTJAsHQj5LPOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L/ta85CFMgzcgfT0bqhudd/3uDpX4IhyNe5g3JYi4A7/o1ols7+K7ICb2IaX803By
	 DcMDjpUEHYDCcDwDbtjqnUNURaPT4XgOX/OwrU9V13gBEml//74md6lMqsCrtsAQH1
	 tv3Ev9tVI9gclldjdhTkECpeMJ4rIekpgA7Yw920=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgAUMSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:18:18 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:38283 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgAUMSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:18:17 -0500
Received: by mail-ed1-f54.google.com with SMTP id i16so2753183edr.5;
        Tue, 21 Jan 2020 04:18:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SnG0TTyxgyt1zcjYn/1DgFM/Ap/My5QEMUd9Nz/FdQc=;
        b=sXugVgZSjxSRARRjYDNsgNbTVBDzCJHTRryWUR68wPzT/Hebga8QIvg7mel+hsckDY
         yfkZBnpK6DFr+jlAasf2zXFyAuLfoYsCO3rClv88iw9f7CWLlAVNVSvThZExy0aLO20C
         RJ5gyj9/Ki4Ma45+OVtyqcQyWX/NtqSOXoMAmqjtXc3m8HC8V/FriefXZ8hHGphj4R5A
         vG4fMvdj0RBvxk13dqInbZIo5/mQEB2BPtrin3j1gIatwM3dN9pfLWPhgybtNSbhnJmP
         sfNlJJTyEIo65X7gQi7gwbrZRrKPfF8hnp9qiukhoNwkGIUM/T5r+oIFbyoEcujXO7sk
         ntsg==
X-Gm-Message-State: APjAAAWjTxCEtlFgpSZFMEijTI4sIK+1OUBJx0y6GVD8571aoRkTkhvO
        P7d08wYGLKokcjuyVd5OQaEswWod
X-Google-Smtp-Source: APXvYqxx2iaNPGTqZVW60KypS1ijtsKo2jYdA4u8I5swXCGUf+ubu04YZWD3F/ALLpq/zWxVztK/dg==
X-Received: by 2002:a17:906:4d87:: with SMTP id s7mr3940129eju.221.1579609095691;
        Tue, 21 Jan 2020 04:18:15 -0800 (PST)
Received: from pi3 ([194.230.155.229])
        by smtp.googlemail.com with ESMTPSA id n24sm1375491edr.30.2020.01.21.04.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 04:18:15 -0800 (PST)
Date:   Tue, 21 Jan 2020 13:18:13 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2] ARM: dts: exynos: Add GPU thermal zone cooling maps
 for Odroid XU3/XU4/HC1
Message-ID: <20200121121813.GA25629@pi3>
References: <CGME20200121070520eucas1p29587eed877efcf6e6b9433440f3c10da@eucas1p2.samsung.com>
 <20200121070510.31520-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121070510.31520-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 08:05:10AM +0100, Marek Szyprowski wrote:
> Add trip points and cooling maps for GPU thermal zone for Odroid
> XU3/XU4/HC1 boards. Trip points are based on the CPU thermal zone for the
> those boards.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2:
> - removed polling-delay related properties for HC1 as requested by Krzysztof
> --

Thanks, it looks good. It is however too late in the cycle and I will
not be sending one more dts pull (probably only one mach/soc). I'll
apply it after merge window.

Best regards,
Krzysztof

