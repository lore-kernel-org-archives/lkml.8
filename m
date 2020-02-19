Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499ADC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E68620801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582121370;
	bh=HFaXUgtzxw+7x9hkLBxzw5x+uzRjCqlLOOAm22GwX88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N3uhz5dB/wmr5J3bKpXRx49zo7JwTioF0FmHio9qU+dgecVUS+hAL6n9YvuoS6iXO
	 kx5kDOkoJ5CxLDMkDx/LdGKm6myEWtlR9nKHrh0Lu7nxOeXoCYx/GlbU95kSLMGMum
	 wj4VintNxi08QaRqiUqWIBzSl3Uvo/9M3tzGHhOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgBSOJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:09:28 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42816 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgBSOJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:09:24 -0500
Received: by mail-oi1-f196.google.com with SMTP id j132so23886923oih.9;
        Wed, 19 Feb 2020 06:09:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w0+iwQxqNl/u797DK+0XyoBMJz+IIdj3rSrLkc2+kbs=;
        b=QBOx2ZSEXrHbCmd8jU0LL/Exg7ryyHYwI4/suzaq+OGmsUro4i5bCrnSOSjqJR+qDN
         ZaQcD2pLccnf6mBQnuYXri5F25tzTu07bfcuyjw0fxJwpNrni7kacSTbJIvBnSKCBF0z
         uO1taak8+ritB2SxiBtGFhFubz8kBuasEsQ+hTf3PVNUbDffylA/+BEN//y/EZAyvJl5
         LYr8ItwyOZp+Vx3sNp2xK5cV8uERzhz7oNA05wiCH/P9zMmPB/ckvqdvsfere4/JXMfx
         Fd2xQiLfymEtcTs5tu+XyG+I5lpju0Z8T/30Mu+rDkYQtdrhBGU0tk/WXKDvv57v5zJt
         Aj2A==
X-Gm-Message-State: APjAAAVAQE+CuIYZn4ha6ljkouBtLL3QDJFzrYEBK7aamyJm4yPV7yi8
        ch/ThXBqnk4DI6f1Czk9ww==
X-Google-Smtp-Source: APXvYqyBzFjf4VEjf1EoLRQ0uCruPnwDHxFaEDDuZ7gw9XftwRfkd4+9xnhC8HJN5lU4jCtbEAB0lw==
X-Received: by 2002:aca:3f8b:: with SMTP id m133mr4540584oia.51.1582121363283;
        Wed, 19 Feb 2020 06:09:23 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c10sm647696otl.77.2020.02.19.06.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 06:09:22 -0800 (PST)
Received: (nullmailer pid 8118 invoked by uid 1000);
        Wed, 19 Feb 2020 14:09:21 -0000
Date:   Wed, 19 Feb 2020 08:09:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     peng.fan@nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/9] dt-bindings: remoteproc: Convert imx-rproc to
 json-schema
Message-ID: <20200219140921.GA7031@bogus>
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
 <1582097265-20170-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582097265-20170-2-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 15:27:37 +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the i.MX remoteproc binding to DT schema format
> using json-schema
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/remoteproc/imx-rproc.txt   | 33 ------------
>  .../devicetree/bindings/remoteproc/imx-rproc.yaml  | 61 ++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/remoteproc/imx-rproc.txt
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

warning: no schema found in file: Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml: ignoring, error in schema: properties: clocks: items
Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml: properties:clocks:items: {'Clock for co-processor (See': '../clock/clock-bindings.txt)'} is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml: properties:clocks:items: Additional properties are not allowed ('Clock for co-processor (See' was unexpected)

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml: properties:clocks: {'items': {'Clock for co-processor (See': '../clock/clock-bindings.txt)'}} is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml: properties:clocks: 'maxItems' is a required property
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml: properties:clocks:items: {'Clock for co-processor (See': '../clock/clock-bindings.txt)'} is not valid under any of the given schemas (Possible causes of the failure):
		/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/imx-rproc.yaml: properties:clocks:items: {'Clock for co-processor (See': '../clock/clock-bindings.txt)'} is not of type 'array'


Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/remoteproc/imx-rproc.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/remoteproc/imx-rproc.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1240544
Please check and re-submit.
