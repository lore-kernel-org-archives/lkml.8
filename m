Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71FFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B239C20787
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="pD/NsOHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgEOGnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 02:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726339AbgEOGnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 02:43:21 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A9CC05BD09
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 23:43:21 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 1so594480vsl.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 23:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3u5biufGGoeHTr+TJL8nbm6kBJzdWnn/M3v0cfmw50s=;
        b=pD/NsOHgg9RiRzrmFZckLGgtKv4FNpjz6MHbVkQ9V5iKpGCmFLdD9+7u8AzgIJdOUx
         iLCRHKLZI6aJmLhCA4u/iuIgKUKWvgytv6eplSb4xpChzRdJZswwqTH+RGOkhfavvGxG
         9OqNaw3NjTjZyC88sDBbY/jwaH0osejduH/BQCz1vkUPR5thEUYmREH+nTWqA7nntaIY
         a91o5rJlHh3HrATc0gEZ14PJ7r4t+orDTaS7hQY6HaL8OQUj7ZESKlpDmHICKJ9Uwlxq
         TUnqSThoi6EzywAYWhMr/iHqiGIiOxZSwA34a4ST8G9x+/PeaFtKmyUNT/jJUwlFjN+g
         212Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3u5biufGGoeHTr+TJL8nbm6kBJzdWnn/M3v0cfmw50s=;
        b=ENCtTg1OmzF0hCBZ6iS+5Lep+VIi+RAjeFBEr08iByFm74WT+wEYVM2Tgm4jF7gtl2
         R8D9XkPZ/7rESWZjSZNXgt6umYYxpc5DgxalPk//A+QDiYK419V9L+TeEXzsOYEGS4r4
         ybta1GqFebDf4jgkQvkEHGdFwNP9aM7T8ejGO4TFnwZFvZNkiegTCKPaDOfOYWteueQY
         FWdREZpZLMDYKj+5V8PEkbVb4kbBlqAhUpzquO1xi+MTeiB8a1gV6FBJPccMTIOIUxUC
         gaZX6EPn56Pg8zbbf19K5H4BmKIgY/nVhhV8u0w7y0cES7YhqISeMLY52xKAi/XXWkVd
         7o5Q==
X-Gm-Message-State: AOAM531b3LOEcteX7Vt1nCsT1jiVMTVLard6YqTVEWclT/8QTcpmQDYl
        Qe7Tf1PPxUhYje0qTVidZit3xtp3RkWvy+8ub8/1CQ==
X-Google-Smtp-Source: ABdhPJz1EnXjRX110fk6oUizGR6vyVuia3mcnLi7d3Ga6JMGWl+PQ5YITnQDF2FwN/zC8y0AEoQFGDiVNZgyE8UHtf8=
X-Received: by 2002:a67:42c6:: with SMTP id p189mr1528692vsa.9.1589525000316;
 Thu, 14 May 2020 23:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200512132613.31507-1-narmstrong@baylibre.com> <20200512132613.31507-2-narmstrong@baylibre.com>
In-Reply-To: <20200512132613.31507-2-narmstrong@baylibre.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 15 May 2020 12:12:39 +0530
Message-ID: <CAHLCerMP2m1BfzNGoOzOe=4_zYr=i-kXOXnJ_WTN-f1L4N7SUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: mfd: add Khadas Microcontroller bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-amlogic@lists.infradead.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 6:56 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This Microcontroller is present on the Khadas VIM1, VIM2, VIM3 and Edge
> boards.
>
> It has multiple boot control features like password check, power-on
> options, power-off control and system FAN control on recent boards.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  .../devicetree/bindings/mfd/khadas,mcu.yaml   | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
>
> diff --git a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
> new file mode 100644
> index 000000000000..a3b976f101e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/khadas,mcu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Khadas on-board Microcontroller Device Tree Bindings
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +description: |
> +  Khadas embeds a microcontroller on their VIM and Edge boards adding some
> +  system feature as PWM Fan control (for VIM2 rev14 or VIM3), User memory
> +  storage, IR/Key resume control, system power LED control and more.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - khadas,mcu # MCU revision is discoverable
> +
> +  "#cooling-cells": # Only needed for boards having FAN control feature
> +    const: 2
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      khadas_mcu: system-controller@18 {
> +        compatible = "khadas,mcu";
> +        reg = <0x18>;
> +        #cooling-cells = <2>;
> +      };
> +    };
> --
> 2.22.0
>
