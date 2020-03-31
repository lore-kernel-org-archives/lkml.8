Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BCFC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C652220BED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585676426;
	bh=KR3B5W4EHudmbK6aJ68bTF93QLBBpkya3pFrBNvSraE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=08cSJ3lrJhr91asG15PXzQE6g4N+3cmDVN1HDKiSamODF078NYAC3lhVe0wHiaWI5
	 ERyTPZWtMjNE9VxQFqsDbI8WCqMAi8SkbFRn0ZM0EFiNhpK7yCYY7oq54N7588Ekjh
	 5dIvPZpnryOhTl3DpP1lLEScCut0HFcmCG/CY/Uk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgCaRk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:40:26 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42279 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgCaRkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:40:25 -0400
Received: by mail-il1-f196.google.com with SMTP id f16so20258268ilj.9;
        Tue, 31 Mar 2020 10:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6aBwK6Jn54nXE60sLLoNIliyeSRRLFSDoeTTM2YH+9c=;
        b=p2UuW9iqhJoLKURFkEt/hXCK1/KLrIjbcdXJCtM0gzPz0DnSLun87o7k5VLxQOkb9h
         qyQFWCtrYCXNK10LbWMNIrzr4tcDnbJFI1QhokkpzdHVYmwB8az3QrOWlYGQn0E8owlq
         3eIjrW1+GUdDZ8ZigMXbw0TmM1hxu+2zR0X4xEK+1/mw/jq4dJ/SPq4L1GyJtsap9hO/
         8SQV2Pvfq5ZSt3yw9EmHq0bjrCZmAnWkFGE8wSUcQY2wgr6x2MqNYbfw4LSet2Io30NI
         esCtH4880tZF03TImfj9ndXJb50KHdXK/NDhBRP4qpfkGJW0/pbXoGBYvb+yRrdy26qv
         Yueg==
X-Gm-Message-State: ANhLgQ0gvOwWLJfA9MqgIu8oKzx7IRcvvwmFbgme0RMRD4f+2Wa1PFek
        ueulsxAWoXm8UKODUYYBeQ==
X-Google-Smtp-Source: ADFU+vtfh2X3JGSeIIM+yl3ExvWxhpP3OLXDWjVv5Kk09AwSb03T23fXxucTtsvMEsvZVDB/DlV5Xw==
X-Received: by 2002:a92:24f:: with SMTP id 76mr2733651ilc.178.1585676424207;
        Tue, 31 Mar 2020 10:40:24 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k11sm2853756iom.43.2020.03.31.10.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:40:23 -0700 (PDT)
Received: (nullmailer pid 6382 invoked by uid 1000);
        Tue, 31 Mar 2020 17:40:21 -0000
Date:   Tue, 31 Mar 2020 11:40:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     mark.rutland@arm.com, jassisinghbrar@gmail.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mailbox: Add the Spreadtrum mailbox
 documentation
Message-ID: <20200331174021.GA4288@bogus>
References: <600e0b027a4e62a4aea8900e5a1e95e3e14b10f0.1584943873.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <600e0b027a4e62a4aea8900e5a1e95e3e14b10f0.1584943873.git.baolin.wang7@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 02:13:46PM +0800, Baolin Wang wrote:
> From: Baolin Wang <baolin.wang@unisoc.com>
> 
> Add the Spreadtrum mailbox documentation.
> 
> Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
> Changes from v1:
>  - Add 'additionalProperties'.
>  - Split description for each entry.
> ---
>  .../devicetree/bindings/mailbox/sprd-mailbox.yaml  | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
> new file mode 100644
> index 0000000..0848b18
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/mailbox/sprd-mailbox.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Spreadtrum mailbox controller bindings
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sprd,sc9860-mailbox
> +
> +  reg:
> +    items:
> +      - description: inbox registers' base address
> +      - description: outbox registers' base address

> +    minItems: 2

This is redundant, drop it.

> +
> +  interrupts:
> +    items:
> +      - description: inbox interrupt
> +      - description: outbox interrupt
> +    minItems: 2

Same here.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
