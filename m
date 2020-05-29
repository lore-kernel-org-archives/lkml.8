Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58AEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84BCB2075F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590720859;
	bh=coWWgn98iVsK8p7DyOxIc4k156gQD1IaeA9rwQdrndk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P736C5oKsavV6gaTlHXADnW7x3vWi1c2p5EubhtY8UlsDsfG37tg0rPRbjgF9mXal
	 /Gbux8RYG9UAN1MxGgkBM39P3fkqK2M2+hsDhV2nLllLuivV2sBfItq+B77iUnD9Zy
	 Y7lI1stNTWNqpjGGOgOGIN7iCzflvqc+DI3bg9HE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407197AbgE2CyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:54:17 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:41937 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406871AbgE2CyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:54:13 -0400
Received: by mail-il1-f193.google.com with SMTP id d1so1037404ila.8;
        Thu, 28 May 2020 19:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y66i92hbnAMVd56SYuoik3I3JL2I+Eab/POc6wP412M=;
        b=pDCddYR0iIsm9hgfMuDqL3+wuX9zGZ+2+sl73mkBsoJY+JGAW1JM3JSuveOXlWy9gA
         XMEkdPaBanONnxZdhhQugueaeGGhopX7ifKhmN1oxQ4pRkD/qwXq7VlW8urI/VBVQ30N
         FR4iIHCfM1Fspam0DGzHt1/scPrMsdZJv3CfmSOWO74Ef3TsSbNmcvjDylQuSNg17uHV
         2gNSbUGUQ5s/4tajg4EQxhj3Gl3/2aIhgalKP/0KrsR4wRopg7JKwY+fZ8YNQcMf2yr3
         Qd/++X+5sY0ginRPCo1JHlsHLe4mjadYxjRZrp2P/U9Rxmduwd3puyOZ3eEPMa4IbLCL
         NsBQ==
X-Gm-Message-State: AOAM533Vwo8QIx8LPVAgbPwDlGtybA86oir4gmDEAAxxikPR4/HTJy+h
        adskSRS/sDxznU1T70+gBw==
X-Google-Smtp-Source: ABdhPJx0r59/Ul2jAtX3PMZbHxDUKVh9XGaJaNhEbfDtMhWWJJo8GaBV8+9BFVxbvD/i1BQIax8bqA==
X-Received: by 2002:a92:400e:: with SMTP id n14mr5729979ila.300.1590720852244;
        Thu, 28 May 2020 19:54:12 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id h23sm3310934ioj.39.2020.05.28.19.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 19:54:11 -0700 (PDT)
Received: (nullmailer pid 1180033 invoked by uid 1000);
        Fri, 29 May 2020 02:54:10 -0000
Date:   Thu, 28 May 2020 20:54:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     shawnguo@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        s.trumtrar@pengutronix.de, s.hauer@pengutronix.de,
        mturquette@baylibre.com, shc_work@mail.ru,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 9/9] dt-bindings: clock: Convert i.MX1 clock to
 json-schema
Message-ID: <20200529025410.GA1179683@bogus>
References: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
 <1590650879-18288-10-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590650879-18288-10-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 15:27:59 +0800, Anson Huang wrote:
> Convert the i.MX1 clock binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx1-clock.txt       | 26 ------------
>  .../devicetree/bindings/clock/imx1-clock.yaml      | 49 ++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx1-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx1-clock.yaml
> 

Applied, thanks!
