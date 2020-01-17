Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4745AC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF202073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579272521;
	bh=YYIc8ncjw9IAf4/GDADFxUHjnSxt8C1GJ/RrzEV40ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s05yXd+IVB1zOocEy9VobNaRhIVFrlvipoLXLpYPqHMtFgDDJM1TgksfCDDRfxQCS
	 DmtT5UaVZbgBg9BXj6SOLpVwPzZNMRKUYbQ3gvqlsmAsjAvuKjSqY1dld/wkNv14zj
	 sLY5SmYGz4XDqmbC0u0HnAIHcMD7YaOJWJDqGMWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgAQOsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:48:40 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:45233 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgAQOsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:48:40 -0500
Received: by mail-oi1-f169.google.com with SMTP id n16so22370939oie.12;
        Fri, 17 Jan 2020 06:48:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dyE4NzvdMsyKga26H8tQKOSJjEOPcWYAXtxjXIGSauM=;
        b=uRDdYi242KUktL5GwKg/yethULGwGsgG72YBU8OfsSl6uZii0ON+vs5BSfkqTtK8up
         Ut088jFxshpuWlJvJ4D4qBOPJk2QnfRB3QBuN+269Lzyc7pcif41z24xyGK95BsqWtXm
         yutrVRymJSxhLMeUb+sPnnsTIJ8YF9pimsYYMGYx5Zb3JPRGeqjrmvhVhVw/1drkCTvQ
         1zn6qmRMYbTUiBF5Z19HTi0nuMG4dkNjVUni7D7TWg79vteUQHypyTjhTPgazwGcXKdW
         C/Q5Neb8JIGZmIWWe8HeHtnNlqiAy08MYAuuSwAaqu5c6DDKim3fM3UKK6i+klSljeQI
         kQWg==
X-Gm-Message-State: APjAAAXxi4ytemILCi2Pi5vi6qApJaPcy4s6rZQn4twUFKMeR9xwCDwY
        XMBR6lmGvI4PyZlIU+xt1lCqEow=
X-Google-Smtp-Source: APXvYqyABfMThOmRvFNhbdQGFqiqtT+906MusSLrADtaBvi+FGDgJmdep6F7xH8DXrsB8rHtfy/eFA==
X-Received: by 2002:a54:4117:: with SMTP id l23mr3541405oic.140.1579272518846;
        Fri, 17 Jan 2020 06:48:38 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f4sm7824851oij.25.2020.01.17.06.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 06:48:38 -0800 (PST)
Received: (nullmailer pid 13001 invoked by uid 1000);
        Fri, 17 Jan 2020 14:48:37 -0000
Date:   Fri, 17 Jan 2020 08:48:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCHv2 1/2] dt-bindings: usb: dwc2: add support for STM32MP15
 SoCs USB OTG HS and FS
Message-ID: <20200117144837.GA27455@bogus>
References: <20200116144524.16070-1-amelie.delaunay@st.com>
 <20200116144524.16070-2-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116144524.16070-2-amelie.delaunay@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 03:45:23PM +0100, Amelie Delaunay wrote:
> Add the specific compatible string for the DWC2 IP found in the STM32MP15
> SoCs.
> STM32MP15 SoCs uses sensing comparators to detect Vbus valid levels and
> ID pin state. usb33d-supply described the regulator supplying Vbus and ID
> sensing comparators.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
> index 71cf7ba32237..0b86250b97a9 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.yaml
> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
> @@ -58,6 +58,8 @@ properties:
>        - const: st,stm32f4x9-fsotg
>        - const: st,stm32f4x9-hsotg
>        - const: st,stm32f7-hsotg
> +      - const: st,stm32mp15-fsotg
> +      - const: st,stm32mp15-hsotg
>        - const: samsung,s3c6400-hsotg
>  
>    reg:
> @@ -103,6 +105,10 @@ properties:
>    vusb_a-supply:
>      description: phandle to voltage regulator of analog section.
>  
> +  vusb33d_supply:

Not a valid regulator property.

> +    description: reference to the external VBUS and ID sensing comparators, in
> +      order to perform OTG operation, used on STM32MP15 SoCs.

Are they external or part of the SoC? When we have Vbus sense and ID 
GPIOs, those go in the connector node, so this probably should too if 
these are board components.

Rob
