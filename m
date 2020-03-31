Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52F2C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A209B20658
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585684833;
	bh=zvJLZ1Yiyd3wNasFIHUvdsiN9vMWVMooFuGGJBtZzKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KWkv/L4iwnsoYUjQvcEEIWQ5pOQXmtQpW6XVjG5MBdwNdM/0+lpkCtkRypTxOvmMo
	 3FdE41FbVOXiFa/UzUMm7SGXqs7j3wXkRE9Am+2obMcJyyD4if08L7MYMbU+ZfEZv/
	 r5ZpnBFiGqzgiT7dLjHH9uzYDHk1JGCyig6aCGmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgCaUAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:00:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46683 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgCaUAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:00:32 -0400
Received: by mail-io1-f65.google.com with SMTP id i3so13973895ioo.13;
        Tue, 31 Mar 2020 13:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s9DFvHioEqxQs6sviOj1Sm2a5WFW4fOhlT5MmKmuEBU=;
        b=k5vl1cHIhZuHBMga307KVT822UZEIRHQTa8vZCgfAYpJplTU/2yTfKS9NuOUw5CL5c
         /ETvF0tsSLWRog6zXfkoKM80aGfQg5+FlC35Ti7fqZWKEmiCFM2Mg3FPOWRODcBQw2PP
         WKiB8FeB0IMIi5sjGepKUJLoFxcHhXoMH1IZBp9/8HXuvkqyTjyAWiWNZO1lyxewRNKQ
         5MFcorAnIdGe7WC1NNQvL8kl+46o/WvQ6zF2kZRUIQOpeN7ZD6VG0YXBiV1Ky7OiFmpW
         QpPWSLN5BUokUx+q5ktBsvFIY/gcsDEz6aq3L5EwtyHX4mte/ZxyE4A7I8g2WZn509cU
         p/7Q==
X-Gm-Message-State: ANhLgQ3QnEMFNuyBdf8Ebf7uBAUraa/ju/48igJc8eTHwxtspckGAuU+
        SZg4xY6Jh+4B4zNuCwoA/A==
X-Google-Smtp-Source: ADFU+vvHXBGG9b+jJlsNae2tD54vi6RyRFIDg9NuHSbI3xqW9sGB/or7YPwGuRQfIT0By0v/er67tg==
X-Received: by 2002:a5d:8b57:: with SMTP id c23mr17020954iot.161.1585684831803;
        Tue, 31 Mar 2020 13:00:31 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p69sm5718490ill.46.2020.03.31.13.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:00:29 -0700 (PDT)
Received: (nullmailer pid 5074 invoked by uid 1000);
        Tue, 31 Mar 2020 20:00:28 -0000
Date:   Tue, 31 Mar 2020 14:00:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, heiko@sntech.de,
        robh+dt@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: sound: convert rockchip spdif
 bindings to yaml
Message-ID: <20200331200028.GA5018@bogus>
References: <20200324123155.11858-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324123155.11858-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020 13:31:53 +0100, Johan Jonker wrote:
> Current dts files with 'spdif' nodes are manually verified.
> In order to automate this process rockchip-spdif.txt
> has to be converted to yaml.
> 
> Also rk3188.dtsi, rk3288.dtsi use an extra fallback string,
> so change this in the documentation.
> 
> Changed:
> "rockchip,rk3188-spdif", "rockchip,rk3066-spdif"
> "rockchip,rk3288-spdif", "rockchip,rk3066-spdif"
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> Changed V2:
>   dmas and dma-names layout
> ---
>  .../devicetree/bindings/sound/rockchip-spdif.txt   | 45 -----------
>  .../devicetree/bindings/sound/rockchip-spdif.yaml  | 94 ++++++++++++++++++++++
>  2 files changed, 94 insertions(+), 45 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/rockchip-spdif.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
