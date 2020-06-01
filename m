Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0FDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C654F2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591026243;
	bh=9rKAASUkF4MQwxBSuIpkgqAHEjQNlaKU9BXJJoH3mJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mBCKLYMUE2SivrON2dxgb+Mk1PIh3RpEToiEYGW376MTbThKKWY9FxztawBFjNllT
	 VrV5FBFFaGXEC8iHi76dgOqI7vzSCYKrx/COhnk/RfqC3gMA7kiqiIfbKGN0cHxYxl
	 bfrBkaf56jjnRPI0ua5WUESJXGxzrtp55FEJozVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgFAPoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:44:03 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45722 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAPoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:44:02 -0400
Received: by mail-io1-f66.google.com with SMTP id y5so7335268iob.12;
        Mon, 01 Jun 2020 08:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tPG61Iob6GWwH5KaiKNOOzQS6HPkHBEF1ZIAaOyNuMc=;
        b=TytZ70ufKGLmbvuEjspGCZ56IxD+ZCGcFI/Dw211J0Upb2X4tU+phxu78qSrzeL0g0
         1LicCSHljsohAqFP/HTT3ieMat48xRcSrwFpRO2ty58Wm4P02Dn/F+4NIA2PjqWEako+
         0WYl1eVdEd0BiQMQpas+or8lUO8NDivj7svNFetFe8o/DpemTQqKl1RK5Ch5z1Cgqvv3
         CBPnMsmvtUyFu30EbLR17fnQuq4x529vDXVaFs+tceAGM6A9BNx94ZksBQczxY9czYLH
         hffQZaUmZyIHYSNicgwdx8mWuIF5dWNQhr1w20yLezNPCDr657ix+c0MGnEmXJst7zAv
         M2rA==
X-Gm-Message-State: AOAM5305FFde694JxzI6Sf+s6N06XUVKGzrTh9d9d4tkp0A/Akilil9P
        4e+OSAqHDCwJscFAncxDFjTfU8c=
X-Google-Smtp-Source: ABdhPJx/MOdbvba8QtwcxyGL+i4Oe2Hv4WWqEamLRvnLmSR6Lhmk4XJ0vyajak++iZFRI8G+5suarA==
X-Received: by 2002:a02:c8d2:: with SMTP id q18mr21899465jao.127.1591026241572;
        Mon, 01 Jun 2020 08:44:01 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id 18sm7776643ion.17.2020.06.01.08.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 08:44:01 -0700 (PDT)
Received: (nullmailer pid 964289 invoked by uid 1000);
        Mon, 01 Jun 2020 15:43:59 -0000
Date:   Mon, 1 Jun 2020 09:43:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     andrew.smirnov@gmail.com, krzk@kernel.org, festevam@gmail.com,
        p.zabel@pengutronix.de, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com, shawnguo@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: power: Convert imx gpcv2 to json-schema
Message-ID: <20200601154359.GA963841@bogus>
References: <1590998803-29191-1-git-send-email-Anson.Huang@nxp.com>
 <1590998803-29191-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590998803-29191-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Jun 2020 16:06:43 +0800, Anson Huang wrote:
> Convert the i.MX GPCv2 binding to DT schema format using json-schema
> 
> Example is updated based on latest DT file and consumer's example is
> removed since it is NOT that useful.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/power/fsl,imx-gpcv2.txt    |  77 ---------------
>  .../devicetree/bindings/power/fsl,imx-gpcv2.yaml   | 108 +++++++++++++++++++++
>  2 files changed, 108 insertions(+), 77 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
>  create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
> 

Applied, thanks!
