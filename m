Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DE2C2D0FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A62D23129
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589322815;
	bh=nL8KMXMcA+4gwiHl0CUoXIGHseXbgvlaf4N32o/2bMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T03Xk0ELRzyNQlHQ7OsWtbtBZhnX1F5GSvPoFzNBfS77T5DAmxpznkl7To9bjXGQU
	 I4zVhwajcnn1MWGEone5bV4O2SAnm295s93uyccM8n/cQW458SmKQAVTq3oxTSwS+D
	 fy8VKFz5IJELG9sL08fgpF3oGPmcM4XYYZhyLFIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbgELWdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:33:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42836 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELWde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:33:34 -0400
Received: by mail-ot1-f65.google.com with SMTP id m18so11857462otq.9;
        Tue, 12 May 2020 15:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=y+bYEHG5+H41i0k9IKvYB5czzxQ6apM29KdhUZ9VKVw=;
        b=LiOQxStM01MH4NI9nUxIRfG791lM9xS8/X8MMpP2um7Vd+pDE7gqNzWHf/MwZ8H77G
         9VCbwhcBeKcCIQ1Ic2dyH9zwpEUhb50Yw3u47dytNwpYeV19kSsotcHJ/MpovhzGbI8m
         7fOOJZJVetj97gZxF8zSR5KY9fRZN0ce5uzGxzB7HVlNDxTrG2xFL6tkKma0vc3FNK76
         xM50yqaToB5wBZMY7sPj6Mq/sBazCnde+bMN8OpQJa0XvH4BmBKMDgXfE29U1G9Q154z
         TsGt8PWrirqadx30b+qi98gckJFC9xUXf4ArKSHB/xEWW74LJU/dUhESJCSlZu1pXK6m
         UhHw==
X-Gm-Message-State: AGi0PubAz451tZMB0ynIuAFIP/02QnUKY/1EJhFznLGMrWHsFbL49BuN
        1xXG3baMPfs7VnYBWUOuZQ==
X-Google-Smtp-Source: APiQypJ0QgJBXdaoUzcntJkXYpa7uIVyzsVMP96rgaq721CYrNfs2z6IEGTEW8h4iS6VdvsJIoVFEg==
X-Received: by 2002:a9d:39b6:: with SMTP id y51mr17894918otb.368.1589322811717;
        Tue, 12 May 2020 15:33:31 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 10sm3750640oto.80.2020.05.12.15.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:33:31 -0700 (PDT)
Received: (nullmailer pid 25179 invoked by uid 1000);
        Tue, 12 May 2020 22:33:29 -0000
Date:   Tue, 12 May 2020 17:33:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-renesas-soc@vger.kernel.org, sakari.ailus@iki.fi,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Hyun Kwon <hyunk@xilinx.com>
Subject: Re: [PATCH v9 1/4] dt-bindings: media: i2c: Add bindings for Maxim
 Integrated MAX9286
Message-ID: <20200512223329.GA23701@bogus>
References: <20200512155105.1068064-1-kieran.bingham+renesas@ideasonboard.com>
 <20200512155105.1068064-2-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200512155105.1068064-2-kieran.bingham+renesas@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 16:51:02 +0100, Kieran Bingham wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> The MAX9286 deserializes video data received on up to 4 Gigabit
> Multimedia Serial Links (GMSL) and outputs them on a CSI-2 port using up
> to 4 data lanes.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> v7:
>  - Collect Rob's RB tag
>  - Remove redundant maxItems from remote-endpoints
>  - Fix SPDX licence tag
> 
>  .../bindings/media/i2c/maxim,max9286.yaml     | 287 ++++++++++++++++++
>  1 file changed, 287 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml: properties: {'enum': ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'deprecated', 'description', 'else', 'enum', 'if', 'items', 'maxItems', 'maximum', 'minItems', 'minimum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'propertyNames', 'required', 'then', 'unevaluatedProperties']} is not allowed for 'additionalProperties'
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/media/i2c/maxim,max9286.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/media/i2c/maxim,max9286.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1288573

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

