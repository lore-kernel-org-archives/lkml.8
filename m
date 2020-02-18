Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F0BC3404D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B4F207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582066810;
	bh=hZuJKxOP4U7426Vra7K1+TaONlARPiZSHSEw1mixIkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JViZuyGvZ+SVqIcigwYpmRNHeZRj7/Gm2LGVGalZy6PY+J3xEV5zo2aglhcd6JWdh
	 8L5SB2go2nkbbTdtwutor2MgFglV1yR+ZuS8bGrV5r0m94rdMlBC6zM9uS6xTod32n
	 WywZN8JFFl6qTIXsRa2+SkDdqPie49aQINY/mZPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgBRXAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:00:08 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45442 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgBRXAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:00:08 -0500
Received: by mail-oi1-f195.google.com with SMTP id v19so21875385oic.12;
        Tue, 18 Feb 2020 15:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4SXS4Vx31CbjF24/0UdHiAqHrzVdz6zIaMwael6olmo=;
        b=CEBiiC2ann36dhv+yU3P1hTsrOyHROUfFg13t6LyKxf8Lj/l/+7+bgUzK9qI+bo9f9
         szvXDyI9hh6cav3f0MPjapiCi1vHGc1qQoYOrsyR7gwDcH3nlisfwVHQAMc9jp/lIWUY
         kd2y8m8HEF4n96ULgK6fIkPG16cCWVXulbzjIKsMUdbK0qSoI3Bp3P+xs/VcLexN1mPV
         xgyLJITBdVg6lNOCjQe+AuPqSUp7Qkj6r5MRz2gVvip4dVP4Ih6F1yyvs9XCje7G6TmB
         ls2kAsjRu+Gzata5RQVuOofafaga0mU6faM5slWZqHBTAHqKnzfj7eeA0/pWfGGaka3t
         arvQ==
X-Gm-Message-State: APjAAAVw72NJ9JK3OaN4BwV3+NRADXXE2tp50lGNR4mFMEY+KrS6mZ1G
        9+XcH+W9EdokONOUOXTrTQ==
X-Google-Smtp-Source: APXvYqwJgOSwcWVN0or0SUmkODwvFUkixIAxPI8oMJiGMChfd9gdfTl91ghUYsw4eo3AjzGu/XuJbw==
X-Received: by 2002:aca:815:: with SMTP id 21mr2917579oii.52.1582066805654;
        Tue, 18 Feb 2020 15:00:05 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 5sm2120otr.13.2020.02.18.15.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 15:00:05 -0800 (PST)
Received: (nullmailer pid 3608 invoked by uid 1000);
        Tue, 18 Feb 2020 23:00:04 -0000
Date:   Tue, 18 Feb 2020 17:00:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH v4 3/7] dt-bindings: clk: sprd: add bindings for sc9863a
 clock controller
Message-ID: <20200218230004.GA2060@bogus>
References: <20200217032321.15164-1-zhang.lyra@gmail.com>
 <20200217032321.15164-4-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217032321.15164-4-zhang.lyra@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 11:23:17 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> add a new bindings to describe sc9863a clock compatible string.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../bindings/clock/sprd,sc9863a-clk.yaml      | 103 ++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.example.dts:38.11-44: Warning (ranges_format): /example-1/syscon@20e00000:ranges: "ranges" property has invalid length (16 bytes) (parent #address-cells == 1, child #address-cells == 1, #size-cells == 1)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.example.dt.yaml: clock-controller@21500000: clock-names: ['ext-26m', 'ext-32k'] is too short
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.example.dt.yaml: clock-controller@21500000: clocks: [[4294967295], [4294967295]] is too short
Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node

See https://patchwork.ozlabs.org/patch/1238958
Please check and re-submit.
