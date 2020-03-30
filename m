Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF53C2D0F0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB72720786
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585599805;
	bh=d8XJLrTnwSQUfzbQQPE8q6PwswKMvTeAcdMlWnWyezM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HomwVU/WuqCxvi/ZR1ogU4f55JP8AX6vTtiZE4/mQcT/bXB7ZPu6LsmzDCuvvoXDy
	 1wc7G9jJHmlaMZ9UmKqDpmVGYE123wQU4KXKY5A0/hSg0WXuhlHimkC+jErsK2/Wm5
	 fMqDD8Wo36pbAYehMfZ8ZpLeOdDoUoccP1cYhb5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgC3UXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:23:24 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38842 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgC3UXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:23:24 -0400
Received: by mail-il1-f193.google.com with SMTP id n13so9879405ilm.5;
        Mon, 30 Mar 2020 13:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ATU7uGxXPYRDHpKRltXUHSrkmJcvmcEFJ9x1hejSj4Q=;
        b=YFCTQwjmanDBN5+S8Z15ihi4k7FxZYbKuJQ42ykIHiPhVvGQVevAS99bPcmzG1JCCO
         b9rECmoJXvdJImobXMW0ZXtFqtemEodBF9mitxgWK0UEseq79zuXl5Q5Eu7Kfzh5ZUSG
         vNSp7spaDsw2f/ugAqB0rqsiFejM5GZysEJts3NRilhiEGUAuTy9bHvAvqL7+P1OYW2U
         9bmIu2MwSqZV1t+1aI1BoW6gHZ7m/jeP1ZVf3cZm5OnJmjkSFRy5cOwdls24dvx1a0+Z
         bXz6XSFeWyKcPz7boJPN7UucwTK5tQCPOJxbaiX62T9swIOODlKpZjZGV/irN3WaUcBm
         SWDA==
X-Gm-Message-State: ANhLgQ1bu21HfdPK/C1PWxU3kscvG4d2oqIzJILNycXg9mLr1fD+YIyB
        SIsaP2s1l3w6z/0dbEufx+qbFZ8=
X-Google-Smtp-Source: ADFU+vt7GlXUI+dwK2GfTS1Un6SfBA2LRvKChI2EYuVBmxrE9W6bpCd7iZvCpfWOJdLf7P72Mo/S8Q==
X-Received: by 2002:a92:83ca:: with SMTP id p71mr12294078ilk.278.1585599803046;
        Mon, 30 Mar 2020 13:23:23 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i3sm4289598iow.11.2020.03.30.13.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 13:23:22 -0700 (PDT)
Received: (nullmailer pid 14413 invoked by uid 1000);
        Mon, 30 Mar 2020 20:23:21 -0000
Date:   Mon, 30 Mar 2020 14:23:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     kishon@ti.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: intel: Add documentation for Keem
 Bay eMMC PHY
Message-ID: <20200330202321.GA9386@bogus>
References: <20200316103726.16339-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200316103726.16339-2-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316103726.16339-2-wan.ahmad.zainie.wan.mohamad@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 06:37:25PM +0800, Wan Ahmad Zainie wrote:
> Document Intel Keem Bay eMMC PHY DT bindings.
> 
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> ---
>  .../bindings/phy/intel,keembay-emmc-phy.yaml  | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
> new file mode 100644
> index 000000000000..af1d62fc8323
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

> +# Copyright 2020 Intel Corporation
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/intel,keembay-emmc-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel Keem Bay eMMC PHY
> +
> +maintainers:
> +  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - intel,keembay-emmc-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: emmcclk
> +
> +  intel,syscon:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'

Make this binding  a child of the syscon and get rid of this.

> +    description:
> +      A phandle to a syscon device used to access core/phy configuration
> +      registers.
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - intel,syscon
> +  - "#phy-cells"
> +
> +examples:
> +  - |
> +    mmc_phy_syscon: syscon@20290000 {
> +          compatible = "simple-mfd", "syscon";
> +          reg = <0x0 0x20290000 0x0 0x54>;
> +    };
> +
> +    emmc_phy: mmc_phy@20290000 {

phy@...

> +          compatible = "intel,keembay-emmc-phy";
> +          reg = <0x0 0x20290000 0x0 0x54>;

Here you have overlapping register regions. Don't do that.

Given they are the same size, why do you need the syscon at all?

> +          clocks = <&mmc>;
> +          clock-names = "emmcclk";
> +          intel,syscon = <&mmc_phy_syscon>;
> +          #phy-cells = <0>;
> +    };
> -- 
> 2.17.1
> 
