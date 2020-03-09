Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A79C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D40721655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583777253;
	bh=zfzky6OC11kF2bgMIwJsghZNgx6fMRvSRzfpDPL7+y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MKtNTInILMm3VTbl107wkH6HVnwSKhz6jSuMxTBfq7/knpZCw8Q8ILs+JS1aV/mwd
	 cbheHSUpo7Q96om3hV6CcsvkCgoIXNjE0XxPKCcwuEoD5pCh1EdEHB2RS/tcKpsLPC
	 YclmV7r3cTiEfcBzcdtOSl11GndBoFm7RKDXihbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgCISHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:07:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37649 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgCISHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:07:31 -0400
Received: by mail-ot1-f68.google.com with SMTP id b3so10526256otp.4;
        Mon, 09 Mar 2020 11:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UTUX+mvtm+ojqqCymPEXY8mJF4lfXP5RzSQN10YRlDA=;
        b=GnvPiRIQ9SVBNsewqg1Dak/pWZTME7R3Ce4BkL+tKMzQcjajuRfKPWObYOtg6bWja2
         g+nb5NTFVvok+i5FK+vVFftRZaCuFMcH1ek83IkbznaTSxubQw22U03ANEBvMJLn6ggN
         WWvLYF211+3c3e3GWUN+p6r/hemZe7Z9im3DwE/5O4pibWFFa2xOUb48pyukKGlIzO25
         OnbuvLLNy4Rs6PivCa+T4VOQ0Pk4UT9hLP3RXueKko074c9QR58c63B5zA7fHXfmki0/
         5UIN8x7UqeP4xdMqI195mfOJL8YtvikfiJNkZYQvfcX+9u08uUry8/FapyNBmHvbXQ4H
         IAlQ==
X-Gm-Message-State: ANhLgQ1uxb1B61Kpi1u56jI03gKxcoBvEWYbpvIVXmEuSk2hCssuQ5Pm
        dPzcMU4g/ODIADNfUfqPae1JPKo=
X-Google-Smtp-Source: ADFU+vu8MBn/Nx3i1999t4LE2yQ8yyK6M6PxqFxNxf27vfReBGZpJjUL0ncVHCzXbgpuLxZnnuudSw==
X-Received: by 2002:a05:6830:4a6:: with SMTP id l6mr14534375otd.61.1583777250738;
        Mon, 09 Mar 2020 11:07:30 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u6sm2481870otq.56.2020.03.09.11.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 11:07:29 -0700 (PDT)
Received: (nullmailer pid 19364 invoked by uid 1000);
        Mon, 09 Mar 2020 18:07:28 -0000
Date:   Mon, 9 Mar 2020 13:07:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add Baikal-T1 Boot Controller
 bindings
Message-ID: <20200309180728.GA18776@bogus>
References: <20200306130528.9973-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130613.7D8CE8030794@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306130613.7D8CE8030794@mail.baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Mar 2020 16:05:27 +0300, <Sergey.Semin@baikalelectronics.ru> wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> >From Linux point of view Baikal-T1 Boot Controller is a multi-function
> memory-mapped device, which provides an access to three memory-mapped
> ROMs and to an embedded DW APB SSI-based SPI controller. It's refelected
> in the be,bt1-boot-ctl bindings file. So the device must be added to
> the system dts-file as an ordinary memory-mapped device node with
> a single clocks source phandle declared and with also memory-mapped
> spi/mtd-rom sub-devices.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
>  .../bindings/mfd/be,bt1-boot-ctl.yaml         | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/be,bt1-boot-ctl.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/mfd/be,bt1-boot-ctl.example.dts:17:10: fatal error: dt-bindings/clock/bt1-ccu.h: No such file or directory
 #include <dt-bindings/clock/bt1-ccu.h>
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
scripts/Makefile.lib:311: recipe for target 'Documentation/devicetree/bindings/mfd/be,bt1-boot-ctl.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/mfd/be,bt1-boot-ctl.example.dt.yaml] Error 1
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1250277
Please check and re-submit.
