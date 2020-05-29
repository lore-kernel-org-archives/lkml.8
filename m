Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8D8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7D520814
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590720813;
	bh=4/seuMEFHvBKGrvEO2NqQicF1ccnp0eqBMjAbN8ebP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l4WHbniPQq6b4KaKAvBuQj3rXB8U6HhZoLp1mBr3QlxvVtcqhCvV2UuIkQKfspF18
	 HHRdfXuw1htTFn6xZsYguZ0OflVWyteaJcCBMiYAwUUNJrmSNMx1i8EHZAZE25shd1
	 1GHr9gse8FEclNjbwzVNbB5MvWSv4FjCIorhANDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391653AbgE2Cxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:53:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:47039 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391617AbgE2Cx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:53:29 -0400
Received: by mail-io1-f66.google.com with SMTP id j8so744816iog.13;
        Thu, 28 May 2020 19:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BB4lLcpMa2PslwRty00Xdd8pENQOq/huAzPVj8i1Pbw=;
        b=CFO+EpDiAnE8XOOrAhksas98omJtfQE75dOx30FWBZQ32PtSwGEHNhMY0Bf8Ppj/5B
         DOyxub/L1FVE1pMwCS6K1yZXxrlSgS+3wN4CQ4457zHf+jq9dklKgYDfF0Um0xM9CfTd
         Bxfd+lUWyUgp85q7liu47+o94bC4gfKB0OH5TB5CK/l4Z83kP/L46kGrksIS1zq0QIxQ
         xoLNHU7UmyK5IYCMcxllTZxMNPBBYqrmCzDszs/pxJb5nN6H4J+iv14tdbFXibXp092x
         cRmMsvtG1JQo7JIUaovNeUHFmFLSW5Inlh6y5N9GXO+v98EmGdYvV1tmy17/NzSo0af5
         rbZw==
X-Gm-Message-State: AOAM530rHbNuD5JltRca5YbkJRe1HsjPtZJX0y6NDBUSERBUy4Wk1VZr
        RUpLtgrF2AxRX8F71XhxdKvJ5Lvoxg==
X-Google-Smtp-Source: ABdhPJxL8YRfUnqzI0MeilUY+kZQmhRhFFfqAq5VdSU6IuES4gLxlGvgMmEi6ls8ReOorou28Z5Sbw==
X-Received: by 2002:a02:3344:: with SMTP id k4mr5156192jak.140.1590720808120;
        Thu, 28 May 2020 19:53:28 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w26sm4382292ill.19.2020.05.28.19.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 19:53:27 -0700 (PDT)
Received: (nullmailer pid 1178822 invoked by uid 1000);
        Fri, 29 May 2020 02:53:26 -0000
Date:   Thu, 28 May 2020 20:53:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.trumtrar@pengutronix.de, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, Linux-imx@nxp.com,
        kernel@pengutronix.de, mturquette@baylibre.com,
        s.hauer@pengutronix.de, shc_work@mail.ru,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 8/9] dt-bindings: clock: Convert i.MX21 clock to
 json-schema
Message-ID: <20200529025326.GA1178771@bogus>
References: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
 <1590650879-18288-9-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590650879-18288-9-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 15:27:58 +0800, Anson Huang wrote:
> Convert the i.MX21 clock binding to DT schema format using json-schema,
> can NOT find any CCM interrupt info from reference manual and DT file,
> so interrupts property is removed from original binding doc.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx21-clock.txt      | 27 ------------
>  .../devicetree/bindings/clock/imx21-clock.yaml     | 49 ++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx21-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx21-clock.yaml
> 

Applied, thanks!
