Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30689C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EAE92075A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="1WwtTjBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgG0NC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgG0NC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:02:57 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8551C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 06:02:56 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a8so12071224edy.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 06:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k2E5R0AKcBuEyUUw+LZpqSNWjUjho4eY1h7Kd+9PG80=;
        b=1WwtTjBrKbFTRCbux9Hrsg8wz72ddusGilZdTPqH/LbOjU9iqFyVCnYpvOieoAP5GC
         WKQXUP1TMGsQ9wdFGDCQd2NcuHQtmJC/bAq2A+99RuNLVQnwc6uoTYEYr9qeIzpgGFOQ
         LVGjbU6ktzgWy8BPjywxj+KkOIOf+1/Dw/soy0jF8m/3x9W0rvYxURiDBynhy5uElQsZ
         JTcWBLmrrUNWbPAYQzi83AR9NX8wceERtCYTlrNefjyt+iUhvz76ZwEzdlSAOR76ut6e
         yD4bRSut1rkYpThlOByDLH2ZRPZMLo34uF2EqJUYe6ocSLfmO0GsFGI9ryI9APK17ahD
         S+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k2E5R0AKcBuEyUUw+LZpqSNWjUjho4eY1h7Kd+9PG80=;
        b=m1sbYhR35DxG6venooJ3sHH1euVVoJl65fscB3OzWTQSqycWjeuvP3JDE+V7lw3AL3
         A/zmonNG+TI7+C/9rhb/THJLtaFSpL+e/RhKgKOxsUhGI6CpDUzCbdyXbiz0Kc/0Vef8
         zb3U03LHaMRO56ByIqzEYuB/Si2yKsLogCTbBzOBkkPcjCMyOH401H6S7MTTQ9ftq/Id
         QzOBujfnpR5j14i6Fj6epbMGZpzCXeaw4EonkhsUTnJUg1CyUHDqSLcLTsxuqNzKYhTD
         RGEOPfQR8486z+xpK4axsZXRiJQw9WM/1h3BAIIb04cFxrlSk4ym4Ftbja09Rlr8TxP+
         cmcg==
X-Gm-Message-State: AOAM5336oox87sxriLozrBuDM99ZtpauNQApk14ZgHfDD8oog7guEnzd
        POJ5ZhEQ00iSberyN5VgkoJWLw==
X-Google-Smtp-Source: ABdhPJxEz1JkRp53mKPztoB6DzeekHTJMXWYD+sHV3ZOI9HIKs5QTnLbIEkbdwUgKvpsxVyRUAjvZg==
X-Received: by 2002:aa7:c341:: with SMTP id j1mr22010074edr.197.1595854975588;
        Mon, 27 Jul 2020 06:02:55 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id h27sm7055362eje.23.2020.07.27.06.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 06:02:55 -0700 (PDT)
Date:   Mon, 27 Jul 2020 15:02:53 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        Serhiy Boiko <serhiy.boiko@plvision.eu>,
        Serhiy Pshyk <serhiy.pshyk@plvision.eu>,
        Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Andrii Savka <andrii.savka@plvision.eu>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mickey Rachamim <mickeyr@marvell.com>
Subject: Re: [net-next v4 2/6] net: marvell: prestera: Add PCI interface
 support
Message-ID: <20200727130253.GK2216@nanopsycho>
References: <20200727122242.32337-1-vadym.kochan@plvision.eu>
 <20200727122242.32337-3-vadym.kochan@plvision.eu>
 <20200727123205.GJ2216@nanopsycho>
 <20200727123553.GC21360@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727123553.GC21360@plvision.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jul 27, 2020 at 02:35:53PM CEST, vadym.kochan@plvision.eu wrote:
>Hi Jiri,
>
>On Mon, Jul 27, 2020 at 02:32:05PM +0200, Jiri Pirko wrote:
>> Mon, Jul 27, 2020 at 02:22:38PM CEST, vadym.kochan@plvision.eu wrote:
>> >Add PCI interface driver for Prestera Switch ASICs family devices, which
>> >provides:
>> >
>> >    - Firmware loading mechanism
>> >    - Requests & events handling to/from the firmware
>> >    - Access to the firmware on the bus level
>> >
>> >The firmware has to be loaded each time the device is reset. The driver
>> >is loading it from:
>> >
>> >    /lib/firmware/marvell/prestera_fw-v{MAJOR}.{MINOR}.img
>> >
>> >The full firmware image version is located within the internal header
>> >and consists of 3 numbers - MAJOR.MINOR.PATCH. Additionally, driver has
>> >hard-coded minimum supported firmware version which it can work with:
>> >
>> >    MAJOR - reflects the support on ABI level between driver and loaded
>> >            firmware, this number should be the same for driver and loaded
>> >            firmware.
>> >
>> >    MINOR - this is the minimum supported version between driver and the
>> >            firmware.
>> >
>> >    PATCH - indicates only fixes, firmware ABI is not changed.
>> >
>> >Firmware image file name contains only MAJOR and MINOR numbers to make
>> >driver be compatible with any PATCH version.
>> >
>> >Signed-off-by: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
>> >Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
>> >Acked-by: Jiri Pirko <jiri@mellanox.com>
>> 
>> You have to remove the tag if you change the patch from last tagged
>> version...
>> 
>OK, sorry, makes sense, should I re-spin with v5 or wait when the status
>is changed to 'Changes Requested' in the patchwork ?

Np. I will review this patch again.

>
>> 
>> >---
>> >PATCH v4:
>> >    1) Get rid of "packed" attribute for the fw image header, it is
>> >       already aligned.
>> >
>> >    2) Cleanup not needed initialization of variables which are used in
>> >       readl_poll_timeout() helpers.
>> >
>> >    3) Replace #define's of prestera_{fw,ldr}_{read,write} to static funcs.
>> >
>> >    4) Use pcim_ helpers for resource allocation
>> >
>> >    5) Use devm_zalloc() for struct prestera_fw instance allocation.
>> >
>> >    6) Use module_pci_driver(prestera_pci_driver) instead of module_{init,exit}.
>> >
>> >    7) Use _MS prefix for timeout #define's.
>> >
>> >    8) Use snprintf for firmware image path generation instead of using
>> >       macrosses.
>> >
>> >    9) Use memcpy_xxxio helpers for IO memory copying.
>> >
>> >   10) By default use same build type ('m' or 'y') for
>> >       CONFIG_PRESTERA_PCI which is used by CONFIG_PRESTERA.
>> >
>> 
>> [...]
