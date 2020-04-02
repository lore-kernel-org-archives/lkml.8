Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4500C10F26
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 04:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C426206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 04:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="j61IBLy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgDBEuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 00:50:14 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:62587 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgDBEuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 00:50:14 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48t9bk29zHzHd;
        Thu,  2 Apr 2020 06:50:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585803012; bh=AZFWmxf+W94PYJO5Khiddclftx0rXCFefv4IppCDpD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j61IBLy3190KYqax6Vw3iprvNBDxnSH18xh8U+n++/Cm713gnvYj36b8pI7M6BVEb
         pgT5fOM7TXfztGz5OK1s//NmiN0auXmXuZJfeaipSNq1BnFnIiQvf/wAtyGH3miszo
         9U4NMXeZXPaxiJYUahnNFU01ocu8Ejd7fM0lRlYqo6Be/xZ4h92YVO/nl6fR6gYeXv
         93lbtOjD/LZ8pRldU3Kgt8MOWx15e/bYbORF2r363hMnLqEL5VDK6RDSJ59d3MKk5i
         L5F1vYzRgS2zv4ZqSSindFE7dSwr4A/Q03TtGFujRpzRXHgIjYfBniIbCVeHCyLpxw
         nzsgTbmnE/ffg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 2 Apr 2020 06:50:08 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Pedro =?iso-8859-2?Q?=C2ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/6] dt-bindings: ARM: tegra: Add ASUS Google Nexus 7
Message-ID: <20200402045008.GB11124@qmqm.qmqm.pl>
References: <20200331214327.6496-1-digetx@gmail.com>
 <20200331214327.6496-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200331214327.6496-6-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 12:43:26AM +0300, Dmitry Osipenko wrote:
> Add a binding for the Tegra30-based ASUS Google Nexus 7 tablet device.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/tegra.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
> index 7fd0b66c69b2..fb3bbf7a5fb4 100644
> --- a/Documentation/devicetree/bindings/arm/tegra.yaml
> +++ b/Documentation/devicetree/bindings/arm/tegra.yaml
> @@ -62,6 +62,13 @@ properties:
>                - toradex,colibri_t30-eval-v3
>            - const: toradex,colibri_t30
>            - const: nvidia,tegra30
> +      - items:
> +          - const: asus,grouper
> +          - const: nvidia,tegra30
> +      - items:
> +          - const: asus,tilapia
> +          - const: asus,grouper
> +          - const: nvidia,tegra30
>        - items:
>            - enum:
>                - nvidia,dalmore

Is it really necessary to list every possible device using a SoC chip?
Wouldn't it be enough to just list SoC value nvidia,tegraXYZ and allow
any other supplemental "compatibles"?

Best Regards,
Micha³ Miros³aw
