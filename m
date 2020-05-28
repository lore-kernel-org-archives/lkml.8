Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F278C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D321720707
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590709841;
	bh=iDPrL02dnKL16M8KLeiFs9v928pA9zB+mtmjuSWm2cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DxfcnryM525F18/Un70UamJj155LesnidtAsL7S2sXpFP4Uksye6SPRrvdDLSCRee
	 ItSThgF6HfyGrsLrBGHPsV77ILHjRNCLt81qdy4Q/8uFvGi+4RIVzpFc8LbAM7hoPt
	 9t3DqATKJKCTENVlXQYF2B5jaC4qoJuRcYIpDeS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437831AbgE1Xuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:50:40 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:45799 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437820AbgE1Xu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:50:28 -0400
Received: by mail-il1-f196.google.com with SMTP id 9so698623ilg.12;
        Thu, 28 May 2020 16:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2qJyG0GFuzoWv8bxaOoVXs4zVLMpWwiclg2dMSlRSiA=;
        b=Z/6k25Hpg4DE+QROerZXlkq8CHBvrtvucmUOs8pAgt9igpuYOvC1fyBHCN9UMEAJYy
         5Am81ZpPZQls89KxlzlqrV1BRqttztT628DVwgyACHuqHhgb6aUEjkYjNXHx1FD4PwdM
         42363iDKq9ABEQrFkxWBaXL4v6fr1miSz2smStfplc230KzDx8WDYSFjpvGKEtPHC3de
         c/MXJhnCrWKek8b5Td0xvD227pJtrQu9pLys3pnQF6zrC/+2RQv/RtO83nvO94KMAop8
         ZOkcE001SfSeQPFrqvEKAXq3DlsCGyQMAKOMfxYqWCtvykxVnVTPW2gDnON6CUHpShcN
         tXHw==
X-Gm-Message-State: AOAM532S2ClQ7kBK1ifjZhpAEPw52NWaYYvfqBl9aQYGnBgJ7zB6h2TD
        a0T+p+0unwJKaK23POmLLg==
X-Google-Smtp-Source: ABdhPJy/fymDNPaBLeg8iuyl7WPp2P1JP7ye0QdzXAMYnnMfUAKyg8ZzrB3TvlVTBv/KbOx2mJi/qA==
X-Received: by 2002:a92:9f12:: with SMTP id u18mr5160160ili.287.1590709826961;
        Thu, 28 May 2020 16:50:26 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y15sm3906169ila.13.2020.05.28.16.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 16:50:26 -0700 (PDT)
Received: (nullmailer pid 915140 invoked by uid 1000);
        Thu, 28 May 2020 23:50:25 -0000
Date:   Thu, 28 May 2020 17:50:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] dt-bindings: irq: Add a compatible for the H3
 R_INTC
Message-ID: <20200528235025.GA914475@bogus>
References: <20200525041302.51213-1-samuel@sholland.org>
 <20200525041302.51213-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525041302.51213-4-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 May 2020 23:12:56 -0500, Samuel Holland wrote:
> The Allwinner H3 SoC contains an R_INTC that is, as far as we know,
> compatible with the R_INTC present in other sun8i/sun50i SoCs starting
> with the A31. Since the R_INTC hardware is undocumented, introduce a new
> compatible for the R_INTC variant in this SoC, in case there turns out
> to be some difference.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../allwinner,sun7i-a20-sc-nmi.yaml                  | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
