Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87629C4BA15
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E64C206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="PWVHdGOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgBZQbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:31:36 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43840 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgBZQbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:31:36 -0500
Received: by mail-ed1-f65.google.com with SMTP id dc19so4482351edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 08:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1w+58dOrrZr3wo5mk8rJB/ZJsesTkU2LXg6fDoYot4=;
        b=PWVHdGOKeZeBrmZqjFNWON3PpXWLD/9F+byeDjIJWy+ytRge7nUh9NGmyX86dkURx+
         e0mLG9bX4960huPEWOL+TWR+I1cgCsC/A9WJEuvwqSBaMzaTqV0o7c4/0zm9hdj7F82H
         URmRnPcaEgXmpKdkbmcIvzfhb5rKpkH41i0l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1w+58dOrrZr3wo5mk8rJB/ZJsesTkU2LXg6fDoYot4=;
        b=CE8BDyhPoNxWQVZcvf3b4VAkktP9DTzFIi2mvd8KGS9Ezh95QBR+r2ATPEMYnRsqYs
         YE6IfXA8d7WZA1vTihKSIqmnNs4np4CqP7QzFx+KHM9wUFnHvSESeuxHheK11INfhNxb
         AMGdlIdZ9pPQhAgYG0Cv/JnIBHbZQvP68Efl5SPf3NXpR9zjv0CobCbnHJ7cPg6Wd8k/
         VblcDVmm+YF7cOBOgLcQgjq9JZ7X5PpW/b5/iMcm/RLu67kA8MW3A7zyRyX2jF3Qapeg
         5qdTHgMxPwyE3ydnev9FJFo5Wsn+hZLWzPX6iew6agt+MOADrub2AhOS5cdNrxMrdfXQ
         IzHw==
X-Gm-Message-State: APjAAAUt0bJjJnuc8T2+h83UhDNt8OZT8fW6rVJkaQgcRm5qiMZIxIAG
        W0pdznB7RJ6TdUkdknlGfSztJpozLSe5rrhEc7Mb/w==
X-Google-Smtp-Source: APXvYqzrSAOseHb5MIcTw/nawhJsW3ES0aHkvgiuyVEnigJi8uZOuBz/tTxOvsOzYVVPzvAU4zYwgIzxXALT47g6rdA=
X-Received: by 2002:a17:906:f105:: with SMTP id gv5mr5259642ejb.135.1582734694188;
 Wed, 26 Feb 2020 08:31:34 -0800 (PST)
MIME-Version: 1.0
References: <20200225163025.9430-1-vadym.kochan@plvision.eu>
In-Reply-To: <20200225163025.9430-1-vadym.kochan@plvision.eu>
From:   Roopa Prabhu <roopa@cumulusnetworks.com>
Date:   Wed, 26 Feb 2020 08:38:32 -0800
Message-ID: <CAJieiUg8ycCnNtUCuHfc55nQXCQx9+f4rdw161AM+py3i2zpfg@mail.gmail.com>
Subject: Re: [RFC net-next 0/3] net: marvell: prestera: Add Switchdev driver
 for Prestera family ASIC device 98DX326x (AC3x)
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Serhiy Boiko <serhiy.boiko@plvision.eu>,
        Andrii Savka <andrii.savka@plvision.eu>,
        Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
        David Ahern <dsahern@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 8:31 AM Vadym Kochan <vadym.kochan@plvision.eu> wrote:
>
> Marvell Prestera 98DX326x integrates up to 24 ports of 1GbE with 8
> ports of 10GbE uplinks or 2 ports of 40Gbps stacking for a largely
> wireless SMB deployment.
>
> Prestera Switchdev is a firmware based driver which operates via PCI
> bus. The driver is split into 2 modules:
>
>     - prestera_sw.ko - main generic Switchdev Prestera ASIC related logic.
>
>     - prestera_pci.ko - bus specific code which also implements firmware
>                         loading and low-level messaging protocol between
>                         firmware and the switchdev driver.
>
> This driver implementation includes only L1 & basic L2 support.
>
> The core Prestera switching logic is implemented in prestera.c, there is
> an intermediate hw layer between core logic and firmware. It is
> implemented in prestera_hw.c, the purpose of it is to encapsulate hw
> related logic, in future there is a plan to support more devices with
> different HW related configurations.
>
> The firmware has to be loaded each time device is reset. The driver is
> loading it from:
>
>     /lib/firmware/marvell/prestera_fw_img.bin
>
> The firmware image version is located within internal header and consists
> of 3 numbers - MAJOR.MINOR.PATCH. Additionally, driver has hard-coded
> minimum supported firmware version which it can work with:
>
>     MAJOR - reflects the support on ABI level between driver and loaded
>             firmware, this number should be the same for driver and
>             loaded firmware.
>
>     MINOR - this is the minimal supported version between driver and the
>             firmware.
>
>     PATCH - indicates only fixes, firmware ABI is not changed.
>
> The firmware image will be submitted to the linux-firmware after the
> driver is accepted.
>
> The following Switchdev features are supported:
>
>     - VLAN-aware bridge offloading
>     - VLAN-unaware bridge offloading
>     - FDB offloading (learning, ageing)
>     - Switchport configuration
>
> CPU RX/TX support will be provided in the next contribution.
>
> Vadym Kochan (3):
>   net: marvell: prestera: Add Switchdev driver for Prestera family ASIC
>     device 98DX325x (AC3x)
>   net: marvell: prestera: Add PCI interface support
>   dt-bindings: marvell,prestera: Add address mapping for Prestera
>     Switchdev PCIe driver
>

Have not looked at the patches yet, but very excited to see another
switchdev driver making it into the kernel!.

Thanks Marvell!.
