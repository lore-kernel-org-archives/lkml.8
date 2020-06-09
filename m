Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805E1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B4502067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591742845;
	bh=pe6fHYYLQMMgw4xRZemQiVdy/SOkcKorikbp9w/qyhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0jxbZ/+ClOL+Jx7R/6k4Jg7zYjUuhmEgYYojpHXd7qmYnvCNm9ndclMuTSCtclQBC
	 27bLNJMXP8mRqT7L15gA+QWDCLZSjiUSvBxSrJxR4p5EbS9Wd1Q4p9LG5EpC3aWZeJ
	 AFT3lLYJuck4JhRPJK7E2d4z6Tf9SdURyzVYfU4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgFIWrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:47:21 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:33108 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgFIWrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:47:19 -0400
Received: by mail-il1-f194.google.com with SMTP id z2so105676ilq.0;
        Tue, 09 Jun 2020 15:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NfEOBWG4bfCTzsmuuXO6TDc1+wX47eGNPT7jG0QcyfA=;
        b=KmIZsqIX+xP/Bjr36cg0C72Q0mzw5Sncilt+IlQEgl7QFhz6wuTZwHsKcSsA3YyZtw
         BoKBpZC9ay5WPwNr3Fi0k32Pg+TjzJf7md51nyE/2bov2VRb+O9N4OQV7SXwHpclrSWA
         waRk6iQl9FzI8YCGg83BaDGDRlTTfLQ45+3yov166mMXRbAoxaMYRrRqACHbSn+s7oWy
         PqZAvopAYMGyaGcA81MdEJ3Bkd6rJlFpzl4LBZtoAh62bjcD2SpN0US7JykiNRgHrdML
         pHZN5tQGUdCUzWCU31Trr2DIPhTgUF/ctthH/174UlVMKUQW6wzIa+ivXG9jP28rANBm
         6Q6g==
X-Gm-Message-State: AOAM530hMR9RnbZXk8kPz2Bf6Ehtm5ioQrHLu83rdB5ZV/e0fj0noH5P
        Kpx6S2RIs0iVOFb3OJYCeg==
X-Google-Smtp-Source: ABdhPJw4TjhCLUC3JtF2gFwOM9IISGo+ofbNQgZdzsGMcolwz4Zwq/ktiVssfj1x7zDBsW5xmWFO6w==
X-Received: by 2002:a92:4810:: with SMTP id v16mr274790ila.75.1591742838798;
        Tue, 09 Jun 2020 15:47:18 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id b13sm9835891ilq.20.2020.06.09.15.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:47:17 -0700 (PDT)
Received: (nullmailer pid 1646943 invoked by uid 1000);
        Tue, 09 Jun 2020 22:47:16 -0000
Date:   Tue, 9 Jun 2020 16:47:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-clk@vger.kernel.org, kernel@collabora.com, heiko@sntech.de,
        mturquette@baylibre.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: clocks: rk3288: add rk3288w
 compatible
Message-ID: <20200609224716.GA1646913@bogus>
References: <20200602080644.11333-1-mylene.josserand@collabora.com>
 <20200602080644.11333-3-mylene.josserand@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200602080644.11333-3-mylene.josserand@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jun 2020 10:06:44 +0200, Mylène Josserand wrote:
> Add the possible compatible "rockchip,rk3288w-cru" that handles
> the difference between the rk3288 and the new revision rk3288w.
> 
> This compatible will be added by bootloaders.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@collabora.com>
> ---
>  .../devicetree/bindings/clock/rockchip,rk3288-cru.txt     | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
