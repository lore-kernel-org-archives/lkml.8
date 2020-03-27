Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6C8C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854C42071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585302891;
	bh=zsAHFY8HYYi1pCUgG38aoKsgwN3WWwDDoEivELfqiDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nkcEZFEWYIF1xWCRwF8uOcRkTt7iA9FFE94kgmZ3GY3Uqva04bFKAUPsX+glL3fJv
	 vIzUMUNOnaU3Takdks8yWc2EJCS09dcvJ9+3+eVjHxujViwJPt2sA/i+dwon4Om8/D
	 ZB0X+hi+AauYyqEFXGCGFNDSWh2O0M/Pt8dl7TAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgC0Jyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgC0Jyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:54:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DDC420578;
        Fri, 27 Mar 2020 09:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585302889;
        bh=zsAHFY8HYYi1pCUgG38aoKsgwN3WWwDDoEivELfqiDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KgT/fJ6hWwwiZFtxbE3ulRTspSgZCYIPpSSTg/5HLhkjAwiFvsywwHwnZAK1oe2v5
         0O1n5knKyvTh75YkyA7t1M2Vn9RZhl/UkzJuVl/GyZ56aWAkR4FXYY9prUf+MCLjQJ
         Rfw7GzamfClchGB2uyQ9yEwKizWbERO1XFRKcr+A=
Date:   Fri, 27 Mar 2020 10:54:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tejas Joglekar <Tejas.Joglekar@synopsys.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Youn <John.Youn@synopsys.com>
Subject: Re: [RESENDING RFC PATCH 1/4] dt-bindings: usb: Add
 snps,consolidate-sgl & consolidate-sgl
Message-ID: <20200327095447.GA1698181@kroah.com>
References: <cover.1585297723.git.joglekar@synopsys.com>
 <8a9ca8e08d7c4957789a209c77589f1aa4bd2f06.1585297723.git.joglekar@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a9ca8e08d7c4957789a209c77589f1aa4bd2f06.1585297723.git.joglekar@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 03:11:56PM +0530, Tejas Joglekar wrote:
> This commit adds the documentation for consolidate-sgl, and
> snps,consolidate-sgl property. These when set enables the quirk for
> XHCI driver for consolidation of sg list into a temporary buffer when small
> buffer sizes are scattered over the sg list not making up to MPS or total
> transfer size within TRB cache size with Synopsys xHC.
> 
> Signed-off-by: Tejas Joglekar <joglekar@synopsys.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc3.txt     | 3 +++
>  Documentation/devicetree/bindings/usb/usb-xhci.txt | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> index 9946ff9ba735..292d1f7969e4 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -104,6 +104,9 @@ Optional properties:
>  			this and tx-thr-num-pkt-prd to a valid, non-zero value
>  			1-16 (DWC_usb31 programming guide section 1.2.3) to
>  			enable periodic ESS TX threshold.
> + - snps,consolidate-sgl: enable sg list consolidation - host mode only. Set to use
> +			SG buffers of at least MPS size by consolidating smaller SG
> +			buffers list into a single buffer.
>  
>   - <DEPRECATED> tx-fifo-resize: determines if the FIFO *has* to be reallocated.
>   - snps,incr-burst-type-adjustment: Value for INCR burst type of GSBUSCFG0
> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> index 3f378951d624..a90d853557ee 100644
> --- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> @@ -43,6 +43,9 @@ Optional properties:
>    - quirk-broken-port-ped: set if the controller has broken port disable mechanism
>    - imod-interval-ns: default interrupt moderation interval is 5000ns
>    - phys : see usb-hcd.yaml in the current directory
> +  - consolidate-sgl: indicate if you need to consolidate sg list into a
> +    temporary buffer when small SG buffer sizes does not make upto MPS
> +    size or total transfer size across the TRB cache size.

Shouldn't this refer to the fact that the hardware is broken?  Otherwise
why would anyone know if they should, or should not, enable this option?

thanks,

greg k-h
