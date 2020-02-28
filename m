Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57912C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F13D2469C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O8spUvUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgB1Qrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:47:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42297 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgB1Qrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:47:40 -0500
Received: by mail-pl1-f193.google.com with SMTP id u3so1445893plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 08:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=+KzqSGM0wpuOnmk8ah4jnq8pi4ESPMMLwFzMCHl6UjI=;
        b=O8spUvUXHq3YyQ5dhzmYqojrMmbdIDtrlBgq18mdZ0BO7XxAuMF21FuAf2g/3NRtlY
         xRv1fwJbNizlRD1p1BqQ8bUkfgzL2U5jFFNCH4jfWO0t1TtoBtqefwJSOF1Dta1kTEgc
         IFus2y6k+yt0st8EzPWCqU7E6mVm7WJZjBzMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=+KzqSGM0wpuOnmk8ah4jnq8pi4ESPMMLwFzMCHl6UjI=;
        b=kbSObTef8zK/K2PkWCaoXvtQu86ixx3++g3Ehj3GtQg3pWNvacuZGeqCAA53fLOigK
         nndu27IuAcb1rvsVazuclKJw4Fy/sYTIIvjUoQ2dYBEhj5I0r/k756ObwgvHCWLkHreu
         uMSRgwJIqW1k89Qk9ECeFg/JOclmZRM5xO5WOntRATeAy57ZWsiB71DmgSaje2XqdUUj
         U6j5zZgiuyYe78ED8wPhlbFl0OFGAq0aCQLK77xACNDhaCclS+RgVOqIbRzKwKpUzJfC
         PiqpvuvxnNbYLoGH+a0whaVVUkHhoOm+DcwN+xsOG0bRZ/uYLRR3kuuESxKSujTRkFJj
         GrBQ==
X-Gm-Message-State: APjAAAVqt48EAVEuCnb2OlRk5Zn8GuP98/gljXBZNCRaGM7OYeIgpYvj
        3dhrItOSyb0i0Nz53Tm1sebUH3g9j/4=
X-Google-Smtp-Source: APXvYqzhf39xvY42bpSyssbKJR6CFEPeIhIIM3kI2b3JMh9C2G1bP/qcgrZGXTcvlo5oEWdoECjUDw==
X-Received: by 2002:a17:90a:1f8d:: with SMTP id x13mr5791534pja.27.1582908458748;
        Fri, 28 Feb 2020 08:47:38 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v8sm11463303pfn.172.2020.02.28.08.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 08:47:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1582274986-17490-2-git-send-email-mkshah@codeaurora.org>
References: <1582274986-17490-1-git-send-email-mkshah@codeaurora.org> <1582274986-17490-2-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: Introduce soc sleep stats bindings for Qualcomm SoCs
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        devicetree@vger.kernel.org, Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, mka@chromium.org
Date:   Fri, 28 Feb 2020 08:47:37 -0800
Message-ID: <158290845710.4688.3557819013834887314@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-02-21 00:49:43)
> diff --git a/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.y=
aml b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
> new file mode 100644
> index 00000000..50352a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/soc/qcom/soc-sleep-stats.yam=
l#

Drop 'bindings' from above?

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. (QTI) SoC sleep stats bindings
> +
> +maintainers:
> +  - Maulik Shah <mkshah@codeaurora.org>
> +  - Lina Iyer <ilina@codeaurora.org>
> +
> +description: |
> +  Always On Processor/Resource Power Manager maintains statistics of the=
 SoC
> +  sleep modes involving powering down of the rails and oscillator clock.
> +
> +  Statistics includes SoC sleep mode type, number of times low power mod=
e were
> +  entered, time of last entry, time of last exit and accumulated sleep d=
uration.
> +  SoC sleep stats driver provides debugfs interface to show this informa=
tion.

Please remove this last line. It is a Linuxism that doesn't belong in DT
bindings. And then make it one paragraph and drop the | because
formatting doesn't need to be maintained.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,rpmh-sleep-stats
> +      - qcom,rpm-sleep-stats
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  # Example of rpmh sleep stats
> +  - |
> +    rpmh_sleep_stats: soc-sleep-stats@c3f0000 {
> +      compatible =3D "qcom,rpmh-sleep-stats";
> +      reg =3D <0 0xc3f0000 0 0x400>;
> +    };

I see that on sc7180 aoss-qmp is overlapping with this region.


	aoss_qmp: qmp@c300000 {
		compatible =3D "qcom,sc7180-aoss-qmp";
		reg =3D <0 0x0c300000 0 0x100000>;

So is this register region really something more like a TCM or RAM area
where rpmh combines multiple software concepts into one hardware memory
region? The aoss-qmp driver talks about message RAM, so I think this
sleep stats stuff is a carveout of the RPMh message RAM. It seems OK if
we want to split that message RAM up into multiple DT nodes, but then
we'll need to reduce the reg size for the aoss-qmp node.

Finally, the node name 'soc-sleep-stats' is generic, but I wonder why we
couldn't name the node 'tcm' or 'memory' or 'msgram'. Similarly for the
qmp node it fits better DT style to have the node be something generic.

> +  # Example of rpm sleep stats
> +  - |
> +    rpm_sleep_stats: soc-sleep-stats@4690000 {
> +      compatible =3D "qcom,rpm-sleep-stats";
> +      reg =3D <0 0x04690000 0 0x400>;
> +    };
> +...
