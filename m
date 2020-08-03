Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537FAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E22206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgHCNzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:55:15 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:48397 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgHCNzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:55:15 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MqJuN-1kYMza1Z91-00nQxo for <linux-kernel@vger.kernel.org>; Mon, 03 Aug
 2020 15:55:13 +0200
Received: by mail-qk1-f175.google.com with SMTP id x69so35176818qkb.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 06:55:13 -0700 (PDT)
X-Gm-Message-State: AOAM532jnX2Ie8JYdrn/ifxiALJYvFf3cF4yQ8/blbI6PHo0lFd9qPq1
        +DjzpjZ8ENFa66MlJnzxBD4Fd4pp5DyytXE8TVY=
X-Google-Smtp-Source: ABdhPJwItt/4ioy5OciMfCJ81qQb1OLD+6qsgpSAsbd9VTROSzQ27GXrFX2uRUohteFfQkLpdZ5x64Y+qqo2PEexr9Q=
X-Received: by 2002:a37:6351:: with SMTP id x78mr16250543qkb.394.1596462912141;
 Mon, 03 Aug 2020 06:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200803134449.72502-1-daniel.gutson@eclypsium.com>
In-Reply-To: <20200803134449.72502-1-daniel.gutson@eclypsium.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 3 Aug 2020 15:54:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0rZi9hBsA6+YQCpCdYj6uY6z+cfVVi37jY1aNx7B5iTQ@mail.gmail.com>
Message-ID: <CAK8P3a0rZi9hBsA6+YQCpCdYj6uY6z+cfVVi37jY1aNx7B5iTQ@mail.gmail.com>
Subject: Re: [PATCH] Remove attempt by intel-spi-pci to turn the SPI flash
 chip writeable
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:1ZJjFrwldPObNoLO3imz2xC246qaaPBli2YTEvI5HZek5SlNKjP
 t9QPn3ao8ZkyjIYIwG7qrIdmQw+0lR59cucHAT54PpPZ5zW2WNsLlMnb0XEl/J5SV5YVTch
 wwNwmO3LrXhDLWwdLTRizq3p7w3ON93Ly5CAcoXWBUdyE1ADXaXWFUqt9/JdzUkHpXjhUNl
 E9DwcfNmLtOhIcW+IHkWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0X2G0nZYiZo=:VJU3F+8qZhmrXtQvTLBbYJ
 0BWRHMdQPkv0H4m2lwALOvv9iGMjzFNoNPvs1bOG6TqOxqy1ZXphOcD32wBjQkczXxgWExdBk
 NG59LtGw2NhTbOSLiEBPNtlJDc9l8etamlxoO8T4b0agy5p4XAuQUzi1G02vI9I3jZ0iCfwqQ
 XBwyGjiex3T7assAlR+3AwyuILtBiBLLdapcwAxwAvhYoK58SVv2fUH/OvZSPyCigJRoiboOa
 jkTfDjTsnpookE9FI4Qo5OLbKjZDoQ0tU8P+jDoxuaADYdWd/uqJXYqMrw0/EopoUXkfn4czR
 1+pcOcs87emeuVjGVX5MFSz+empREEscjoxaf9J0Quy3do3rhHJZwtuDYsEEKbywOBdbKV9fa
 b4706Uv0mUPHhl2dax1do8r7VYpZQLQFWJunwEL9ShQ0ibANHvcd5i5FpcinGA8iZA0atOHDp
 kbKwjxiS1q1yathHDwSbNEPPPRosw7DYklEo8dIiNdIbUCiJYcZFSymhuOXkSOR05FxAY+MTc
 l6QxzllkULaFfZdEn9+xRcseIWw5fD4lGjrE4sL8/lMp5LxsWUwz0Vw4U14z2N7vVZNyZEp6b
 DIQVmx+IqZN8nqzKiiFW0qD0w+I51zVAJ1bc8L7xrABSFyjkN2qxrbe3Yi6wzSQNiDvAXlkio
 Zl2D4+ZiIgH/W7tZT208RmCXxLL3JVd+3iErF1oDazYP8M1JTTIZ6nD1dCGCqnwVnwITFfmAC
 TOSR0j8WSOJ0B+0monnmNCjV5SvjcCdXwW9wKEpaVhjodydYp0wRD4dKp7wdm7CA0kpy+dDe3
 fPx4gY/tmXERb8kf5Lr7JU+GkjZxn0L2RmUR0IBAZT67s4CCEzkHJQIcZa8RMUUpOeTih3wnq
 gBPwq9jjZ+X6R0h41rIQIWfstxK7j7sAjNNbTGSpultDy1JnHcTsuRmxafIiAqIXQBzUWhszV
 v/FLqMtV58sswIaSrYE0z6p8HJ3ihwjuSJbFHwNVNN34RbUCJ+wmH
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 3:45 PM Daniel Gutson
<daniel.gutson@eclypsium.com> wrote:

> However, this flag applies only for a number of devices, coming from the
> platform driver, whereas the devices detected through the PCI driver
> (intel-spi-pci) are not subject to this check since the configuration
> takes place in intel-spi-pci which doesn't have an argument.

This part of the description sounds wrong: the current behavior is that
the BIOS setting is ignored for PCI devices and it only uses the module
parameter, the same way as it does for the platform driver.

With your patch, both the BIOS setting and the module parameter
have to explicitly allow writing on PCI devices, while at least for Bay
Trail platform devices the BIOS write protection is still ignored.

It sounds like this is what you want, but you should update the description
accordingly.

      Arnd
