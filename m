Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20210C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E355720884
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593722882;
	bh=K1oPAo5Mz0TFFhjYrNCWMniNyQihghksZ0mQyVA3CDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gwMSC41da26bmYefvaZfJZJEKun8GLs41eFYaiII+OOG4pIJBITPGZi0rHW77tOGb
	 PrIk5E99vi1+/O0eUwgZdQM+m7wlVACUodr5ll5aL4mWyGkGYUcvX21Qf+bWNKKv3N
	 4tOP8G4Uzf5mwPTuXFlzUHnEbD7jtcLlljlOV9zU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgGBUsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:48:00 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43140 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgGBUsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:48:00 -0400
Received: by mail-il1-f195.google.com with SMTP id i18so25450897ilk.10;
        Thu, 02 Jul 2020 13:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j1yxY9w2G0JH7eLYcGH9QwyTEXy3U6l8gD1SgwfkI04=;
        b=AEbHIITstXE7khfgmafMWAuJaxqqfK0uC5Bg2NIx9V6erj5PXdj/TothOzBFiUHtGp
         B06w9KK2LRY6hI5byj9fv5T1QTBSrQUUjf+aQHKBHFAaT2jTftINttXP/T+wxABRNfZI
         Y2ABGMXlHty5yjYicQqWiLdviyWeyiyCGydG0IuAp5wjtAKm23ktrOGn3aCLf/oBFqyC
         SompqvFovre6kO/uZ6iyIzuNR2WQwlpw6ZuXsdAOIjo4O9wzSvT4q7hDZJ2Jwr3/sGNV
         yn7V2AaQ8PCq2T5WDlxElYw2R1v2e5gjpl333WqmIhbjLXht+Oig6DVkodNEFo8GtiPH
         AaaQ==
X-Gm-Message-State: AOAM533StEuCdkur2uwHy0Roq412Lw+UVJwx1pKUo4zzyDECY/61gS5W
        Y1xK7F53h8PpP3zeRfCpxw==
X-Google-Smtp-Source: ABdhPJy4b9+p/Hb1STLVnu17+0DErUUOFe1/yUfp0AF2GZxEa4Co/j7n7em7RC9H7qtWSAkf3s7C/Q==
X-Received: by 2002:a92:5ecf:: with SMTP id f76mr13730600ilg.281.1593722879810;
        Thu, 02 Jul 2020 13:47:59 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id a24sm4949711ioe.46.2020.07.02.13.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 13:47:59 -0700 (PDT)
Received: (nullmailer pid 1665628 invoked by uid 1000);
        Thu, 02 Jul 2020 20:47:58 -0000
Date:   Thu, 2 Jul 2020 14:47:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     vigneshr@ti.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        kishon@ti.com, nsekhar@ti.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-binding: phy: convert ti,omap-usb2 to YAML
Message-ID: <20200702204758.GA1665250@bogus>
References: <20200630092729.15346-1-rogerq@ti.com>
 <20200630092729.15346-2-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630092729.15346-2-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 12:27:27 +0300, Roger Quadros wrote:
> Move ti,omap-usb2 to its own YAML schema.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/phy/ti,omap-usb2.yaml | 69 +++++++++++++++++++
>  .../devicetree/bindings/phy/ti-phy.txt        | 37 ----------
>  2 files changed, 69 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/ti,omap-usb2.example.dt.yaml: example-0: phy@4100000:reg:0: [0, 68157440, 0, 84] is too long


See https://patchwork.ozlabs.org/patch/1319665

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

