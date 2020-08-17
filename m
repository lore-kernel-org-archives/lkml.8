Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F25C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC672065D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597699879;
	bh=Zw3trbhp8wY9HyV3Qlr8y4BlmCWei31dnUul+p0ctgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l8lnH2A7jJqeIXXZUu3B4J2BVvLsYNJJboU9bJlTcvTciCAzJ3U5r51cujHCFGR/a
	 hUD2pzdmXEhIRBt2jDuH4ekGYzNb7uowH+p6ucXxcLScQoN85To9QtfTf4aMfuspgX
	 doCv0WVEoTxsLQ0bJXonNNlawz59jOxXpfKnv2fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgHQVbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:31:18 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:32877 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHQVbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:31:16 -0400
Received: by mail-il1-f194.google.com with SMTP id r13so11404006iln.0;
        Mon, 17 Aug 2020 14:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c8c6GNXi2JTCgcZTiEnHnNdy2o5EXir+VMlVRQiMO+8=;
        b=s62KKAXLbGZ9oCeKSLzdRizRIsa6gGhvGyZwemQcKNQq27zXsP3KJDUHyq4Rz0wnTM
         1u04sHXn5fDkhUdeNEIpys1PD2FQPUHVaJxqCBEJLCYtNUirhU9CuhmbKinF9QyHVsqw
         ewHI2VEchkpZE4BdXeDfQkiTm7i7YCcy662/cgXXPY4bezTwOgQNIsopWmzoeaNZIVbN
         o/HdnT6ZqwYgMePFRmcmxezaqepPAn2GmLYLBuGd7ukky9mJXEYhvHHcnSYPQw5pwc5l
         nqI4+TDtci3T3MB+IvYalp9SWhwN2gttl4rCSx3xJq/ps3a/vrMGXnGtiBc/6tjT+0bP
         cYVg==
X-Gm-Message-State: AOAM530cgxe0sD7fjBGekR1h98Tt5KQTXm09j8gbVftSfMiO+jQlWMcI
        ZbtafW9noSwiB0E2UFqDnw==
X-Google-Smtp-Source: ABdhPJzrmcSme47w76AzHrBjwo6M2v6cV1/qkWybZU8G6VaG0onfg3XMqZZA5n97p9fjwOg6vcuFFw==
X-Received: by 2002:a92:8418:: with SMTP id l24mr15547886ild.201.1597699875821;
        Mon, 17 Aug 2020 14:31:15 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id e19sm9706968iow.33.2020.08.17.14.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:31:15 -0700 (PDT)
Received: (nullmailer pid 1600579 invoked by uid 1000);
        Mon, 17 Aug 2020 21:31:12 -0000
Date:   Mon, 17 Aug 2020 15:31:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mfuzzey@parkeon.com, devicetree@vger.kernel.org,
        kernel@pengutronix.de, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, Linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, zbr@ioremap.net,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: w1: Convert i.MX to json-schema
Message-ID: <20200817213112.GA1600514@bogus>
References: <1596595091-26760-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596595091-26760-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Aug 2020 10:38:11 +0800, Anson Huang wrote:
> Convert the i.MX one wire binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/w1/fsl-imx-owire.txt       | 18 ----------
>  .../devicetree/bindings/w1/fsl-imx-owire.yaml      | 42 ++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/w1/fsl-imx-owire.txt
>  create mode 100644 Documentation/devicetree/bindings/w1/fsl-imx-owire.yaml
> 

Applied, thanks!
