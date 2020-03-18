Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612DFC4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369B420754
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584569590;
	bh=t+KgMHceNYPepEj8DnsavTVJzcyAGp6+uD6ynCkOwZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hy6IObVJqhf+99KtAtqnbMsq3vAnwTSQfymvg9/wzGBD5WQSjz1wfVRtSa5DyGUaB
	 e/H94DCZ81yu3kPfDkuVEfA5n76ersO1FoFfNq5NQtnuAOyReUMGknpVcB5d4FdTVx
	 oPKDL6pu0oXcrJYnuVkgAaEo+Y0waEt7YVxJB6aM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgCRWNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:13:09 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44170 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRWNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 18:13:08 -0400
Received: by mail-io1-f65.google.com with SMTP id v3so160121iot.11;
        Wed, 18 Mar 2020 15:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vI2oiWC9LH3F/wNwDpMAEyJ8ow2uL7hezjEKLRYLfkQ=;
        b=QWaX4LLYbxjs1lRVXvo7TRBAsVCu6oMISvzAwVeqP9GMqQ9GCgPiRUeE+2YB8Mc4Gt
         iA3/5WffNd6NxPWZ1eD0E6uT9qsBpI8TdjOOW7dGevD6hw/eW3UCOoQOUo5LlCTX9PbS
         ywd+we4HUHT3gY60eZTZuCcyCaIPh8AFhDM/GIzP1Dg5D5WEIKKScRu3PCRzarW4o/PL
         /i00uRtuWoFNzaqvjNDexFT7VBEXETSTFVYE99S3WuGlHoBTfxjPr4GJx1qyI2lvynBX
         h8tndcGkTiu6euD1bXVml8NY+buQ5gIxPpPLEL2LDaCOcWDIuD1/H6cXARaHjeT0TZY0
         37cg==
X-Gm-Message-State: ANhLgQ3ewiQ09kvEI7r4nLFB8ZK92cnfnh6Vy4FHbAdYxYRAflGX1Zg3
        WCmP2GO7BgAjrMUOOsxUww==
X-Google-Smtp-Source: ADFU+vuQg+pvqCkdjOR+MTIxkrfGYLu3hbZ8HXPDkiEoRjoFQtoZWruFHZBgCjkV/KU7alX75sG5xg==
X-Received: by 2002:a02:6d2c:: with SMTP id m44mr233994jac.65.1584569587719;
        Wed, 18 Mar 2020 15:13:07 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v21sm68954ios.39.2020.03.18.15.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 15:13:06 -0700 (PDT)
Received: (nullmailer pid 29033 invoked by uid 1000);
        Wed, 18 Mar 2020 22:13:04 -0000
Date:   Wed, 18 Mar 2020 16:13:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     peng.fan@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 1/4] dt-bindings: fsl: add i.MX7ULP PMC binding doc
Message-ID: <20200318221304.GA28525@bogus>
References: <1584348944-19633-1-git-send-email-peng.fan@nxp.com>
 <1584348944-19633-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584348944-19633-2-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Mar 2020 16:55:41 +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX7ULP Power Management Controller binding doc
> pmc0 is used by M4, pmc1 is used by A7, they have different
> register name and usage.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/arm/freescale/imx7ulp_pmc.yaml        | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/arm/freescale/imx7ulp_pmc.yaml#

See https://patchwork.ozlabs.org/patch/1255335
Please check and re-submit.
