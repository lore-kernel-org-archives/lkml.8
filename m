Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214B7C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BA4214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 02:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580437543;
	bh=ty67owHtadtFg9nnrN1OwNXzpUqlltQzPCx04Ed6Zk8=;
	h=In-Reply-To:References:Subject:To:From:Cc:Date:List-ID:From;
	b=oPvIPO8A407/9ERLcRGdGU69aCdseMU93YyJNjOru+hzDUNmX6uZTZCJUDAVi0luG
	 iVEV9vSXFuoDruzkWVgEJrgypLMOxSHOGhr9feA1vOQHPUgpW6zSZSHGZwKrVXRfvy
	 7/erka5Z8ZlDtG0WLuPM5Ma7t9YKqMJFH4cZzz/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgAaCZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 21:25:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbgAaCZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 21:25:42 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3853C2067C;
        Fri, 31 Jan 2020 02:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580437541;
        bh=ty67owHtadtFg9nnrN1OwNXzpUqlltQzPCx04Ed6Zk8=;
        h=In-Reply-To:References:Subject:To:From:Cc:Date:From;
        b=MMclK2YGVfwmw6Pl5hsWLtKkU6NKozsNdhjroha6gJRmCcy8NW/EzlnZipFFgpHK5
         +zAVQaXOPOyX1oXeeeGEEF0LrKftKD7p9VvT2JabX36I9ZR5YE8W3HbtLmjBHWv7lA
         bbLm9NYbA3Jr67zqQxOrJcsxvIsXkqm5UUS1HvvE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <24933f5f1c48a891f9c05c7292117108fc880932.1580374761.git.rahul.tanwar@linux.intel.com>
References: <cover.1580374761.git.rahul.tanwar@linux.intel.com> <24933f5f1c48a891f9c05c7292117108fc880932.1580374761.git.rahul.tanwar@linux.intel.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: clk: intel: Add bindings document & header file for CGU
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org, robh@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        yixin.zhu@linux.intel.com, cheol.yong.kim@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
User-Agent: alot/0.8.1
Date:   Thu, 30 Jan 2020 18:25:40 -0800
Message-Id: <20200131022541.3853C2067C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2020-01-30 01:04:03)
> Clock generation unit(CGU) is a clock controller IP of Intel's Lightning
> Mountain(LGM) SoC. Add DT bindings include file and document for CGU clock
> controller driver of LGM.
>=20
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---

Please reorder this to be first instead of second in the series.

>  .../devicetree/bindings/clock/intel,cgu-lgm.yaml   |  40 +++++
>  include/dt-bindings/clock/intel,lgm-clk.h          | 165 +++++++++++++++=
++++++
>  2 files changed, 205 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/intel,cgu-lgm=
.yaml
>  create mode 100644 include/dt-bindings/clock/intel,lgm-clk.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml b=
/Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
> new file mode 100644
> index 000000000000..e9649fe75435
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/clock/intel,cgu-lgm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Lightning Mountain SoC's Clock Controller(CGU) Binding
> +
> +maintainers:
> +  - Rahul Tanwar <rahul.tanwar@linux.intel.com>
> +
> +description: |
> +  Lightning Mountain(LGM) SoC's Clock Generation Unit(CGU) driver provid=
es
> +  all means to access the CGU hardware module in order to generate a ser=
ies
> +  of clocks for the whole system and individual peripherals.

Can you include a pointer to include/dt-bindings/clock/intel,lgm-clk.h?

> +
> +properties:
> +  compatible:
> +    const: intel,cgu-lgm
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +examples:
> +  - |
> +    cgu: clock-controller@e0200000 {
> +        compatible =3D "intel,cgu-lgm";
> +        reg =3D <0xe0200000 0x33c>;
> +        #clock-cells =3D <1>;
> +    };
> +
> +...
> diff --git a/include/dt-bindings/clock/intel,lgm-clk.h b/include/dt-bindi=
ngs/clock/intel,lgm-clk.h
> new file mode 100644
> index 000000000000..d6797521d36a
> --- /dev/null
> +++ b/include/dt-bindings/clock/intel,lgm-clk.h
[...]
> +
> +/* PLL0CZ */
> +#define LGM_CLK_CM             25
> +#define LGM_CLK_IC             26
> +#define LGM_CLK_SDXC3          27
> +
> +/* PLL0B */
> +#define LGM_CLK_NGI            30
> +#define LGM_CLK_NOC4           31
> +#define LGM_CLK_SW             32
> +#define LGM_CLK_QSPI           33
> +#define LGM_CLK_CQEM           LGM_CLK_SW
> +#define LGM_CLK_EMMC5          LGM_CLK_NOC4
> +
> +/* PLL1 */
> +#define LGM_CLK_CT             35
> +#define LGM_CLK_DSP            36
> +#define LGM_CLK_VIF            37
> +
> +/* LJPLL3 */
> +#define LGM_CLK_CML            40
> +#define LGM_CLK_SERDES         41
> +#define LGM_CLK_POOL           42
> +#define LGM_CLK_PTP            43
> +
> +/* LJPLL4 */
> +#define LGM_CLK_PCIE           45
> +#define LGM_CLK_SATA           LGM_CLK_PCIE

What is with the aliases?

