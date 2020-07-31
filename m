Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32ECC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 19:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6772076B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 19:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596224131;
	bh=BVCQRenHtfdYAovoOETgyQjUxXQoIJ3ks6WHG4vZz1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PJRV67A6btfeXfH5uYQZ81K+Ylg7xQX5KTx9kiY/Tl9iztRFLvXj+jNl/ZioQ2drk
	 k0y9XAAamjoCHIKWBOu5SDHwwPSNXAPbhUvCFS9v3h7DHQUWWMglXiAyCVifn2FYeT
	 lLNWvzWNjQRrjo6Jp7fEHLdOOKVHproKqVDZLui4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgGaTf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 15:35:29 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43404 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgGaTf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 15:35:29 -0400
Received: by mail-io1-f67.google.com with SMTP id k23so32711426iom.10;
        Fri, 31 Jul 2020 12:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NmxboVmA6VthcM2O2yN9VnuqcMThPCoNFusWBoBdSXk=;
        b=imx/3Q3JoYv45u1NCWqFsnnpgVPlhPD6Pw1ysXDTj8OI9JKplGDcY0oK5cxBOZUMn2
         Ch9GH/pcFLT2bUGrM0OneUoTbX6UwjsbOi5OV3CY0/cn7hsTmP4BUXLBf43Z519og/sY
         7K3VLaejfmN9nReXmxabD9qL3TBY2j43pB82EDcAWi6FNWELkJQbYNOz/AH3P5OAHmCx
         YIdhM+1nyAcmx54EeJ2/wwj/b1N5cq0pu6fWNBp8ieWIuZmWmJGyCZQdgotRFlSxT+Qq
         MSOvs6RqnG3XiLRnxpGPB+cwG8LWh7S3FJp338Sucr2Y4n+1quA5If/y1ckOx8tP/QSs
         bTWQ==
X-Gm-Message-State: AOAM532KJQ8E9w7+JVbUUBdHmLnO2d08uQHUCRlUyEbo8YYdRXpzPDEA
        2LGRyIXEZw/mItYccH2LnA==
X-Google-Smtp-Source: ABdhPJw7QT/4b5WZ4AtHmowcUOpE/M0zAIJQzeAnrOa2eNjKO6u8EU4gcn0Z94WSzQu+teXw3/4j/A==
X-Received: by 2002:a05:6638:1649:: with SMTP id a9mr6955332jat.115.1596224128015;
        Fri, 31 Jul 2020 12:35:28 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l16sm5207835ilj.78.2020.07.31.12.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 12:35:27 -0700 (PDT)
Received: (nullmailer pid 642187 invoked by uid 1000);
        Fri, 31 Jul 2020 19:35:23 -0000
Date:   Fri, 31 Jul 2020 13:35:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     agx@sigxcpu.org, kernel@puri.sm, Anson.Huang@nxp.com,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de, angus@akkea.ca,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, s.hauer@pengutronix.de, festevam@gmail.com,
        mchehab@kernel.org
Subject: Re: [PATCH v5 3/3] dt-bindings: arm: fsl: Add the librem 5 phone
Message-ID: <20200731193523.GA642071@bogus>
References: <20200731082725.21878-1-martin.kepplinger@puri.sm>
 <20200731082725.21878-3-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731082725.21878-3-martin.kepplinger@puri.sm>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 10:27:25 +0200, Martin Kepplinger wrote:
> Add entries for the imx8mq based Librem 5 phone. The "Birch" and
> "Chestnut" hardware revisions are supported by r2. The "Dogwood"
> revision by r3.
> See https://puri.sm/products/librem-5/ and https://developer.puri.sm/Librem5/
> for the schematics and more information.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

