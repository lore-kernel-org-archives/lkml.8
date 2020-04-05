Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61375C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 02:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343932070E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 02:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586052642;
	bh=+eBLU6dbzegIasK4eav0hKmN+wv2L8OLOi9lZsufu+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UTq2Kkin7O+npNlAs0mIMF7Q06Qo13gFYRhW/bB8OBgva//d0OGt21oYtsabzfj7e
	 q5XI8XwKKmy+k5fsrdW3A+7NCHkptrYuYug5RJ0tLg8lAz/R6lXQjZz5KXMGyq709a
	 dXiIBhc9l7Gr2zrXl/YPHCFLzOAcrj+Nrqktx8ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgDECKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 22:10:41 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35609 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgDECKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 22:10:40 -0400
Received: by mail-io1-f67.google.com with SMTP id o3so12036902ioh.2;
        Sat, 04 Apr 2020 19:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cE/liTALpMqdfLbgPQ+OMKvNPX/1bH463lnIhirz1sI=;
        b=bsRoT5ovDavx0tMF6zKvf8vMUT2uEZ0RR8V+d4o0nkFSumSUsQnHd3ISqdsd6QN3KD
         Cq0rzch7sdJ/icIsjLt71BEldG3AjCUQdJkRao4AUWYb4xWs/vpOZV5e+RvGr3Iffzlu
         imXGUeNFg6Z2Qdi9gO4e5EpgwgnXZmypp2wG5+843Ym3orUFPLDsUjBY6Y+Hnv51zFnV
         6UBNPa/wJgGedVny+KtxbmNW0WObINY6SMjyyluT4dq36U732md9iqN9HTstKYK2GsAH
         quIxcZk454FKXRwha/BTadu6S/QyYj4UiqdKm3pWCbjFd27kVwRfDlZjvW8y6UkwFu/P
         JtHw==
X-Gm-Message-State: AGi0Pua6CFXMy2MLpUFcnulugbNlT95xV7Y2nTpgaM2M7pyRlDrpMluj
        GXcFr3qc0Yo5miaBqSmAzQ==
X-Google-Smtp-Source: APiQypJ4Bii0h2zVuvjzC9xTfN/pXAliQtZWN2YXolG58HYB/LUmgfHgAwhVGMXf9l9WEMGwZS1vug==
X-Received: by 2002:a5e:9901:: with SMTP id t1mr13990159ioj.176.1586052638133;
        Sat, 04 Apr 2020 19:10:38 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a5sm3803374ioa.14.2020.04.04.19.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 19:10:37 -0700 (PDT)
Received: (nullmailer pid 12991 invoked by uid 1000);
        Sun, 05 Apr 2020 02:10:34 -0000
Date:   Sat, 4 Apr 2020 20:10:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        andrew.smirnov@gmail.com, manivannan.sadhasivam@linaro.org,
        michael@walle.cc, rjones@gateworks.com,
        marcel.ziswiler@toradex.com, sebastien.szymanski@armadeus.com,
        jon@solid-run.com, cosmin.stoica@nxp.com, l.stach@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
Subject: Re: [PATCH 3/3] dt-bindings: arm: imx: Add the i.MX8DXL EVK board
Message-ID: <20200405021034.GA12944@bogus>
References: <1585394015-27825-1-git-send-email-Anson.Huang@nxp.com>
 <1585394015-27825-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585394015-27825-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Mar 2020 19:13:35 +0800, Anson Huang wrote:
> Add board binding for i.MX8DXL EVK board.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
