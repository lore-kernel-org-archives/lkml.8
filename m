Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F21EC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4163E2051A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgBKJkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:40:16 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32994 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbgBKJkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:40:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 24040293ECA
Subject: Re: [PATCH] platform/chrome: wilco_ec: Include asm/unaligned instead
 of linux/ path
To:     Stephen Boyd <swboyd@chromium.org>,
        Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Nick Crews <ncrews@chromium.org>,
        kbuild test robot <lkp@intel.com>
References: <20200203174619.68861-1-swboyd@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <e4bdff9a-4cd9-70a2-7625-accc6146e063@collabora.com>
Date:   Tue, 11 Feb 2020 10:40:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200203174619.68861-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 3/2/20 18:46, Stephen Boyd wrote:
> It seems that we shouldn't try to include the include/linux/ path to
> unaligned functions. Just include asm/unaligned.h instead so that we
> don't run into compilation warnings like below.
> 
>    In file included from drivers/platform/chrome/wilco_ec/properties.c:8:0:
>    include/linux/unaligned/le_memmove.h:7:19: error: redefinition of 'get_unaligned_le16'
>     static inline u16 get_unaligned_le16(const void *p)
>                       ^~~~~~~~~~~~~~~~~~
>    In file included from arch/ia64/include/asm/unaligned.h:5:0,
>                     from arch/ia64/include/asm/io.h:23,
>                     from arch/ia64/include/asm/smp.h:21,
>                     from include/linux/smp.h:68,
>                     from include/linux/percpu.h:7,
>                     from include/linux/arch_topology.h:9,
>                     from include/linux/topology.h:30,
>                     from include/linux/gfp.h:9,
>                     from include/linux/xarray.h:14,
>                     from include/linux/radix-tree.h:18,
>                     from include/linux/idr.h:15,
>                     from include/linux/kernfs.h:13,
>                     from include/linux/sysfs.h:16,
>                     from include/linux/kobject.h:20,
>                     from include/linux/device.h:16,
>                     from include/linux/platform_data/wilco-ec.h:11,
>                     from drivers/platform/chrome/wilco_ec/properties.c:6:
>    include/linux/unaligned/le_struct.h:7:19: note: previous definition of 'get_unaligned_le16' was here
>     static inline u16 get_unaligned_le16(const void *p)
>                       ^~~~~~~~~~~~~~~~~~
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 60fb8a8e93ca ("platform/chrome: wilco_ec: Allow wilco to be compiled in COMPILE_TEST")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

Queued as a fix for 5.6. Thanks,

  Enric
