Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C2FC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A4921739
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580139310;
	bh=XlQkHY1fDUiPsQxLG2f4cm7hcqh48mk+Pd4GwyAnINM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bC5TLL6t6JkJh9kh0VY2jZ+2x53IomB/cnjOjv5gaQ9WfP8tVJ7445gAzLQ1kZpWS
	 /3NuQrqhY3Ia0aLmN3Wf4GemQdPiQlPNxo6IUSTMP9Xlz3hncrdMZg+T2wvMS6E4Lo
	 +9eMFx/nv61WmCt8p22yUA/j2frw4BfoSr9cbqnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgA0PfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:35:09 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35290 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgA0PfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:35:08 -0500
Received: by mail-oi1-f193.google.com with SMTP id b18so3077424oie.2;
        Mon, 27 Jan 2020 07:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=omtnsWBjbVm/NZL/pqX4cwBZTFhWoiBZO939OVp2MOA=;
        b=JlmgtMQp5lo1ph99hEYYeebBX4WCrk4C9Qzl3cHJZoYMMoHGy0kMDrzzLMPt8fDkMT
         FsqsVGsGRjGCCU/a+txb4LAk64jRGNaM/82B4rXuPBwTKG9lbo65nr1teT+ZqCktQ2/w
         GLAqLaxkV2C1FOKW7rIYeJGP0xr1YtvD4keRvFPB6MEhQnJf5c24vN2BWFv6T09o8EL9
         cgxilNdqE+ApzW7SucgtGGBiUNLzNwaUHw8NSrRk3syzNfiITgpebaTedabV6xks/j8L
         9gA5TbHPxMwuE/UURlf2CxQg0xfQUs/UAQGvnE8RsegBA2icPAdlQ8YPy4xznM12Cuv6
         AIWQ==
X-Gm-Message-State: APjAAAXR+JPoxmKBTeuA2OyAzfIWtVi78Zs8UZeZKlkfmHzj5UP5ad/Y
        oqpL0bwX025ufsJ7ADj0kQ==
X-Google-Smtp-Source: APXvYqyifQ9wAgKfHNoCNFNZQ8VQ+kHY+fZ5ztdZiqbY8OQhMgLbLTtW7aWY56EDCLmmEoxxJSqgHw==
X-Received: by 2002:aca:e146:: with SMTP id y67mr7414091oig.93.1580139307777;
        Mon, 27 Jan 2020 07:35:07 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l1sm4872297oic.22.2020.01.27.07.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 07:35:06 -0800 (PST)
Received: (nullmailer pid 29568 invoked by uid 1000);
        Mon, 27 Jan 2020 15:35:06 -0000
Date:   Mon, 27 Jan 2020 09:35:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mans Rullgard <mans@mansr.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH 1/2] dt-bindings: usb: add non-removable-ports
 hub property
Message-ID: <20200127153506.GA4589@bogus>
References: <20200124152504.23411-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124152504.23411-1-mans@mansr.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 03:25:03PM +0000, Mans Rullgard wrote:
> Add a non-removable-ports property that lists the hardwired downstream
> ports of a hub.  Although hubs can provide this information, they are
> not always configured correctly.  An alternate means of indicating this
> for built-in USB devices is thus useful.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>

I reviewed this already, but since you didn't add my reviewed-by, I'm 
looking at it again and having 2nd thoughts.

> ---
>  Documentation/devicetree/bindings/usb/usb-device.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
> index 036be172b1ae..92d863cc96b6 100644
> --- a/Documentation/devicetree/bindings/usb/usb-device.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-device.txt
> @@ -66,6 +66,10 @@ Required properties for host-controller nodes with device nodes:
>  - #size-cells: shall be 0
>  
>  
> +Optional properties for hub and host-controller nodes:
> +- non-removable-ports: list of hardwired downstream ports

If you have a hardwired device and need to know that, doesn't that imply 
there's some other stuff you need to describe beyond what a standard USB 
device has. Such as a power supply that's not Vbus from the hub.

At a minimum, I think this should be a per port property. Though really, 
I think this should just be implied by describing the device in DT. I'm 
not sure if there's a case for hotpluggable devices described in DT. 
Maybe with overlays.

Rob
