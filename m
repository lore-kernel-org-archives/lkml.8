Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4ECC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 22:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23B82166E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 22:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587765963;
	bh=JivJTIRgDiUIQy8eirUs45TtyuILvCgZqRvnH5Wfcmk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cAGG3XPuSuVShOS+PAMFsY2PDBh7Nw7T81CZv7p4bMEZlszGE0Jg641DV8VSJcMIE
	 uYJeo1KWj284wbo6b0JN5VPw1akusDkQ3+jQYUc35e2a2rpaU6h3KrHuXzTOSO0717
	 ZutwvwKgVV1Rr2zZt/KMq4N6gwHe/HsNs/OsHq+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDXWGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:06:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgDXWGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 18:06:02 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2A392098B;
        Fri, 24 Apr 2020 22:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587765961;
        bh=JivJTIRgDiUIQy8eirUs45TtyuILvCgZqRvnH5Wfcmk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2syVbBmoK8XrkPtUfJDqtPoO+QllnBQNWmGqXWVUUPjXUdNygPj3yDGu1IkZB/ltc
         RY4Eubr6n1HDACvMv60r+ICK/pBsG5rUEu4y9TmhfkD9POKfJZTfhhMsmgypj2StyW
         EDp7nlwKG4kh9mFheZAtzuxFuQZcuePnmfbko3QE=
Received: by mail-qt1-f178.google.com with SMTP id w29so9299035qtv.3;
        Fri, 24 Apr 2020 15:06:01 -0700 (PDT)
X-Gm-Message-State: AGi0Pub/LiMMC0DLxOSUFijIItVNhJ6iSEKYC6WcP9brRlk/QSDzrlHT
        Pg3yqo2bCIPqJxIFFBiq3l83szafduw/Ykcy2g==
X-Google-Smtp-Source: APiQypIVltF4TcBafK99loWjJjLLH+9EYxohE3EW1fPkl7KXSdN1YZmaVY0jfUimAylQ+g9ffp3oxucLw5yVf10M3Zo=
X-Received: by 2002:ac8:47cb:: with SMTP id d11mr10875122qtr.136.1587765960749;
 Fri, 24 Apr 2020 15:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200423064808.10468-1-etienne.carriere@linaro.org> <20200423064808.10468-2-etienne.carriere@linaro.org>
In-Reply-To: <20200423064808.10468-2-etienne.carriere@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 24 Apr 2020 17:05:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKvQasaBCHC2s68WmtfwGN+t349tzmF=ySkuYz11HzksQ@mail.gmail.com>
Message-ID: <CAL_JsqKvQasaBCHC2s68WmtfwGN+t349tzmF=ySkuYz11HzksQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: arm: Add secure-clocks binding description
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 1:49 AM Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Describe how clocks property can leverage secure- property prefix
> for clocks handled exclusively or shared by secure and non-secure
> worlds.
>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
>  .../devicetree/bindings/arm/secure.txt        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/secure.txt b/Documentation/devicetree/bindings/arm/secure.txt
> index f27bbff2c780..9bc94921f2a6 100644
> --- a/Documentation/devicetree/bindings/arm/secure.txt
> +++ b/Documentation/devicetree/bindings/arm/secure.txt
> @@ -53,6 +53,25 @@ Valid Secure world properties
>     status = "disabled";                             /* disabled in both */
>     status = "disabled"; secure-status = "disabled"; /* disabled in both */
>
> +- secure-clocks : specifies the Phandle list secure world shall use
> +  for the related clocks whereas property "clocks" specifies the
> +  clock Phandle list non-secure shall use for the that clocks.
> +  This configuration can apply for example when a hardware clock is
> +  shared by the 2 worlds and the hardware implements a specific interface
> +  for each world, i.e.:
> +
> +  clocks = <&clk DMA_NS>;      /* NS relies on clock handle DMA_NS */
> +  secure-clocks = <&clk DMA_S>;        /* S relies on clock handle DMA_S */

The device has to know what it's clocks are for and should know if
some clocks are secure only.

> +  Another example where use of "clocks" and "secure-clocks" can apply
> +  is when hardware implements a clock that secure and non-secure must
> +  share, as a shared GPIO bank clock, and secure world relies on clock
> +  device driver whereas non-secure world relies on a software service
> +  exposed by secure world as SCMI clock device. I.e.:
> +
> +  clocks = <&scmi_clk 2>;      /* NS relies on SCMI resources */
> +  secure-clocks= <&clk 5>;     /* S accesses the SoC reset interfaces */

If you have this case, I don't think this is the solution. I don't
think it scales well and you probably need separate DTs. It's
something to solve in the system DT project.

Rob
