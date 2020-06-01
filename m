Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F528C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B9882068D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591026217;
	bh=7AqRZenQrkm6vYlWUFu/IMWJbK6kYXMYDixKw6uv0rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KexMcIKVz2Lfe07RIGfaljmiwSO0+BVlUDQBuxy9pulqvfLhiAqCUx6o1ivjR5m9g
	 +jblUBj0FghpEIyV8brXWqhReOrdOM06Kwqhw43zUGuor9mSZEIhFL5jRoXMYUoj5f
	 R8wIixS2ICyKX45d9gAy+1Dgcd8LZnasGAcVfifc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgFAPng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:43:36 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:37745 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAPng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:43:36 -0400
Received: by mail-il1-f193.google.com with SMTP id r2so9794764ila.4;
        Mon, 01 Jun 2020 08:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Cv2OpMq6lgoXWKHII03pxl97bK7u9ytVqckOaVbDuk=;
        b=gQ7u1gXpa7W9+jqp8yyZNL6nyssNtTaj4cSLD/oEu5aauzS0CCNscnLnh7eIRRZrx3
         a+76pDpTBdG66CidYVnh3PrgURq0CJs0tXeM1cnlIKfH66y/I8698B3mKWgoAq8DX1oF
         HzoVTFw/wk3h2IG/VHsnR+rpdQZU/AjusQ7vDr6efU60X9E8E57LP6Dc4VKW15wIoNdm
         fcz7uzajwVa/yfSE83IERnY6fQDAzzKTULURU8/CVI1tg9e9kI7KGB5fTeGAEQcC3P5j
         1LrKu3jFccO17b+iGlYKyjd3rLiShtDHii87m7vxzQFIUHge+eK/ouZTRtAeW2O5w0I1
         Gblg==
X-Gm-Message-State: AOAM533daEcsLDgxI8VHWVG5SRBV/KrjSEsRNfTwcV4OMhbo9hb1cRdn
        BhCRft9FF92yxw40S9CrwQ==
X-Google-Smtp-Source: ABdhPJy5xOF1cP/A25OBdRb23Fv9bPIVH9PkC8RQAXi+0x6Lk0dnBX72tppfHijJCcDFFxHT3jWqKw==
X-Received: by 2002:a92:b00e:: with SMTP id x14mr16153308ilh.219.1591026214135;
        Mon, 01 Jun 2020 08:43:34 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id o28sm9470510ili.12.2020.06.01.08.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 08:43:33 -0700 (PDT)
Received: (nullmailer pid 963387 invoked by uid 1000);
        Mon, 01 Jun 2020 15:43:30 -0000
Date:   Mon, 1 Jun 2020 09:43:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, robh+dt@kernel.org, festevam@gmail.com,
        ulf.hansson@linaro.org, Linux-imx@nxp.com, sboyd@kernel.org,
        shawnguo@kernel.org, p.zabel@pengutronix.de,
        andrew.smirnov@gmail.com, krzk@kernel.org,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de
Subject: Re: [PATCH 1/2] dt-bindings: power: Convert imx gpc to json-schema
Message-ID: <20200601154330.GA963331@bogus>
References: <1590998803-29191-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590998803-29191-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Jun 2020 16:06:42 +0800, Anson Huang wrote:
> Convert the i.MX GPC binding to DT schema format using json-schema
> 
> >From latest reference manual, there is actually ONLY 1 interrupt for
> GPC, so the additional GPC interrupt is removed.
> 
> Consumer's example is also removed since it is NOT that useful.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/power/fsl,imx-gpc.txt      |  91 ---------------
>  .../devicetree/bindings/power/fsl,imx-gpc.yaml     | 124 +++++++++++++++++++++
>  2 files changed, 124 insertions(+), 91 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
>  create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml
> 

Applied, thanks!
