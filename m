Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F55C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC69820721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590700844;
	bh=7Ejf/V8MU6oiWB5Yrl8zispG0KUK4qGqWc+ctcEvg64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OxbxSatQdl9qm9yYFQq4c3kkFtt/kCm8LFNy4h44jwMinZPm7VfGWMyFQv0QeJk2E
	 p+hm5vCzH8zVuSTjJjchWRe4POBWQ7CEhglUhk0cfXzCkiE8/y6TPO/IQm3K6+8u6A
	 lKLf2R8YaihqaXzKtU8jmmphDuun6nRRVgh1Ko+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407514AbgE1VUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 17:20:44 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40982 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436506AbgE1VUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:20:34 -0400
Received: by mail-il1-f193.google.com with SMTP id d1so388135ila.8;
        Thu, 28 May 2020 14:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PwyjsRM4zwlzaJJrG2A1+cXj6KbCnGaQM27nEXJGJlQ=;
        b=f59g42H68nCiJeDoEaLCMoH18LEaRJ37Oa2XJvTkPqAUp8aDrkGj6boly5SspPSRij
         zOLQVQwI+5c6L6S1NwsF+WXbUJ/M1TEfdoc4ZapKc6mOYjJm2lTEBWTpoWbPEYGkiBWJ
         DTMssbCb1YKsdm0aOZJmzncv3gJM79Il+r5rhlS6pTdFHT6GoUSMfAi2LBGv9L8boqlS
         2bMe7v//fSP8HqEwQNxcKYgg44/MQSPzcC5cH/zkOJ1n0PTgJfV2N8Et2nXbcGN2Qy5d
         DIHbBCs3MfiMRhEbu1YzjW+lq7jcRc1UhXisTciATNDItePxGoMxvSYSFebQ+zSYeHXh
         1Rkg==
X-Gm-Message-State: AOAM532iGw+/QFA54fgZmgyLn8zTS5uJTvlFwZy4g2P5TXFNrTTSE/iF
        EJd2b+EYKXqtbQjBQGei9QGz3vY=
X-Google-Smtp-Source: ABdhPJzWkidAS5F05dATCxL69d3XXFijRp+EsKj191WfFxBxm6cclR4GuacDATyqOBUyfIpQclNWow==
X-Received: by 2002:a92:dc91:: with SMTP id c17mr4289794iln.65.1590700833677;
        Thu, 28 May 2020 14:20:33 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id o28sm3145992ili.12.2020.05.28.14.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 14:20:32 -0700 (PDT)
Received: (nullmailer pid 705934 invoked by uid 1000);
        Thu, 28 May 2020 21:20:31 -0000
Date:   Thu, 28 May 2020 15:20:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     broonie@kernel.org, kernel@pengutronix.de, john.lee@nxp.com,
        anson.huang@nxp.com, linux-imx@nxp.com, catalin.marinas@arm.com,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, will@kernel.org, lgirdwood@gmail.com,
        festevam@gmail.com, shawnguo@kernel.org
Subject: Re: [PATCH v1 2/4] dt-bindings: regulator: add pca9450 regulator yaml
Message-ID: <20200528212031.GA705887@bogus>
References: <1589925907-9195-1-git-send-email-yibin.gong@nxp.com>
 <1589925907-9195-3-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589925907-9195-3-git-send-email-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 06:05:05 +0800, Robin Gong wrote:
> Add device binding doc for pca9450 pmic driver.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  .../bindings/regulator/nxp,pca9450-regulator.yaml  | 190 +++++++++++++++++++++
>  1 file changed, 190 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
