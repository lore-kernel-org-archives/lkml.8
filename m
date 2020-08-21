Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3179C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C462078B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgHUPnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:43:07 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:16614
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728251AbgHUPmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:42:54 -0400
X-IronPort-AV: E=Sophos;i="5.76,337,1592863200"; 
   d="scan'208";a="356998838"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 17:42:47 +0200
Date:   Fri, 21 Aug 2020 17:42:47 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: api: add kobj_to_dev.cocci script
In-Reply-To: <20200821153100.434332-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2008211741360.2486@hadrien>
References: <20200821153100.434332-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Aug 2020, Denis Efremov wrote:

> Use kobj_to_dev() instead of container_of().

Thanks for the patch and the example commits.

Could you add

symbol kobj;

to the first rule?  That's enough to get rid of the question about whether
kobj should be a metavariable in all cases.

thanks,
julia

>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> Examples of such patches:
> 893c3d82b425 watchdog: Use kobj_to_dev() API
> 23fd63a44460 hwmon: (nct6683) Replace container_of() with  kobj_to_dev()
> 224941c9424f power: supply: use kobj_to_dev
> a9b9b2af40c7 backlight: lm3533_bl: Use kobj_to_dev() instead
> 0acb47a3a093 qlcnic: Use kobj_to_dev() instead
> 97cd738c44c8 gpiolib: sysfs: use kobj_to_dev
> d06f9e6c8960 hwmon: (nct7802) Replace container_of() API
> 036855a4c3b3 hwmon : (nct6775) Use kobj_to_dev() API
> baf1d9c18293 driver/base/soc: Use kobj_to_dev() API
> ae243ef0afbc rtc: sysfs: use kobj_to_dev
> 6b060d8a09e9 i2c: use kobj_to_dev() API
> 9e7bd945b9a9 scsi: core: use kobj_to_dev
> 0d730b57b95f s390/cio: use kobj_to_dev() API
> 0616ca73fd35 usb: use kobj_to_dev() API
> 8c9b839c0b80 alpha: use kobj_to_dev()
> 016c0bbae1d1 netxen: Use kobj_to_dev()
> 6908b45eafc4 GenWQE: use kobj_to_dev()
> 85f4f39c80e9 pch_phub: use kobj_to_dev()
> 47679cde604d misc: c2port: use kobj_to_dev()
> 85016ff33f35 misc: cxl: use kobj_to_dev()
> 092462c2b522 misc: eeprom: use kobj_to_dev()
> a9c9d9aca4e7 zorro: Use kobj_to_dev()
> a253f1eee6c4 rapidio: use kobj_to_dev()
> e3837b00b6bb drm/radeon: use kobj_to_dev()
> cc29ec874b37 drm/amdgpu: use kobj_to_dev()
> d122cbf1a310 drm/sysfs: use kobj_to_dev()
> 657fb5fbadb3 drm/i915: use kobj_to_dev()
> 554a60379aaa PCI: Use kobj_to_dev() instead of open-coding it
> 2cf83833fc9c HID: use kobj_to_dev()
> aeb7ed14fe5d bridge: use kobj_to_dev instead of to_dev
> 8e3829c61b48 staging:iio:adis16220: Use kobj_to_dev instead of open-coding it
> b0d1f807f340 driver-core: Use kobj_to_dev instead of re-implementing it
>
>  scripts/coccinelle/api/kobj_to_dev.cocci | 44 ++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 scripts/coccinelle/api/kobj_to_dev.cocci
>
> diff --git a/scripts/coccinelle/api/kobj_to_dev.cocci b/scripts/coccinelle/api/kobj_to_dev.cocci
> new file mode 100644
> index 000000000000..e2cdd424aeca
> --- /dev/null
> +++ b/scripts/coccinelle/api/kobj_to_dev.cocci
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Use kobj_to_dev() instead of container_of()
> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +// Keywords: kobj_to_dev, container_of
> +//
> +
> +virtual context
> +virtual report
> +virtual org
> +virtual patch
> +
> +
> +@r depends on !patch@
> +expression ptr;
> +position p;
> +@@
> +
> +* container_of(ptr, struct device, kobj)@p
> +
> +
> +@depends on patch@
> +expression ptr;
> +@@
> +
> +- container_of(ptr, struct device, kobj)
> ++ kobj_to_dev(ptr)
> +
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for kobj_to_dev()")
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for kobj_to_dev()")
> --
> 2.26.2
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
