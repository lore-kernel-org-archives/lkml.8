Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BEDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D48207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595523759;
	bh=aSD3StTCB+wXgstT8yQFWXvYmZPlqZbbx0ydsS15MEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a80OZP5fx8RaHAqY9VtADoFhbe+zj1yXEzV6JQ+GA5wjWdYGOn5jN86Vf2Bcdv2VH
	 ymIR0amJ/FR91J6MTTyexXWRbrZjdorvpNm9WZrhLq8RO0axakeZwTA3wDaSvVyUvT
	 IFg587EqyrfNex1/8JhGA2ZwOitfzl7/Ygfa0Ptg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgGWRCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:02:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38243 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgGWRCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:02:37 -0400
Received: by mail-io1-f68.google.com with SMTP id l1so6970447ioh.5;
        Thu, 23 Jul 2020 10:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vLLS4DiGQKQgTm6aUjfCBDa6TERWvhFHxY3Cq9YdYWM=;
        b=fzU72jL8RXkYRkGanQlKYuXz5oQcs2o3DqrvNm2J1jGKrVj3R0nRz1hruUMy/KpN76
         vmcSs9euLOP54Bp1O2BaQ9Vi23WcBGsbVW9NL21YpRjpkoPA+R+rkoywdv6dyICEjjk6
         AxH6ZDZnyriohQc2S+pmesM3KyyVVdNljthpSXC6cpNmspQPVLwl0ZkTNsW3uZCcsaaD
         x0kRanbPOA58EJC9AtI/GDo+Lr1jrUVwAWLE0BB5fWMtit8fG2S4LhNfy+7xaPXB+xxj
         pHK3way97Nzkhn2F/guPejZNraaoe/oY1Eshll8BZ71HZf9EN4BtsI9NEOUCujfbDEhp
         HTUA==
X-Gm-Message-State: AOAM533rvqUAE2lpGLV9uIyEF4QNJGl/G9qaJ+HQ5PEWY/EkrJQ11tm4
        4X95+FBsC/rWJqQHZjrX9A==
X-Google-Smtp-Source: ABdhPJxx7foQDhl0CghD7HuYXs5m3BZErhowysmy9Id61ICoRpQi0WA0uHVnR5lW7obS5bwv5L0Xnw==
X-Received: by 2002:a6b:1496:: with SMTP id 144mr6007145iou.6.1595523756004;
        Thu, 23 Jul 2020 10:02:36 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id 28sm1818471ilv.17.2020.07.23.10.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:02:35 -0700 (PDT)
Received: (nullmailer pid 535616 invoked by uid 1000);
        Thu, 23 Jul 2020 17:02:34 -0000
Date:   Thu, 23 Jul 2020 11:02:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     devicetree@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: arm: keystone: Add common TI SCI
 bindings
Message-ID: <20200723170234.GA535571@bogus>
References: <20200721223617.20312-1-s-anna@ti.com>
 <20200721223617.20312-2-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721223617.20312-2-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 17:36:12 -0500, Suman Anna wrote:
> Add a bindings document that defines the common TI SCI properties
> used by various K3 device management nodes such as clock controllers,
> interrupt controllers, reset controllers or remoteproc devices.
> 
> The required properties for each device management node shall be
> specified in the respective binding document.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v5:
>  - New patch refactored out for usage by remoteproc and other TI SCI
>    interrupt controller bindings
>  - Patch based on remoteproc ti,k3-sci-proc.yaml binding (v4 patch 3)
>    with revised overall description and ti,sci-dev-id and no required
>    properties
> v4: https://patchwork.kernel.org/patch/11671455/
>  - Addressed both of Rob's review comments on ti,sci-proc-ids property
> v3: https://patchwork.kernel.org/patch/11602317/
> 
>  .../arm/keystone/ti,k3-sci-common.yaml        | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
