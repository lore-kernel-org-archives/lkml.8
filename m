Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF977C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E46421775
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580745359;
	bh=CyVSgkZg0QjcVlB9I1I9CTM4mfMekRz94QeftjFysTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WW/cCbi651RkaAlZK6c/AFBvisNZH7xtEcjRibVYS/9NiJ/EjGbxEzK7RgKz9SGiu
	 oIEU9zvW7fKeNFQwnB8vXNFdPmANFMk1K5GmI0TfLZorAsj/bxSDo5KDatoMbpmJCx
	 D/cz1FDahSeGSgxutkjlijwYF6IagC8JKQvVkQmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgBCPz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:55:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33813 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbgBCPz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:55:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so18910587wrr.1;
        Mon, 03 Feb 2020 07:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :user-agent;
        bh=U2mK9M4FJ6ugFBNXxHdNAf6mB79D5E9goFVSxPy1ZpA=;
        b=XsnaSF28mpp2aJetsOHFxlwXZziKaGyhax7b8iLzsr15eGCEz857yRPjdRJmKHYiW8
         6z4geLQAkvO96pjSvhuYk2H5majf1vPSwNSyfjPpTXa1sw6HdIfpTSUio9YLU7MEMPbo
         nwxIlUiOLx5zdiDOz8eZvxEyHOcU7s3mC9fK89VPF/5P7Nmwvf2kUFoIo1tuqmUA1Iy/
         9eUzxvCejrNp0KcPm2CTuEHEgANFJTNGrYhO9kULpOVDcpTVF037p/8KGQpoiwY4SrJ1
         zRCW3rIIGR7UwIyyRmjytCheZnXQHX0JWJ2kRw3o6T0apsI3zIfe5ZCtCiEeWqaem5i6
         azuw==
X-Gm-Message-State: APjAAAU6KgUTBKcIPXoV608b7fNzFaqomq7MwaJyD/MgYNz7Mf+hsa4c
        hHuTxwF984w+NS6BrFZjmVAbSyg8Iw==
X-Google-Smtp-Source: APXvYqxQBUlu3XxCbRx5Paai9+u39gYSqu2FCyKwLUhG5ETDuNDow5aiw64awLP5olySIuHpk+BRhg==
X-Received: by 2002:a5d:534b:: with SMTP id t11mr16004161wrv.120.1580745355672;
        Mon, 03 Feb 2020 07:55:55 -0800 (PST)
Received: from rob-hp-laptop ([212.187.182.163])
        by smtp.gmail.com with ESMTPSA id q130sm25380392wme.19.2020.02.03.07.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 07:55:55 -0800 (PST)
Received: (nullmailer pid 2197 invoked by uid 1000);
        Mon, 03 Feb 2020 15:55:53 -0000
Date:   Mon, 3 Feb 2020 15:55:53 +0000
From:   Rob Herring <robh@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] dt-bindings: soc: imx: add binding doc for aips bus
Message-ID: <20200203155553.GA2132@bogus>
References: <1580097227-4364-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580097227-4364-1-git-send-email-peng.fan@nxp.com>
Content-Language: en-US
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2020 03:58:37 +0000, Peng Fan wrote:
> 
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add binding doc for fsl,aips-bus
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Add 'select' to pass dt_binding_check
> 
>  .../devicetree/bindings/soc/imx/fsl,aips-bus.yaml  | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,aips-bus.yaml
> 

Applied, thanks.

Rob
