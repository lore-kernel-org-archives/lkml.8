Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF349C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9091A206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589296959;
	bh=iF4dJRuB21LIXN6iVYRJcMZkL42avp4j5BAkshvXR/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f1f7qRErFeIjhoKk4DVMJxb5UoXAez2rK1D70psBFd5K6IcpT137eczNXx7vR/G05
	 F+kPrsSTwQV1bFUAShptuzV0RaJbJgpwDC6Zx+XjR5ktZIRYgV2DX8qvXZhSHH7hfs
	 eiRz8iXgcSh/Ttk3XBv3fsOMCL1MqyY5+WTfSJuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgELPWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:22:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45133 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgELPWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:22:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id e20so10773355otk.12;
        Tue, 12 May 2020 08:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=crvW1wkR5IWkksI8W3C6iRy0ehBffjx8IBLSGWcoQM8=;
        b=dLAMIHKe4eUpl9tfdYr1O0dBAWZgjv5HYMAnd9zGdKTXJeK+wvSr2SlTGxR9YuptPr
         M18XO2zAX2KalmJS8I37dv5iP2v9W4BMrLe1jrQJ3SSka2iDsRelFUmjTnOEooyLC3qG
         E+hX1FQ2b4CiaKAsImDg+Oh2usoIC9RNKIIYHSAMVVmQ/VzJ/DHp7Qnhb+q35ZaQsx5G
         VzuBkcS38QE5N2Ynrd7vcIJ6xnH7HrAQZYvIC0Io++ht9fOMsXoNpPZICt8unp2IA+Nf
         iBN1NHx7jGDSrkbX0PMTXwSkOjtwdd/Bk+VQJ1VshMAXIYEAYlqLYg9Y2EycEB710cRr
         t7yQ==
X-Gm-Message-State: AGi0Pubhhs0mXKbTLx8/RRXOyBg16noZFtSPue0htR9Aamb47zy+RugA
        3NpZq9YDmOp7Ovl0Egvf6Q==
X-Google-Smtp-Source: APiQypLH4wU5XHQdt32BSEDzlFepPDtzW7cSlDiNpAvMrv1nUJSIWfF5N7K/M/oYbh3FNhDcGgxK1g==
X-Received: by 2002:a9d:73d1:: with SMTP id m17mr15366430otk.330.1589296957579;
        Tue, 12 May 2020 08:22:37 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d10sm629312ote.10.2020.05.12.08.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 08:22:36 -0700 (PDT)
Received: (nullmailer pid 5179 invoked by uid 1000);
        Tue, 12 May 2020 15:22:35 -0000
Date:   Tue, 12 May 2020 10:22:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        git@xilinx.com, devicetree@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>, u-boot@lists.denx.de,
        monstr@monstr.eu, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: Add U-Boot bootloader
 prefix
Message-ID: <20200512152235.GA4997@bogus>
References: <85b8dc9e6288270bbfdf55f1c156dba160293f01.1588239081.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85b8dc9e6288270bbfdf55f1c156dba160293f01.1588239081.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 11:31:27 +0200, Michal Simek wrote:
> List U-Boot project in vendor prefixes.
> 
> For more information take a look at:
> https://en.wikipedia.org/wiki/Das_U-Boot
> Source code is available here:
> https://gitlab.denx.de/u-boot/u-boot
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> The patch was created based on discussion with Rob
> https://lore.kernel.org/linux-devicetree/CAL_Jsq+ehJSK7sjqmKtWOVjr-QZ3LDB+ywCO85uF8WJ+cB=AAw@mail.gmail.com/
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
