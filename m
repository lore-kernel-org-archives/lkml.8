Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C466FC3404C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F29D24658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582081096;
	bh=zLZw1qR/XpXYBmvugwhE5yh5SqRSUw18nixQc8D5mtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EkxKl8QT/76trNXvEVjOnpV9HDn0cC4Ks6DaxDKj/r+aWxq9hvhADKStkcJRSyhIG
	 It8kYJCMuJVYSHo9D4kLVDwhbiREWjg69yeIa8LTZO+bz3YD1I56IqCL0dUpVo/RO/
	 N23iBT9Kw/gCkKLpYCfHkW12nqUAn6mAMXswP5/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgBSC6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:58:16 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35256 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgBSC6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:58:15 -0500
Received: by mail-ot1-f67.google.com with SMTP id r16so21761087otd.2;
        Tue, 18 Feb 2020 18:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xTGQmxUmNRth+yRhSKHtoUgcE+23rlmrBG/UqSF57C4=;
        b=XNA29+YmzuxvM/slxw06R+9X+34E8Xau2m71G2+s1ko/IUXtCj7yhIvKr8gom8XrzA
         LwpFydzHmiwzLNNb7UjGmYl4idD0+kMVz7Wn6m73Tr1+4pMi3P11Zip9UHc+/zxrPK5u
         J4fNJXu0hqkAdj2hjzXkOyklszD2G5kcm6QBIF1jPr9PSQFAw6qdalmRRqgfaF2B7GQ+
         P8VE0kdyAxdiclF98DEIceFEnqjrLci/CsK/Dorugef4BpPilYhd2m4V0JW6Qe+f2Htk
         nSc0Zu7XKjZJyHr13Ldw3/Ky2FV31hK0QpUEkLnSZeSNIxNzn0yjNjnc4Z32qvBthkCa
         fP5w==
X-Gm-Message-State: APjAAAVuMWQ7rJhj+rbwsP82FC0POvKTDeTv5lnRzTQal4JG5SNcDuNF
        Ld8rAo/AeeSZrVH+NJ04aA==
X-Google-Smtp-Source: APXvYqw1L6GCZna8YMWf4yMNAkVw7UgscE3jBjEI1Do4b3teVIqY+vAlfCJe0QT1lA33JTK7rqs3sA==
X-Received: by 2002:a9d:69ce:: with SMTP id v14mr18336960oto.248.1582081093490;
        Tue, 18 Feb 2020 18:58:13 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r2sm204259otk.22.2020.02.18.18.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 18:58:12 -0800 (PST)
Received: (nullmailer pid 8516 invoked by uid 1000);
        Wed, 19 Feb 2020 02:58:11 -0000
Date:   Tue, 18 Feb 2020 20:58:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: Add binding documentation for
 TI syscon gate clock
Message-ID: <20200219025811.GA20054@bogus>
References: <20200215141724.32291-1-vigneshr@ti.com>
 <20200215141724.32291-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215141724.32291-2-vigneshr@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2020 at 07:47:23PM +0530, Vignesh Raghavendra wrote:
> Add dt bindings for TI syscon gate clock driver that is used to control
> EHRPWM's TimeBase clock (TBCLK) on TI's AM654 SoC.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  .../bindings/clock/ti,am654-ehrpwm-tbclk.yaml | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
> new file mode 100644
> index 000000000000..3bf954ecb803
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/ti,am654-ehrpwm-tbclk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI syscon gate clock driver

Bindings are for h/w blocks, not drivers.

> +
> +maintainers:
> +  - Vignesh Raghavendra <vigneshr@ti.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: ti,am654-ehrpwm-tbclk
> +      - const: syscon

Why is this a syscon? Are there other functions or it's just the easy 
way to get a regmap.

> +
> +  "#clock-cells":
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - reg
> +
> +examples:
> +  - |
> +    ehrpwm_tbclk: syscon@4140 {
> +        compatible = "ti,am654-ehrpwm-tbclk", "syscon";
> +        reg = <0x4140 0x18>;
> +        #clock-cells = <1>;
> +    };
> -- 
> 2.25.0
> 
