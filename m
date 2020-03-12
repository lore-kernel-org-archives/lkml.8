Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27BBC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C91B206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584048412;
	bh=mRKLXJgrpC7l8OsIIx+kgqL7O4Hz2g/BBV46LWi6NNI=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=zCpSV7L+VVMhvaRRBOTVuOTkrmJDGAwN2RU1QfFXe7RjA9RhOdoieWs9TFwgo+3OD
	 9qsZAer6yvsekaUPq0sBSlzfmAZEnYPYtyRqY+001B0xaPDIWPuO8+cgPZb3MHRO01
	 Bvm6Z6w6QWe0isbuMDVXR4zElmkMnWbMDF6v8PRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCLV0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:26:51 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44614 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgCLV0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:26:51 -0400
Received: by mail-oi1-f195.google.com with SMTP id d62so7083301oia.11;
        Thu, 12 Mar 2020 14:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DmWFeXU2M1OgDYl+rtD1CnMHfgMZazgCXveQjR5Ujc0=;
        b=sjn+Bairk0139qSw4AhPojrvhYXouoPqQ2HOziYDrUT0FrYR8xF32AtZh1OkvYSJud
         QVQ9m6zLH4iYzIFLQInGJzaO7vTOLYzEnw0MfvKPt9GnrYaWkq9L5pArJ908NecjlCA4
         mQH7dfx++2uXmRAEg927ynsKL8sgIaiiYmcQDLo3WB9nj26sSBZUsQeghMEEFUQVdxC3
         zw9xOJwelKOJJlcbie591op435Wysbtnz/NnWAOHeN/FX5sFxUUCIYGR19BkcYMRLR2T
         dsrn+WG+SBz/Ea5zytVYYAReI89sB0UAysQWzRT7rNsGEedxxLZJqYrskzcDU3wgW2tN
         yE+A==
X-Gm-Message-State: ANhLgQ1YFaT6aXKpgU9Y7kYUKJbzughch8lGztS/d/iU8XZC8W1MJRZo
        DxcoArct1uzQ7o7lTd4qJg==
X-Google-Smtp-Source: ADFU+vtTVaTh4ErY1r3J4rGolmvBW2XDH0JTgJyr0xbDICHp3rUvWkpHPsf8o1a+/+/VwXUnaLV+eQ==
X-Received: by 2002:aca:4183:: with SMTP id o125mr4191140oia.125.1584048410314;
        Thu, 12 Mar 2020 14:26:50 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 81sm7434414otu.51.2020.03.12.14.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 14:26:49 -0700 (PDT)
Received: (nullmailer pid 29652 invoked by uid 1000);
        Thu, 12 Mar 2020 21:26:48 -0000
Date:   Thu, 12 Mar 2020 16:26:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergey.Semin@baikalelectronics.ru
List-Id: <soc.lore.kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] soc: Add Baikal-T1 SoC APB/AXI EHB and L2-cache
 drivers
Message-ID: <20200312212648.GC27332@bogus>
References: <20200306130731.938808030702@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306130731.938808030702@mail.baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 04:07:15PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
> 
> Aside from PCIe/SATA/DDR/I2C/CPU-reboot specific settings the Baikal-T1
> system controller provides three vendor-specific blocks. In particular
> there are two Errors Handler Blocks to detect and report an info regarding
> any problems discovered on the AXI and APB buses. These are the main buses
> utilized by the SoC devices to interact with each other. In addition there
> is a way to tune the MIPS P5600 CM2 L2-cache up by setting the Tag/Data/WS
> L2-to-RAM latencies. All of this functionality is implemented in the
> APB/AXI EHB and L2-cache control block drivers to be a part of the kernel soc
> subsystem (as being specific to the Baikal-T1 SoC) and introduced in the
> framework of this patchset.
> 
> This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
> commit 98d54f81e36b ("Linux 5.6-rc4").
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>
> Cc: Vadim Vlasov <V.Vlasov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: soc@kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (6):
>   dt-bindings: Add Baikal-T1 AXI-bus EHB dts bindings file
>   dt-bindings: Add Baikal-T1 APB-bus EHB dts bindings file

These 2 look fine other than the same comments given on your other 
patches.

Rob
