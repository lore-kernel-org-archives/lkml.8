Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DDFC10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA5D24655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583793006;
	bh=Ug0zeSOe7y0l/++Oomd/cMJ1Mcz3Y3Ukl281K3wA12M=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=gDwdSggUMnOqJuHIWYcKrdFz3k94FF+vZCdFkNvU+EQwLZoH6u+JkAj6SY/OrrQR5
	 eTElxMJcGvtSYJQWPoSGmnvgu7ur0K5TJ+fM6OEstc7L1p3p3UfaKBnqIVM466iukA
	 aNQUAUxtmvwyr8h06uMRlBOfNh/EWLnuTPGin+z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgCIWaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbgCIWaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:30:04 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 114C324649;
        Mon,  9 Mar 2020 22:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583793004;
        bh=Ug0zeSOe7y0l/++Oomd/cMJ1Mcz3Y3Ukl281K3wA12M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=j1vLlyPLYfZLdGfvn6AnKPWxKGQgcM1vmYd0y5UV7xABU8qlsm+kOVo3HiPKHFBCj
         qAFN8+em2FucvCPA1qLPigqSjKVfpEJqt3b8Md8AJd+7tAh3c9IOFNxBVUd7NiN42/
         nX7mDD/yRRy7DjiZTxbupR/bChRfUQQwzrCO/6GY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200309171653.27630-3-dinguyen@kernel.org>
References: <20200309171653.27630-1-dinguyen@kernel.org> <20200309171653.27630-3-dinguyen@kernel.org>
Subject: Re: [PATCHv2 2/3] dt-bindings: documentation: add clock bindings information for Agilex
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mturquette@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com
To:     Dinh Nguyen <dinguyen@kernel.org>, linux-clk@vger.kernel.org
Date:   Mon, 09 Mar 2020 15:30:03 -0700
Message-ID: <158379300325.149997.17942016518688387697@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2020-03-09 10:16:52)
> diff --git a/Documentation/devicetree/bindings/clock/intc,agilex.yaml b/D=
ocumentation/devicetree/bindings/clock/intc,agilex.yaml
> new file mode 100644
> index 000000000000..bd5c4f590e12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/intc,agilex.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/intc,agilex.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel SoCFPGA Agilex platform clock controller binding
> +
> +maintainers:
> +  - Dinh Nguyen <dinguyen@kernel.org>
> +
> +description: |
> +  The Intel Agilex Clock controller is an integrated clock controller, w=
hich
> +  generates and supplies to all modules.
> +
> +  This binding uses the common clock binding[1].
> +  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt

I think you can remove this last sentence, and drop the | on the
description because formatting doesn't matter.

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - intel,agilex-clkmgr
> +

Just use

  compatible:
    const: intel,agilex-clkmgr

> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +examples:
> +  # Clock controller node
> +  - |
> +       clkmgr: clock-controller@ffd10000 {
> +               compatible =3D "intel,agilex-clkmgr";
> +               reg =3D <0xffd10000 0x1000>;
> +               #clock-cells =3D <1>;

Does it consume any clks?

> +       };
> +
> +  # External clocks

Everything below here is not necessary and shouldn't be in the binding.
