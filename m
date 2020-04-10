Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58ECC2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62EA214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586540366;
	bh=lsW1XylAhRrE+2PihXFwoHlQemalYVa78vGEf+9QwmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=027RDfaZ8w/H0bLXwt4hpcymJEsPw7sMA24HS41dN9Z48SHYyv3gItBDEGpWwpFtx
	 W8BMRkObrXr0X9KnptqIS32hOtPM3mLAVX6HibaLz71zIq108g4d7cwzcnLBzOOYd9
	 qg41LbA8Y0H7KsDOTSChfUt5bpi99PD1hgg/HtY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgDJRjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:39:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42505 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgDJRjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:39:25 -0400
Received: by mail-oi1-f195.google.com with SMTP id e4so1954361oig.9;
        Fri, 10 Apr 2020 10:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UVlxIE0CSKdKwuyXIBQDvbaJJFV3N43f9jUNTBByOKM=;
        b=oV6SLID4+Gi2Tugy1dlLl9zVvXhpadhUPmlPgEKPqC+Q5ihE9il4EtDc/MavWkerEI
         3aK5pQ7zZMvzX3ovdmDRnU3z/SjNR1OWYWJ+A88l/2W+uypQ/7iJYS+No/UoQHmM84X8
         NNIFqjgtH/PDr1tikW+DsYjuqVYxp/IjUFUezNgtiNjgq5ktZkm6mqo/6danKssxzvl0
         +WGJ9b4zyFlNfeNqzta3zZE6veCtzQr68/7ZSU2nuJ8v6M3X4e9WgoYOqmS1J2qK4E2Q
         JN+xp3vDqQ8oIUo4L/4iIa3oxHWajHiL1iAsw1ZFeAuYcj3TEH/nIuiTNaPSKwUt9fYQ
         mLgA==
X-Gm-Message-State: AGi0PuZtGcZmcqwCtMX79L4accWSNqkKSrxrvQiBCpV3yYqjF0tcNORg
        XDQQP933XWIaXlMQjbs/rA==
X-Google-Smtp-Source: APiQypIbEr9eAuDn8ap/2ErWe8F05Nq4R1u7xjJ+3zCkjJKKNwFWVUzijYYdI42B6WOSqS3yiJsmAw==
X-Received: by 2002:a05:6808:1c1:: with SMTP id x1mr3845478oic.55.1586540363863;
        Fri, 10 Apr 2020 10:39:23 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.cgn.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id d21sm1480776otp.39.2020.04.10.10.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:39:23 -0700 (PDT)
Received: (nullmailer pid 6854 invoked by uid 1000);
        Fri, 10 Apr 2020 17:33:24 -0000
Date:   Fri, 10 Apr 2020 12:33:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        sfr@canb.auug.org.au, maz@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Alistair Popple <alistair@popple.id.au>,
        Allison Randal <allison@lohutok.net>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "David S. Miller" <davem@davemloft.net>,
        "Desnes A. Nunes do Rosario" <desnesn@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Enrico Weigelt <info@metux.net>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Mackerras <paulus@samba.org>,
        Sasha Levin <sashal@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Hu <weh@microsoft.com>, YueHaibing <yuehaibing@huawei.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] powerpc: Remove Xilinx PPC405/PPC440 support
Message-ID: <20200410173324.GA28512@bogus>
References: <cover.1585575111.git.michal.simek@xilinx.com>
 <9c3e02ffa9812c6f046708b45932d40f33e8817a.1585575111.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c3e02ffa9812c6f046708b45932d40f33e8817a.1585575111.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 03:32:17PM +0200, Michal Simek wrote:
> The latest Xilinx design tools called ISE and EDK has been released in
> October 2013. New tool doesn't support any PPC405/PPC440 new designs.
> These platforms are no longer supported and tested.
> 
> PowerPC 405/440 port is orphan from 2013 by
> commit cdeb89943bfc ("MAINTAINERS: Fix incorrect status tag") and
> commit 19624236cce1 ("MAINTAINERS: Update Grant's email address and maintainership")
> that's why it is time to remove the support fot these platforms.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
> 
> Changes in v2:
> - Based on my chat with Arnd I removed arch/powerpc/xmon/ changes done in
>   v1 to keep them the same as before. (kbuild reported some issues with it
>   too)
> 
>  Documentation/devicetree/bindings/xilinx.txt | 143 ------

Acked-by: Rob Herring <robh@kernel.org>

>  Documentation/powerpc/bootwrapper.rst        |  28 +-
>  MAINTAINERS                                  |   6 -
>  arch/powerpc/Kconfig.debug                   |   2 +-
>  arch/powerpc/boot/Makefile                   |   7 +-
>  arch/powerpc/boot/dts/Makefile               |   1 -
>  arch/powerpc/boot/dts/virtex440-ml507.dts    | 406 ----------------
>  arch/powerpc/boot/dts/virtex440-ml510.dts    | 466 -------------------
>  arch/powerpc/boot/ops.h                      |   1 -
>  arch/powerpc/boot/serial.c                   |   5 -
>  arch/powerpc/boot/uartlite.c                 |  79 ----
>  arch/powerpc/boot/virtex.c                   |  97 ----
>  arch/powerpc/boot/virtex405-head.S           |  31 --
>  arch/powerpc/boot/wrapper                    |   8 -
>  arch/powerpc/configs/40x/virtex_defconfig    |  75 ---
>  arch/powerpc/configs/44x/virtex5_defconfig   |  74 ---
>  arch/powerpc/configs/ppc40x_defconfig        |   8 -
>  arch/powerpc/configs/ppc44x_defconfig        |   8 -
>  arch/powerpc/include/asm/xilinx_intc.h       |  16 -
>  arch/powerpc/include/asm/xilinx_pci.h        |  21 -
>  arch/powerpc/kernel/cputable.c               |  39 --
>  arch/powerpc/platforms/40x/Kconfig           |  31 --
>  arch/powerpc/platforms/40x/Makefile          |   1 -
>  arch/powerpc/platforms/40x/virtex.c          |  54 ---
>  arch/powerpc/platforms/44x/Kconfig           |  37 --
>  arch/powerpc/platforms/44x/Makefile          |   2 -
>  arch/powerpc/platforms/44x/virtex.c          |  60 ---
>  arch/powerpc/platforms/44x/virtex_ml510.c    |  30 --
>  arch/powerpc/platforms/Kconfig               |   4 -
>  arch/powerpc/sysdev/Makefile                 |   2 -
>  arch/powerpc/sysdev/xilinx_intc.c            |  88 ----
>  arch/powerpc/sysdev/xilinx_pci.c             | 132 ------
>  drivers/char/Kconfig                         |   2 +-
>  drivers/video/fbdev/Kconfig                  |   2 +-
>  34 files changed, 7 insertions(+), 1959 deletions(-)
