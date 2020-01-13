Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA3EC33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 03:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4FC206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 03:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733298AbgAMDeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 22:34:19 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46028 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733148AbgAMDeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 22:34:19 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so8293900ioi.12;
        Sun, 12 Jan 2020 19:34:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ffBYbF6/PC12NpCYkWntxV4lk513bxtk2FgtdBCsBmQ=;
        b=C7/E6x5P6vh19njQAfaGsEennPeC8xHeejQkW/BX3cfVOhNttyESzdgWWasF8z2uaN
         xP5SgW7D+oZicBeo1jcnNTQ4qDOwA8R5WLKLZbVydF3hBZJ0mAHkSoycDPxpqzSBP0kY
         KqFlorb7WN3L71PHu+r3GHA4nrbX5mdz3nG7zh+X+qh28bMrIL3+ob4YO+ynl9QGgB2t
         CZrhTTBnI7YdS5xZTZt5I0yTIbebPJhWomzSGEq+w2hHzVD6F9JQSnmE3WzHkT314nqO
         DC2m6xPLoVPbj73yDV7Q6ribk/DVX5RqPRXHbROLgwRMfH04zPuPHKPg7j5Y4P/53c5S
         X4Uw==
X-Gm-Message-State: APjAAAVniLK6shs0fOi4W7dezlMcFNgds0YwilmeFQWdiHzLgvfcQEJ5
        RSLCLUwIGf362CWCHSAWJtPoOo6JmdFxZ011kVE=
X-Google-Smtp-Source: APXvYqwPavU7a+EHwc2v+EejAYM+yaQI5RXfgzNpiT4JygOFlRG1Wg2rAvx04hqUsA2+meqav17LspOx0+rqxl0Rlhk=
X-Received: by 2002:a6b:b457:: with SMTP id d84mr10382847iof.35.1578886458664;
 Sun, 12 Jan 2020 19:34:18 -0800 (PST)
MIME-Version: 1.0
References: <20200112081416.722218-1-jiaxun.yang@flygoat.com> <20200112081416.722218-9-jiaxun.yang@flygoat.com>
In-Reply-To: <20200112081416.722218-9-jiaxun.yang@flygoat.com>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Mon, 13 Jan 2020 11:39:28 +0800
Message-ID: <CAAhV-H7USNAXTQ8H8LMvpu_E9OVmSN91A=oM9f56=X5_sf2=5g@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] dt-bindings: mips: Add loongson boards
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     "open list:MIPS" <linux-mips@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.co>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jiaxun,

On Sun, Jan 12, 2020 at 4:15 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> Prepare for later dts.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  .../bindings/mips/loongson/devices.yaml       | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/loongson/devices.yaml
>
> diff --git a/Documentation/devicetree/bindings/mips/loongson/devices.yaml b/Documentation/devicetree/bindings/mips/loongson/devices.yaml
> new file mode 100644
> index 000000000000..3c7c59a29c1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/loongson/devices.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mips/loongson/devices.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson based Platforms Device Tree Bindings
> +
> +maintainers:
> +  - Jiaxun Yang <jiaxun.yang@flygoat.com>
> +description: |
> +  Devices with a Loongson CPU shall have the following properties.
> +  Note that generic device is used for built-in dtbs and will be
> +  patched during boot on firmware without OF support.
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +
> +      - description: Generic Loongson3 4Core + RS780E
> +        items:
> +          - const: loongson,loongson3-4core-780e
> +
> +      - description: Generic Loongson3 8Core + RS780E
> +        items:
> +          - const: loongson,loongson3-8core-780e
Please use loongson3-4core-rs780e and loongson3-8core-rs780e, thanks.

Huacai
> +...
> --
> 2.24.1
>
