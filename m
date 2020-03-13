Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6CCC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 22:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770D72074A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 22:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584136926;
	bh=CqkCJEyVopSKtTtmPK6XpPSIbCTDJ2KS3Po38Nx630U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lpJ7Iz7X/gom8Ol2UyRb2ia+peA+xb1/Xd/dDtzopvplqNmVaI3rgmUFJ2v9L0MS/
	 UOLER0JhJy7xYJaYUebFde3jMlGFRkx/VuVGjE9yY8IcD/J5yZfDD5zXFfAR7QWo9L
	 MHOHm5FMDFoUepOBhG0u+R3EpNZK+lTZqSOTR07Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgCMWCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 18:02:05 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41734 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgCMWCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 18:02:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id i1so11070080oie.8;
        Fri, 13 Mar 2020 15:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h+LbMp0wWLD3yyfWZGdmqW/q3jmbK4PSdXUPMZElXqk=;
        b=jZ7jTpwuN3myyLan7UFw16RMKiATPbMoBfHyMucwN/IZkCbUDmVEixvglLGvCyVclv
         7X22ixludocU0lYHJ3SttpTBgZMI7AyWhxUNaQSEo2vcPi63UIo0BYcS52TCuEebQaVK
         txonBLkWk9dz2K4/ZIG86WNQsJw/20tLEA+7EEllXR1IMIN+0Jchl7BqpCoIv57Sy1J3
         +lp9EQ+lV3RQtBSo6E5fpXs1RLdFxD8GbNbe/xiwaMnz/JRIc0s9VhSauv6qrqs2stLJ
         h9UKeVwT34xpdNs0KlsbJUzFkQyzfpHCK1mjlu9+VJ6SB8ZLggpynRHcy1YYxawVw8iL
         l1VQ==
X-Gm-Message-State: ANhLgQ1QGRgzegZ+MDUsp+SIxl+1kt6wxqAskfUPUF1b03i1IG1dvgHL
        K+S5TpdiV5E7vbTB2YG3Hg==
X-Google-Smtp-Source: ADFU+vs/T3x4IUHm5oOlrPweulylbQR9uLmQne91+JKK5gdtsqTLFtZDXS2oeURgjSXrtiRh37cYcQ==
X-Received: by 2002:aca:cc81:: with SMTP id c123mr8599085oig.74.1584136924263;
        Fri, 13 Mar 2020 15:02:04 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a64sm4411203oif.49.2020.03.13.15.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 15:02:03 -0700 (PDT)
Received: (nullmailer pid 26133 invoked by uid 1000);
        Fri, 13 Mar 2020 22:02:02 -0000
Date:   Fri, 13 Mar 2020 17:02:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: Add Broadcom STB USB support
Message-ID: <20200313220202.GA23539@bogus>
References: <20200313141545.31943-1-alcooperx@gmail.com>
 <20200313141545.31943-2-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313141545.31943-2-alcooperx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 10:15:42 -0400, Al Cooper wrote:
> Add DT bindings for Broadcom STB USB EHCI and XHCI drivers.
> 
> NOTE: The OHCI driver is not included because it uses the generic
>       platform driver.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  .../bindings/usb/brcm,bcm7445-ehci.yaml       | 60 +++++++++++++++++++
>  .../devicetree/bindings/usb/usb-xhci.txt      |  1 +
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.example.dts:24.13-14 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:311: recipe for target 'Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1254417
Please check and re-submit.
