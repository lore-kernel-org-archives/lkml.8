Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AE2C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D30620663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="Uq0OIrNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgG0McI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgG0McH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:32:07 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36E6C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 05:32:07 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k8so4254405wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 05:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C8QbR5zyTiJb36EsILccvSdIsabewYNUHO3eZE7AkKM=;
        b=Uq0OIrNcpnUv/3tRWpwWrUirps2u80D93FiEvNpCNX9TnzyLtPdhfHmK7Vcj7sz4ET
         EU+WmAuhPmuk4MPZAOxxVbytnrZKsFy3pNNflebMHcoYmglII1cAHAhGUhxLdGmIE5HQ
         b1k6niaVPiuyXKq/+owU7WRJS4D4TDPRfGHRJPB+iOOy/crYsLhp0TyBk0giGX0tyv82
         qbuvylyj3eKNQXezMeK5LatVFzFnVy0hWU9bl9cfyO6vCwhrNa6oWz57TtCf+XpgkVmK
         rkWbxvs9q3BFu6vL/gLclpVvNuUJ2w9Z9gRfEU2Gqo6T1zJNltq9rzARp6l1HsYH41jB
         XTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C8QbR5zyTiJb36EsILccvSdIsabewYNUHO3eZE7AkKM=;
        b=PcHFp77CVLeK6xlJZbQENJwQEFVZExfeagQ66Dyyi3ZEzD+se+r9QrQERwoFaqDOKg
         w5HsbyTuO0ukUVWsfJWV1JnwUiyZ8JKNIlZG14vUhckG8ns/tixYCosee4Vo6KOhDwF5
         ZbPfJls43Hl9pEZGrLlUUJkSJqszsqn1W1h9kFpMAzu1ltlfXCT+Hi6kKS7NzrGmQ1Pf
         LHjlta0S6A3Y5HB36wAwVIVAfyFJaTLSYQpsmxYIwkO26MhwQCaN9ohHHIEdF2GWHgfU
         wXtuwP5nvcfPGJA5azgaE4ShpX6Jcl5EEXVebHS1nHrHWEiGOdB4ov3BgjnjbFJvTIRn
         eIrg==
X-Gm-Message-State: AOAM532A7KkVxJIivt2ZMkI70nyGrZ86hM1GBO4qEVweN+XqyXMx6aiG
        4+Swnlkm+htblQH03KPVzhLI0CR4aYc=
X-Google-Smtp-Source: ABdhPJyxMPsRhgOKke1Ay34HuSeOUlftnnlzvU3RF4higjoaRg1DtCpzPlqDKkYQacOY2TZxW8k1QQ==
X-Received: by 2002:a1c:3102:: with SMTP id x2mr21549194wmx.171.1595853126361;
        Mon, 27 Jul 2020 05:32:06 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id h10sm12370520wro.57.2020.07.27.05.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 05:32:05 -0700 (PDT)
Date:   Mon, 27 Jul 2020 14:32:05 +0200
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
Message-ID: <20200727123205.GJ2216@nanopsycho>
References: <20200727122242.32337-1-vadym.kochan@plvision.eu>
 <20200727122242.32337-3-vadym.kochan@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727122242.32337-3-vadym.kochan@plvision.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jul 27, 2020 at 02:22:38PM CEST, vadym.kochan@plvision.eu wrote:
>Add PCI interface driver for Prestera Switch ASICs family devices, which
>provides:
>
>    - Firmware loading mechanism
>    - Requests & events handling to/from the firmware
>    - Access to the firmware on the bus level
>
>The firmware has to be loaded each time the device is reset. The driver
>is loading it from:
>
>    /lib/firmware/marvell/prestera_fw-v{MAJOR}.{MINOR}.img
>
>The full firmware image version is located within the internal header
>and consists of 3 numbers - MAJOR.MINOR.PATCH. Additionally, driver has
>hard-coded minimum supported firmware version which it can work with:
>
>    MAJOR - reflects the support on ABI level between driver and loaded
>            firmware, this number should be the same for driver and loaded
>            firmware.
>
>    MINOR - this is the minimum supported version between driver and the
>            firmware.
>
>    PATCH - indicates only fixes, firmware ABI is not changed.
>
>Firmware image file name contains only MAJOR and MINOR numbers to make
>driver be compatible with any PATCH version.
>
>Signed-off-by: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
>Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
>Acked-by: Jiri Pirko <jiri@mellanox.com>

You have to remove the tag if you change the patch from last tagged
version...


>---
>PATCH v4:
>    1) Get rid of "packed" attribute for the fw image header, it is
>       already aligned.
>
>    2) Cleanup not needed initialization of variables which are used in
>       readl_poll_timeout() helpers.
>
>    3) Replace #define's of prestera_{fw,ldr}_{read,write} to static funcs.
>
>    4) Use pcim_ helpers for resource allocation
>
>    5) Use devm_zalloc() for struct prestera_fw instance allocation.
>
>    6) Use module_pci_driver(prestera_pci_driver) instead of module_{init,exit}.
>
>    7) Use _MS prefix for timeout #define's.
>
>    8) Use snprintf for firmware image path generation instead of using
>       macrosses.
>
>    9) Use memcpy_xxxio helpers for IO memory copying.
>
>   10) By default use same build type ('m' or 'y') for
>       CONFIG_PRESTERA_PCI which is used by CONFIG_PRESTERA.
>

[...]
