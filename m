Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755D4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D042075F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590720683;
	bh=6yMlPUUvMq6vPUTtngghgbys3FCdPBPTs6Z4w3wff8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2Wh6ZSbnrCB9Bx7L0zhzO/lVSkSGZEtBPwcp40bjNcRNUd9tOjDxjyPJgI7xEbc1a
	 o3ZdZept/baYx3eEulZ1n61wC/wbyWwbsIUbKkOoCN84M5ekzstpwuAGD853pocOBR
	 qpCroJaxeLdHrGtKRu6rbF/hgkdqnwj0yOSKc5u0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391616AbgE2CvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:51:21 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46855 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389013AbgE2CvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:51:17 -0400
Received: by mail-io1-f66.google.com with SMTP id j8so740853iog.13;
        Thu, 28 May 2020 19:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5gXBJBmh9TexUjoDHc80Ri58ocLwBITZgHH5HYAV6ao=;
        b=qFRgO0PIz0oP/6o6qp/On/26IY969R55Tq2aS+mpCO51kUrFnaS+4zACGmnOPKjN3Q
         S9aazKHjBcFkKCnZ1vvqa2mOqY0bOq+5wVOFv6AaRoVa5tN35DL86R0hN5ynKpfuFCr+
         Ffu9r6R6sTh4Zyny75epzyuNXiRnXcPxziSUTqx+CRW3H3Iqce2A2bmpz978dM5LPiS1
         fqpDBm04T6JOOLMUZ3kyynlfu05CdoRKqUWcChMJsj98PW56qtSbw+N66cgbTAnJnmw+
         zsPi074fxaePlwXdf0rflcB3FqlzD54eOLB81Dcs6Bs7bQehCxzA0zoWTgN0sojWinE1
         9tuQ==
X-Gm-Message-State: AOAM533efXqP/tC2S8C0PzOSSMN5ndJM63xx8maveRA3OU2vcUAnPktp
        +jBmP+nvj4D145VZbbZlYg==
X-Google-Smtp-Source: ABdhPJyczF+EzZ2p2WAHUbXJq77+C4fuaCMaESmjiStEvnYn5eXQAn5rp5n3UR8adqwF57u3dlU39Q==
X-Received: by 2002:a5d:9f4d:: with SMTP id u13mr5000884iot.113.1590720676442;
        Thu, 28 May 2020 19:51:16 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id i15sm3625216ils.74.2020.05.28.19.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 19:51:15 -0700 (PDT)
Received: (nullmailer pid 1175110 invoked by uid 1000);
        Fri, 29 May 2020 02:51:14 -0000
Date:   Thu, 28 May 2020 20:51:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, Linux-imx@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, shc_work@mail.ru, s.trumtrar@pengutronix.de,
        devicetree@vger.kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        festevam@gmail.com, sboyd@kernel.org
Subject: Re: [PATCH 4/9] dt-bindings: clock: Convert i.MX28 clock to
 json-schema
Message-ID: <20200529025114.GA1172329@bogus>
References: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
 <1590650879-18288-5-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590650879-18288-5-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 15:27:54 +0800, Anson Huang wrote:
> Convert the i.MX28 clock binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx28-clock.txt      |  93 -----------------
>  .../devicetree/bindings/clock/imx28-clock.yaml     | 113 +++++++++++++++++++++
>  2 files changed, 113 insertions(+), 93 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx28-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx28-clock.yaml
> 

Applied, thanks!
