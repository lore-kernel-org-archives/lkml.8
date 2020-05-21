Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D55C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2208120738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590091073;
	bh=hYC1vjaGETl/3CgA0n/a57NPosACCQiHCX0L1n9aqOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cXKhU68VEW87o8QA6/TkZJ34F+Lt3fM2QlXCWRo9d0zv1z4L7ES3SXZnfUvZydF/j
	 A4LO2GEXLqqDuoP6LNEHU8rNmN0xJ0wi1yk1lTWRZAkkc6OzxGgXn9iVPA4ejEJZlE
	 OntO615Cg0VRPT7Cac+ae8TWx+M43e5Evc2+oZ0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbgEUT5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 15:57:52 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:46184 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbgEUT5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 15:57:52 -0400
Received: by mail-il1-f193.google.com with SMTP id w18so8408092ilm.13;
        Thu, 21 May 2020 12:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OAy8ldgBATiWXiqryhQTwFQBaNcYrHCCh+yz1e4niZQ=;
        b=L36FnRruIWci6VHq5N1626IrG24qkuWsOcOLNyQDbDVmsB6WGF2kSCVQ3nkO+mS7im
         lP4RWzQYg8tSSjSLdyPeMPhMSssebJImN8XImM7EvegdMvq6Sk5sYI1cseDpkHtjmAx+
         KQ3kKYKQWnTmwuLQtSXYozUx5X3q0ixqmo7trPvviAw9IwetroRqeNQRX6EQj3DmniPP
         Cplbi501y/sdKs/o9PqMrR/zEg+rdKwPjHqAmGcaQoFDkwXJ9LCMw9Am4W9dy2LrNxHt
         CT9NcvyE+DKpF/0e3hD/YZaVO3FKUP4NiwwZiGC2o4I9yOvYjS988ABiDRtov6zsTaSY
         i6xw==
X-Gm-Message-State: AOAM532cNkElnCtjPgq1RmVwIOpaAyIAdp2vTNbZdVSx3ZH87i9UtXi4
        DaeAywptdkZShfQKWfiR1PDmmJU=
X-Google-Smtp-Source: ABdhPJwHyDis2WG1KGFNitaZrgzusOwKaK2iwSdk9rFkjUCecu87kyYn6kFxi+8OsazkPT2U1tEWWw==
X-Received: by 2002:a92:ce01:: with SMTP id b1mr9931451ilo.55.1590091071311;
        Thu, 21 May 2020 12:57:51 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l3sm2919083iow.55.2020.05.21.12.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 12:57:50 -0700 (PDT)
Received: (nullmailer pid 2796469 invoked by uid 1000);
        Thu, 21 May 2020 19:57:48 -0000
Date:   Thu, 21 May 2020 13:57:48 -0600
From:   robh@kernel.org
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/9] dt-bindings: gpio: Convert mrvl-gpio to
 json-schema
Message-ID: <20200521195748.GA2795626@bogus>
References: <20200521091356.2211020-1-lkundrak@v3.sk>
 <20200521091356.2211020-3-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521091356.2211020-3-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 11:13:49 +0200, Lubomir Rintel wrote:
> This converts the mrvl-gpio binding to DT schema format using json-schema.
> 
> Various fixes were done during the conversion, such as adding more
> properties that are in fact mandatory or extending the examples to
> include child nodes with extra GPIO blocks.
> 
> The compatible strings are a mess. It is not clear why so many of them
> are needed; the driver doesn't really seem to differentiate between the
> models. Some of them, like marvell,pxa93x-gpio and marvell,pxa1928-gpio
> are not used at all, so it's not known how many interrupts they utilize.
> On the other hand, mrvl,pxa-gpio has been seen in the tree, but it
> doesn't end up in any actual DTB file.
> 
> In any case -- the schema merely copies whatever was in the original
> binding document, so it's hopefully no more wrong that the original.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - Drop marvell,pxa1928-gpio
> - Drop ranges from example with no gcb child nodes
> - Add default GPL-2.0-only license tag
> - Fill in maintainers from MAINTAINERS file
> 
>  .../devicetree/bindings/gpio/mrvl-gpio.txt    |  48 -----
>  .../devicetree/bindings/gpio/mrvl-gpio.yaml   | 174 ++++++++++++++++++
>  2 files changed, 174 insertions(+), 48 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/mrvl-gpio.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/gpio/mrvl-gpio.example.dt.yaml: gpio@40e00000: 'ranges' is a required property

See https://patchwork.ozlabs.org/patch/1295044

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

