Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F67CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E795B2064B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594337224;
	bh=nR+vwIqtJ1Kmdii6IsFpmZYF/kvC+TQykz9HjVLPr38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2hMuDlYUZk0+WteI4E/UL8d2s4sCYsd9U8Z38gLM0EvdcFGgxrMm6pDXfNAelDASa
	 O99AI+MmySwf95M947pN05W55DwYzKIZS6kX9YJM6pGX2XAvyaKF8OkQJT6903KI4A
	 07mNup1xMUzFZrDMDmnEEe/JffliUCN1HOpAwZbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgGIX1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:27:02 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43234 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGIX1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:27:02 -0400
Received: by mail-io1-f67.google.com with SMTP id k23so4126311iom.10;
        Thu, 09 Jul 2020 16:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+tXOUHyg9jmLUCdly/hc2/GKpHp+Bmb566JVCFReT5g=;
        b=GQt39AlWIE5OB0895UC6owarhvOnVIyF2EiCRiKsH8fr3H4fophTtDyUM/hPLhnLcb
         +7z2dsRjGxGjTa6511TgbmKzYS9MGKey5OiBb4Hi9gNgbMD0YJH6WaTlNv1eZz5IxqUv
         BDJ4X21dhQCgJQIuHP7xei4jBDlSFlJvXNMNVud0bybW5Q4EEwxu9WazMBw08scZaJgo
         FhOT7HgRJGnnXRvpNWbAcPVrsqOD7cdX66etG2USVbCc+LqiuW3auX0ExShFzG38a8G2
         6V11VxTKmNkfvKGZK2OA/VlnDMoHf++TUhBZvUSDPZ72Pzjt7xV+3FMgBPieXu5FhL99
         8r3w==
X-Gm-Message-State: AOAM531QqQXaZebJP0yLTp/NedBinI/2Yb9PIFOEyN8ENYmB0CIs7uer
        D51IzJTXbl0W0Kq2I9XvXg==
X-Google-Smtp-Source: ABdhPJzRO+OD6eQluodNsrRcwh1Xz64kyyrfFn/VJsPLn2F56qvDX4b6v6qWtuJ0WHfSWqK13xBX9Q==
X-Received: by 2002:a02:b089:: with SMTP id v9mr46936214jah.50.1594337221364;
        Thu, 09 Jul 2020 16:27:01 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id m16sm2548323ili.26.2020.07.09.16.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:27:00 -0700 (PDT)
Received: (nullmailer pid 1096382 invoked by uid 1000);
        Thu, 09 Jul 2020 23:26:59 -0000
Date:   Thu, 9 Jul 2020 17:26:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, broonie@kernel.org, marex@denx.de,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-spi@vger.kernel.org, shawnguo@kernel.org
Subject: Re: [PATCH V3 3/3] dt-bindings: spi: Convert imx lpspi to json-schema
Message-ID: <20200709232659.GA1096319@bogus>
References: <1592281575-32708-1-git-send-email-Anson.Huang@nxp.com>
 <1592281575-32708-4-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592281575-32708-4-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 12:26:15 +0800, Anson Huang wrote:
> Convert the i.MX LPSPI binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V2:
> 	- remove redundant "maxItems" in "clocks" and "clock-names".
> ---
>  .../devicetree/bindings/spi/spi-fsl-lpspi.txt      | 29 -----------
>  .../devicetree/bindings/spi/spi-fsl-lpspi.yaml     | 60 ++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
