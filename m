Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCB6C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28ED206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgCZONH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:13:07 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:48581 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZONG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:13:06 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MRCFw-1iuQaa14gW-00NDbH; Thu, 26 Mar 2020 15:13:04 +0100
Received: by mail-qk1-f177.google.com with SMTP id c145so6457126qke.12;
        Thu, 26 Mar 2020 07:13:04 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0eyy0uai5lL1l/i5q18Ill0sVn5kBKAXaLxZuPBzFWz+BPQrf8
        Rli2QQdic93jTtnQpoGEAbPkxQRx/I/87lBesiU=
X-Google-Smtp-Source: ADFU+vucsMd+oZ2pYuI+xXVs5Rm+lhEKKuWhmVOOyPIrD9S5kaedqvp5TnV/CLaRXxU7UVw6MVYWr8UxvWXNXJTBF4I=
X-Received: by 2002:a37:8707:: with SMTP id j7mr8352402qkd.394.1585231982997;
 Thu, 26 Mar 2020 07:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200306130731.938808030702@mail.baikalelectronics.ru> <CAK8P3a0PjNS9+sAiPnDgkmLsnJ6=hR_Vk8oqe493t-Ad_mGa9w@mail.gmail.com>
In-Reply-To: <CAK8P3a0PjNS9+sAiPnDgkmLsnJ6=hR_Vk8oqe493t-Ad_mGa9w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 26 Mar 2020 15:12:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3ztmzeDBET=jgX=LDCBVg8FKkQrcBOLzaStgUXRyG3jQ@mail.gmail.com>
Message-ID: <CAK8P3a3ztmzeDBET=jgX=LDCBVg8FKkQrcBOLzaStgUXRyG3jQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] soc: Add Baikal-T1 SoC APB/AXI EHB and L2-cache drivers
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
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:lBHbv8X13SIrfsQXRLdqag2U0ga2z3euGWwy4OFsy5SDNFreYHf
 3E+RalIE+l9WRwE3m0KGP8rDsG1WtnfXBjgVozQT7QQrDByK549DKjTJ2meaDlcIHOB3aD4
 kYiXY5cJSlDEZef9XR6H0wC8QjifOkUJEE8pDJHUeyARIkyzsOTdDHtwjWx7v4s6yO0vI1V
 CqQWzyOohKy12uwrB1XGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LIuZfejFZpM=:IB5S4fR8T+x+CNJK4u74ss
 4sXOiz8conB4+nuatX1mwdi60QKXdP2FG7v9sFoysQwUAkYwxSQKZjH/rwXFhULRH5gZ+1Lk6
 8sqW6ZjV3FkLbeJEU/9o6fV0IzuREKroD6MKRP72bGMo8BJJMR/+hThdkRdSWUVNBlHSfD0Ym
 gw07jBzmv+3QKeaRL3j4lzCEuoz+HxikwYL/IWzhvVHk4HZgFDr5LQWg0+3lkrUjxGTEFfJB4
 1CxdVb9pMpfSBxnJDO1RSDCJnWHBXgCXIZ6wVmqrVFHAYFbUkPnVn9iFNHNINMh/YBkl9MRI1
 y2Ld3IL7FqQuR9RnGrSV7sXIKVGzs95VEzFKZZpQ3o+z1gEDcjylF8dQZIhaiJHxh5qQ5q35V
 nUdChfktzy4e0XAoLTlLPFDZcxNplSHjvAR+j03aJlhzbhx+tEXDNauqS10vbUTMKE25PUTWp
 yJ4mXSL+uwYlyQllw/d/PdUPiVjSpeZF3oiilACpAIv9VT8XjCfQvqjflD/CuCtqQ6/zphrUi
 HoB5G0c4rV3FWLV78zAsCH6iV5DIvPOqFU0L35QIsJhjgiu/BVCVW5yI/OKGGZTNngeLHRM6m
 yLtS7rFE++TfTnDjpjtz3fIkhPGoODJ95vDGj9H4HnwCzE8VQXSzxfbIHDCs4YWcA3YocXV1u
 wYnUpFdoDN0oj247IvV/0TENcizEoICJOXLi8BqW4Fgqpr81YZm5vreO7ob+x1WOxAU6UJewD
 FmvERxFoAlYGJ77pYXoTkYrgUw9nFNtifLWUtnN0IGbiyPeffVRmIYUDBv8diR0M8z1Fselxx
 cQIeHEQ62BOe+/Vt8wyY2mpqiuupi60OluGi74hSOVRCv5Wz/I=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 4:19 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Mar 6, 2020 at 2:07 PM <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > From: Serge Semin <fancer.lancer@gmail.com>
> >
> > Aside from PCIe/SATA/DDR/I2C/CPU-reboot specific settings the Baikal-T1
> > system controller provides three vendor-specific blocks. In particular
> > there are two Errors Handler Blocks to detect and report an info regarding
> > any problems discovered on the AXI and APB buses. These are the main buses
> > utilized by the SoC devices to interact with each other. In addition there
> > is a way to tune the MIPS P5600 CM2 L2-cache up by setting the Tag/Data/WS
> > L2-to-RAM latencies. All of this functionality is implemented in the
> > APB/AXI EHB and L2-cache control block drivers to be a part of the kernel soc
> > subsystem (as being specific to the Baikal-T1 SoC) and introduced in the
> > framework of this patchset.
> >
> > This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
> > commit 98d54f81e36b ("Linux 5.6-rc4").
>
> I have no objection to the drivers, but I wonder if these should be
> in drivers/bus and drivers/memory instead of drivers/soc, which have
> similar drivers already. The driver for the L2 cache is not really a
> memory controller driver, but it may be close enough, and we
> already have a couple of different things in there.

I don't see a reply to Rob's or my comments, so I assume you are not currently
updating them and I will wait for a new version after the v5.7 merge window.

Dropping the series from patchwork for now, see [1].

       Arnd

[1] https://patchwork.kernel.org/project/linux-soc/list/
