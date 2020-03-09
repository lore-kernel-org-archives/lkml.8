Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11356C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AAF20578
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583777267;
	bh=3KzOL0OHdKOGuNUYfnalzffFPfY5Ehm25/AYkAN7j3Y=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=NZetgmPtHITA92QaC4dNPbIEh/m//ybfn0uZ9yFlvHV87NyvzNzEGFaeUUa1herOC
	 PVpK5j9kweCwh4OQDcW22gbDLq61PG209XsM7PNEWgR5NxTyM5bKMxGjkgIUEh4K4t
	 9cO3EWv/EaMIlfLkBdni01t3CIUkcfsZuPpLvVRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgCISHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:07:46 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43028 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgCISHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:07:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id a6so2608292otb.10;
        Mon, 09 Mar 2020 11:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TVT07xaqK97f9P3Pb3B9yQzNB5BoR3JRr8W4TtJEEZA=;
        b=IsQi3OZqEd0mBwmgqbBnGhCWB965/HYW7Z4WCTbKMGk/oblXAIbwwzj4VQqsP2VMPO
         lqDl4x0eghLcWl1lJeTP3MG4nZio3dNi1nn+oXRlclXOH4R9X+1HFWJy/eNNUXL60PBV
         Dsj6KgMiIGeWHR/uDhyehQ9aItHl9LChoYij4VV6TIfD1YBUpCtVIDoRgCmMg1ZDYRSh
         Mf4nNguDIEalEltuMyrqrb2hafwbr1iD+91P9JnEmcoT37zQiFkQmZLIcG5GCnyD54Z2
         3tiF1o1SL8iuSiUTjElIvs5Hk/PXg3ZOd7Bsc4GnieUDBNKLLOe9e5/9Seu3LNzOrrPc
         C+nA==
X-Gm-Message-State: ANhLgQ3efz2h5T5nFwfFvqAWiapVNrsC/6KujdaOyVJcF5DxKkQG+wAZ
        MNqtGtH03MrKm5cK8WxfEg==
X-Google-Smtp-Source: ADFU+vt031bmB3XCzFrsAZRRHdRRFvLsAKJeBXuIiF4e+fILQkKQpY5tJfhVo0MIUWEVoh21a6IcRw==
X-Received: by 2002:a9d:2a83:: with SMTP id e3mr2572019otb.280.1583777264670;
        Mon, 09 Mar 2020 11:07:44 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h13sm3362849oie.12.2020.03.09.11.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 11:07:44 -0700 (PDT)
Received: (nullmailer pid 19774 invoked by uid 1000);
        Mon, 09 Mar 2020 18:07:43 -0000
Date:   Mon, 9 Mar 2020 13:07:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergey.Semin@baikalelectronics.ru
List-Id: <soc.lore.kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: Add Baikal-T1 APB-bus EHB dts bindings
 file
Message-ID: <20200309180743.GA19530@bogus>
References: <20200306130721.10347-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130733.3FD2C8030706@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306130733.3FD2C8030706@mail.baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Mar 2020 16:07:17 +0300, <Sergey.Semin@baikalelectronics.ru> wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> This is a specific block embedded into the Baikal-T1 SoC, which is
> dedicated to detect APB-bus protocol errors and tune the peripheral
> access timeout. So the dts bindings implies that corresponding dts
> node would be equipped with "be,bt1-apb-ehb" compatible string, MMIO
> region of registers space and of space with no device mapped,
> interrupts property and with an APB-reference clock handler.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: soc@kernel.org
> ---
>  .../soc/baikal-t1/be,bt1-apb-ehb.yaml         | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-apb-ehb.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-apb-ehb.example.dts:18:18: fatal error: dt-bindings/clock/bt1-ccu.h: No such file or directory
         #include <dt-bindings/clock/bt1-ccu.h>
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
scripts/Makefile.lib:311: recipe for target 'Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-apb-ehb.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/soc/baikal-t1/be,bt1-apb-ehb.example.dt.yaml] Error 1
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1250282
Please check and re-submit.
