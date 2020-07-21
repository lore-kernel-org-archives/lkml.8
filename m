Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D58C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97E312073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595346854;
	bh=7YwE6zmlolnXrIDvIovVwCoGjPItA6t4+svrJdYth50=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sd/FkBDGVzrh7rzERdqvcixBftJm+hAU72gh+Fzk8B5IfmJibmqfJQQfndqf/iMr2
	 2H+LR5RSdSfTbRRZslynrpK3e2z5/S6h/aDGlvsXlIilZNKC0G3U3lqR3F6OTe/WQ2
	 Uy4B78MWXP6STBegoDLsM56k4QlynEhma5AhbxRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgGUPyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:54:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgGUPyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:54:12 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CEED2077D;
        Tue, 21 Jul 2020 15:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595346851;
        bh=7YwE6zmlolnXrIDvIovVwCoGjPItA6t4+svrJdYth50=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Iz3vmYbwKAknWwvSnAsWrx+kKYjVj+9BXEirJaOU0WEd69APuiYoNgOWkdVL4dehx
         7LyjiRy/IEXxM5doRoqtBesB4/Z/bt+j6izRV6hpBBYQKSEEuwmO+kh1kQDES/PGm1
         yOkFs0ipS/hmz7seHC1GeZSZuABUhnhMy+FXvy2E=
Received: by mail-oo1-f43.google.com with SMTP id t6so4004575ooh.4;
        Tue, 21 Jul 2020 08:54:11 -0700 (PDT)
X-Gm-Message-State: AOAM533I39dDrjEbqyNVQTOxwhLaRjTIJaF/pn8RNGVbWyqpTZNnazFW
        qAAdq1vEEPNFUSt68h53fxGmjBqQM67siU30xw==
X-Google-Smtp-Source: ABdhPJxAzM/2DwnEuB4r4A7OI1g6uyx9kfxGkiJ8IopPkvBszfpb9C0ul1jz71QKkma5Db/cDeh3Y6zvX2E0GJ+/ELE=
X-Received: by 2002:a4a:ae07:: with SMTP id z7mr24532077oom.25.1595346850730;
 Tue, 21 Jul 2020 08:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200717234800.9423-1-s-anna@ti.com> <20200717234800.9423-4-s-anna@ti.com>
In-Reply-To: <20200717234800.9423-4-s-anna@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 21 Jul 2020 09:53:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLnPQNZ7KhqfPwiMCJESYrD9_UN2gwc_hj9=WOJM8NQQw@mail.gmail.com>
Message-ID: <CAL_JsqLnPQNZ7KhqfPwiMCJESYrD9_UN2gwc_hj9=WOJM8NQQw@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] dt-bindings: remoteproc: Add common TI SCI rproc bindings
To:     Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 5:48 PM Suman Anna <s-anna@ti.com> wrote:
>
> Add a bindings document that lists the common TI SCI properties
> used by the K3 R5F and DSP remoteproc devices.
>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v4: Addressed both of Rob's review comments on ti,sci-proc-ids property
> v3: https://patchwork.kernel.org/patch/11602317/
>
>  .../bindings/remoteproc/ti,k3-sci-proc.yaml   | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml
>
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml
> new file mode 100644
> index 000000000000..0dca2ffdbc48
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/ti,k3-sci-proc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common TI K3 remote processor device bindings
> +
> +maintainers:
> +  - Suman Anna <s-anna@ti.com>
> +
> +description: |
> +  The TI K3 family of SoCs usually have one or more remote processor sub-systems
> +  like the dual-core R5F sub-system or a C66x or C71x DSP processor subsystem.
> +  The device management of these remote processors is managed by a dedicated
> +  System Processor, and the communication with that processor is managed through
> +  the TI-SCI protocol.
> +
> +  Each remote processor device node should define a common set of properties
> +  that allows the System Processor firmware to perform the device management
> +  such as powering the IPs, asserting/deasserting the resets for each of these
> +  processors.
> +
> +properties:
> +  ti,sci:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Should be a phandle to the TI-SCI System Controller node
> +
> +  ti,sci-dev-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Should contain the TI-SCI device id corresponding to the remote processor
> +      core. Please refer to the corresponding System Controller documentation
> +      for valid values.

These also apply on Lokesh's series converting ti,sci-int[ra]
bindings. Please rework to use for both.

> +
> +  ti,sci-proc-ids:
> +    description: Should contain a single tuple of <proc_id host_id>.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    items:
> +      - description: TI-SCI processor id for the remote processor device
> +      - description: TI-SCI host id to which processor control ownership
> +                     should be transferred to
> +
> +required:
> +  - ti,sci
> +  - ti,sci-dev-id
> +  - ti,sci-proc-ids
> --
> 2.26.0
>
