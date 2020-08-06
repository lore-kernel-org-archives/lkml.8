Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF88C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A1922086A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596733006;
	bh=0wKM3mWQHnJKTg99jyvaHL+zXdTyGAIdaEhOcyjYMt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K9Avn/f08dPZZ0BzphSbvzoyNtQhFyp6QHKuVDp3RGVIQ44HT4PspYIT/lCpMrRJs
	 wmOmxB7AFxcKgt1Pa+12DmIu16mndee2zLqxbO+aAtNncQmEadSZ8XB9mTyhA9dMUN
	 LPpwjetDqqsa6R2rglV5FkI//KVSSTfLpSTnkDyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgHFQ4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:56:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43093 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbgHFQ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:56:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id y206so15066723pfb.10;
        Thu, 06 Aug 2020 09:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DZK8kIWVagxshScmbHYjLOZlLWD06ChXNp8+pO54ekI=;
        b=pnTdG+9chsDzBgqO4mb/0PXOmwjid4IkshFWI3rz6DnlgOghC0bPHZg2Gnu0ZYgakr
         kevh70rsJfEx3YKb5hyGRBmPDG2/XtHcUAgFIRJ9qbshAb/JoWfTbeykVuoGgkhnNli+
         3LI5F6jhdkz+HJRDEu005QZ3B+ygitX66gGSuU4NWZQVQxr2ZZqOha96zKiEA4CP1zLq
         4pq2mC2ztS/rhkzHr0SkoJ/ZH2ZBlvJ6KkMQm7ix22CsRdYZsdIp+sndNuOcK6KFdaQZ
         Q1ku9rzO7dwU1QipJoEY6CMNnooW7YnAoMYiI/z+p1G/zL3iqlnDhcmYFxojoZD+2lie
         XEjw==
X-Gm-Message-State: AOAM530OYS7RTeZ9R5UyScmT4gMU20WEjUTvgBH6KTgQaebsSm7DQKQT
        QUoa7hoYPLTnbYbZKpKBA8BlIww=
X-Google-Smtp-Source: ABdhPJwTIHZIoiu7qgJXbwVIeCcyfxN2HLZaBc6eh2dR9i0vBvhaOt8YNb8tvjUnqeL42/FA+nLCMQ==
X-Received: by 2002:a05:6e02:8a8:: with SMTP id a8mr11209994ilt.52.1596722840673;
        Thu, 06 Aug 2020 07:07:20 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id m14sm4012604ild.4.2020.08.06.07.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 07:07:19 -0700 (PDT)
Received: (nullmailer pid 768450 invoked by uid 1000);
        Thu, 06 Aug 2020 14:07:18 -0000
Date:   Thu, 6 Aug 2020 08:07:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     stefan@agner.ch, devicetree@vger.kernel.org, Linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: Convert vf610 to json-schema
Message-ID: <20200806140718.GA766974@bogus>
References: <1596553308-13190-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596553308-13190-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Aug 2020 23:01:48 +0800, Anson Huang wrote:
> Convert the vf610 gpio binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/gpio/gpio-vf610.txt        | 63 -----------------
>  .../devicetree/bindings/gpio/gpio-vf610.yaml       | 79 ++++++++++++++++++++++
>  2 files changed, 79 insertions(+), 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-vf610.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/gpio/gpio-vf610.example.dt.yaml: example-0: gpio@40049000:reg:0: [1074040832, 4096, 1074786304, 64] is too long


See https://patchwork.ozlabs.org/patch/1340897

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

