Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBFAC54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 01:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2A620769
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 01:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589248295;
	bh=TOxJQ8useNXlHqOGQiMvp/S/nDhqTDFghznaUa0/uIg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=a+2N0FF15inSaAFt0VnrKU00TN4wZEmHRLElBCRa6ViQyZ3pnXiBdyIJtikCUUIoF
	 a0IpvRojz5abXlKF/3U6lo2MPCfEhUKJdw4FcL5sp3CWU3E8ApaevqYCpELZy7y9fA
	 tOEc2/AzHjTj6ZDVvfntXWcT1KHCIjyjipOaWKsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgELBvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 21:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgELBvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 21:51:32 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9193A20722;
        Tue, 12 May 2020 01:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589248291;
        bh=TOxJQ8useNXlHqOGQiMvp/S/nDhqTDFghznaUa0/uIg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p5IIt7uZkMwrIw0sfUSXF2EWssNrJlRS+SHD0jR/hO7hOYSHT/ZJyLQ4f9rlKVh3+
         h7SkEi+TrQHofsgPWS4jpxQtRfhnJA3ubSknMIlTXAcCkcSQ0m05Tf2Y6lbsTDnBdj
         K13Wv8z8EqcNsxZ9VuwLBz2N/+kxE8jv11ZFf+lM=
Received: by mail-oi1-f182.google.com with SMTP id o24so16932101oic.0;
        Mon, 11 May 2020 18:51:31 -0700 (PDT)
X-Gm-Message-State: AGi0PubAiBuDtHo/3eEM8rRqb5e8Rj9NQvCn4csMCZh8iA3fLw0IhymY
        Dr3VTM8bn8yC3TXwM6UUslSAgON3LZXcHSS+Ew==
X-Google-Smtp-Source: APiQypL/XqEe5cfCkvX4wVesmS2480UqrH6RbZniT1cjmaBIpnKBFXu2MNZpbZugUwsCKTbKaMG1sKVIuRyWE3/GCoY=
X-Received: by 2002:a05:6808:24f:: with SMTP id m15mr22849330oie.152.1589248290884;
 Mon, 11 May 2020 18:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200508134527.26555-1-etienne.carriere@linaro.org>
In-Reply-To: <20200508134527.26555-1-etienne.carriere@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 11 May 2020 20:51:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJVaWDYZWwRwotSQyaL5bOugM3judxipS9oKveV3FdK8w@mail.gmail.com>
Message-ID: <CAL_JsqJVaWDYZWwRwotSQyaL5bOugM3judxipS9oKveV3FdK8w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: nvmem: stm32: new property for data access
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Etienne Carriere <etienne.carriere@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 8:47 AM Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> From: Etienne Carriere <etienne.carriere@st.com>
>
> Introduce boolean property st,non-secure-otp for OTP data located
> in a factory programmed area that only secure firmware can access
> by default and that shall be reachable from the non-secure world.
>
> Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
> ---
>  .../bindings/nvmem/st,stm32-romem.yaml          | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> index d84deb4774a4..c11c99f085d7 100644
> --- a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
> @@ -24,6 +24,18 @@ properties:
>        - st,stm32f4-otp
>        - st,stm32mp15-bsec
>
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    type: object
> +
> +    properties:
> +      st,non-secure-otp:
> +        description: |
> +          This property explicits a factory programmed area that both secure
> +          and non-secure worlds can access. It is needed when, by default, the
> +          related area can only be reached by the secure world.
> +        type: boolean
> +
>  required:
>    - "#address-cells"
>    - "#size-cells"
> @@ -41,6 +53,11 @@ examples:
>        calib@22c {
>          reg = <0x22c 0x2>;
>        };
> +
> +      mac_addr@e4 {
> +        reg = <0xe4 0x8>;
> +        st,non-secure-otp;

This fails validation. You need to drop 'additionalProperties' in nvmem.yaml.

Rob
