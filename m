Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA6BC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB1A621973
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588367547;
	bh=KWp0J4wZ1NfpDdRIgntT71EisxWb1b6nucrlHY8SmqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PdtogqNetzJj4YHT06OPFuVxXDp/1WLzbNwW0e6ewH1sCXUMljXG56kNP/F/n0d+c
	 tNydogDoCqiv/Z5ePD8pM5Bhy7CHHdTQs8HE716j8T6PwWqC7N5yaq+lxnpP0ct6hd
	 TsyGmp3qv3PGJIa66ENeFRFFdiAM4bhIgCJ5IzMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgEAVM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:12:27 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:41630 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAVM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:12:26 -0400
Received: by mail-oo1-f66.google.com with SMTP id t3so1002970oou.8;
        Fri, 01 May 2020 14:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=neD/3SOtF63yPlH47C0TH4isewUnsErPWNSdocH1b/Y=;
        b=aiuzP5qOH6d70OLi4Luin5mjAw/76DNBRjlpbGbHSIDK/beuAmKc49S2MgDVd0Ubwy
         YzpitNqtX6jpXc4kZ9MvgGg/+HJhg6Q49/KIyua+iNqlOv21ERQQIJL1o0HrMtpzjoSV
         Y2X78GZ8wGoBaWZQMkPh7a4wtdQ3yRSHNcBKnM3P8e1WqQ2qxd/daRXFl33Zl8ZGBWt6
         ETcYORcqdLnR+66JLKMlOZY6vjQGOAeWFysGjlhn7/hF2Uxf7rSqi6NILR5k/d99UzC8
         i99Jo/0ZFCXaEZzlXlzSaF+T5zeL5KAoUd6UBrd50FyMrF/YY6LbNYm0IUe9v3fNmgzC
         7CWg==
X-Gm-Message-State: AGi0PuYvok34ntZBqtE+ZJdXRg7htYjjCZly07pS7Ye7TjT+ekr+Bzsq
        802j37ByPVGz8vvJcNTHjQ==
X-Google-Smtp-Source: APiQypKGhKxUyl+qsvUosFPfbz8Np364y+bmPabAQjUDSrdYJ8AgozNEzaWPIVO80Fd7yqrgs2bFCw==
X-Received: by 2002:a4a:e60d:: with SMTP id f13mr5467792oot.6.1588367545541;
        Fri, 01 May 2020 14:12:25 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k24sm1118263otn.32.2020.05.01.14.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 14:12:24 -0700 (PDT)
Received: (nullmailer pid 3449 invoked by uid 1000);
        Fri, 01 May 2020 21:12:24 -0000
Date:   Fri, 1 May 2020 16:12:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Priit Laes <plaes@plaes.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com, Priit Laes <plaes@plaes.org>
Subject: Re: [PATCH v3 4/6] dt-bindings: net: sun7i-gmac: Add syscon support
Message-ID: <20200501211224.GA2673@bogus>
References: <20200430115702.5768-1-plaes@plaes.org>
 <20200430115702.5768-5-plaes@plaes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430115702.5768-5-plaes@plaes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 14:57:00 +0300, Priit Laes wrote:
> Now that driver supports syscon-based regmap access, document also the
> devicetree binding.
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  .../bindings/net/allwinner,sun7i-a20-gmac.yaml    | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gmac.example.dt.yaml: ethernet@1c50000: clock-names: ['stmmaceth'] is too short
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gmac.example.dt.yaml: ethernet@1c50000: clocks: [[4294967295, 49]] is too short

See https://patchwork.ozlabs.org/patch/1280292

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
