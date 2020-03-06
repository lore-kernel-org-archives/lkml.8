Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092DFC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03062072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCFPUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:20:07 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:48809 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgCFPUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:20:06 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N8GIg-1jNUMH03KC-0148iI; Fri, 06 Mar 2020 16:20:05 +0100
Received: by mail-qk1-f174.google.com with SMTP id m2so2601004qka.7;
        Fri, 06 Mar 2020 07:20:04 -0800 (PST)
X-Gm-Message-State: ANhLgQ1ztapImf/TF7izxXZYY+yMZmpsq14Dy/VxnUEeUNbv3hG20jgq
        ZoUKWuVLw3PwURcK7PaUJT9kXR+XSEfOxgSCpHk=
X-Google-Smtp-Source: ADFU+vufZPHP+TppGOZW5QjlzXWUqAwno1bdHUSLyQt8BGmVonEBwnWghv2NJiZ/9FOo5rQAcp9UJZT+y9VpV1BQp2w=
X-Received: by 2002:a37:6285:: with SMTP id w127mr3368332qkb.138.1583508003820;
 Fri, 06 Mar 2020 07:20:03 -0800 (PST)
MIME-Version: 1.0
References: <20200306130731.938808030702@mail.baikalelectronics.ru>
In-Reply-To: <20200306130731.938808030702@mail.baikalelectronics.ru>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Mar 2020 16:19:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0PjNS9+sAiPnDgkmLsnJ6=hR_Vk8oqe493t-Ad_mGa9w@mail.gmail.com>
Message-ID: <CAK8P3a0PjNS9+sAiPnDgkmLsnJ6=hR_Vk8oqe493t-Ad_mGa9w@mail.gmail.com>
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
X-Provags-ID: V03:K1:tWjSFtoMxD0+al/G5LcUpGozeIODMqEIzgvKS3RHs77zhysbgWy
 KkvUQaXgBMBp8aPw9hCDFul0gsWw3y5dh4t4LNj9t1T7jFmJt4Qia1IbNEtww/zcC92CkV7
 0uqYkl10cCzHrp8xlRF/9cEiDY1wTpW4zBNjpz22ice21EP7RbOiaCdOCotLyaTrOcK5evG
 UEkTfdwjviK65oziltvLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y78nN/XHQXk=:cOmcmHQWnOtHX0ReQZyqIQ
 oqNesC31b5Sl8tr0/wqkML9XXhe011ALOX3worZU6mUrH3E+fM/krQmEqadqqy1s4XZoScBuv
 qE1oSkzwtgckqKT7F1PSM1OQkOx5zzJzoKCQKIsN1tuNzYkx5GrltplhhruCGFl4PtDFjkwT8
 2xIi/+FEE0RiE5o6QB6VEFtVc1wZcJTj6SoQQNI+hBaOiXmAuXmW3Ei2khOqz/xZ4mT+vkfu9
 ofRYNXpQ+ywoyHDCcJ0zi8i+Im4E/1qv5vaPdeQOaKEZschidbKqSNmXDQormTNtFdZSzlxkn
 SjQ44QbuEm8cvO0tCb7mUzynRUWXgLzaMkw/vBz4UrbPjodmCXAWMZkZ9rHI2vf9lILsb5KU+
 t6d5vbG8k/5Elg2vDlYOUw6qSsEFrw5CUDpdUKPmsS+Jm5g85ZXDWqWTfLC+M4/T7+WvdP9rE
 FKI3LyRYcixvdTG+SqvSPqlz3myXNnzM/Z5muhfylFUVfOUmda9DG8q+zzBi6vtPDJ55UeZJm
 BZGvNEmMRZSorM7zgL/Yn+Zw+FnunVdZsFfi3NGzFcbXQGNOr2u/Lwa5oVf2AXrl2P6DQ/Q45
 DV3T+LtcWuTPv8VztAvNjHw8+AgehyFZ95CFqu7waFdo8MdIaPVDbBoTcnxhjM9tZhqotw527
 XxUIJ4Az1y6dasASBb3IDQFqjcXl8vHe3/Y7PifPgBWL8un/6vVMjDyJUbgf/hzawvQ0v/jLA
 SxHLP1lif4ZWtLSQw31HC+UV58WGT3tfVsUya69MFkmR3w2AKI6Ku6j/L5Zo/RPjbuX+akqNA
 O/ayOYMzoTpkXr/eE6jnKThMLFZR7tk61NW/KHH4Sd/5KRyMCQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 2:07 PM <Sergey.Semin@baikalelectronics.ru> wrote:
>
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

I have no objection to the drivers, but I wonder if these should be
in drivers/bus and drivers/memory instead of drivers/soc, which have
similar drivers already. The driver for the L2 cache is not really a
memory controller driver, but it may be close enough, and we
already have a couple of different things in there.

          Arnd
