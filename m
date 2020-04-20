Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667FEC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40DEF20782
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="NXWy+rZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgDTRan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726792AbgDTRak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:30:40 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A2BC061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:30:38 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m8so10935947lji.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1wjTQ8kSFEtHQTXiFNn5xmo0XMmmUMj65r7WNBjKJEs=;
        b=NXWy+rZceFxcX4Q1BJl0H6GFSnc8ZUNALstxT4T+qvd8/wDRTj6ZJJvxrBNPnQNrqv
         yxCIbphz2+7r3DPHzNv2pmmsU3LBsO8/U8o4rR5OyMC7a/0ye+6Wx/LpBfCxCrhkLoYC
         qjxGOvLw3i7MDYFX+YK+9yRHVnuKJWeB0zWeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1wjTQ8kSFEtHQTXiFNn5xmo0XMmmUMj65r7WNBjKJEs=;
        b=FOh/NeTaFaHlcP/mNkAnhFSWPIWBmM9ZstMajBa/XewiM7QBMNgNca4ay73hUxOvrB
         igF5ZxTZY9mDG+JVC+zft4r7ITqISMujwYAgzogS85ASOwhWKrHArX64hhzug/3efnR4
         mzpsZelBJfTFsAia+rd+XwMjzPFQ32UzHbPYN2khKtXtwWwzC+Wre3WmZvVmGkHgX02P
         hEZykahxs8JZhAh59H84LL2EeD/k4XlI3W14Rr07xa4CO2lqOfBcqZee3G2lieg3BRMr
         x2AjmevF/AaCXgz6glHAKGbR8sfYPFk0TINfNuCrBELI/0BI6e+yrIzry3dWJRpKI3pe
         zvgA==
X-Gm-Message-State: AGi0PuawSheGcSFCxDwNXQEk/9J0sOELH1tQ6urLrURdzfJRreIeD9cJ
        xm/ErwOX9Ej7K4YuLiLdec7tnQ==
X-Google-Smtp-Source: APiQypKQO2gTG7fbfBVsthNRTh8bjAdJR0WFz6Vc4MxI2oM3VrAN/sw/+3NkB9IDtkhdbML676NqOA==
X-Received: by 2002:a05:651c:385:: with SMTP id e5mr10993014ljp.208.1587403837014;
        Mon, 20 Apr 2020 10:30:37 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id d3sm33429lfq.63.2020.04.20.10.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 10:30:36 -0700 (PDT)
Subject: Re: [PATCH net-next 04/13] bridge: mrp: Expose function
 br_mrp_port_open
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net,
        jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org,
        roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200420150947.30974-1-horatiu.vultur@microchip.com>
 <20200420150947.30974-5-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <cc388b70-701c-4600-791b-8170683a7666@cumulusnetworks.com>
Date:   Mon, 20 Apr 2020 20:30:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420150947.30974-5-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2020 18:09, Horatiu Vultur wrote:
> In case the HW is capable to detect when the MRP ring is open or closed. It is
> expected that the network driver will notify the SW that the ring is open or
> closed.
> 
> The function br_mrp_port_open is used to notify the kernel that one of the ports
> stopped receiving MRP_Test frames. The argument 'loc' has a value of '1' when
> the port stopped receiving MRP_Test and '0' when it started to receive MRP_Test.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/linux/mrp_bridge.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 include/linux/mrp_bridge.h
> 
> diff --git a/include/linux/mrp_bridge.h b/include/linux/mrp_bridge.h
> new file mode 100644
> index 000000000000..61c1f0d395c7
> --- /dev/null
> +++ b/include/linux/mrp_bridge.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef _LINUX_MRP_BRIDGE_H
> +#define _LINUX_MRO_BRIDGE_H
> +
> +#include <linux/netdevice.h>
> +
> +/* The drivers are responsible to call this function when it detects that the
> + * MRP port stopped receiving MRP_Test frames or it started to receive MRP_Test.
> + * The argument dev represents the port and loc(Lost of Continuity) has a value
> + * of 1 when it stopped receiving MRP_Test frames and a value of 0 when it
> + * started to receive frames.
> + * Needs to be called with rcu_read_lock().
> + *
> + * This eventually notify the userspace which is required to react on these
> + * changes.
> + */
> +
> +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> +int br_mrp_port_open(struct net_device *dev, u8 loc);
> +#else
> +static inline int br_mrp_port_open(struct net_device *dev, u8 loc)
> +{
> +}
> +#endif
> +
> +#endif
> 

I see that in order to pass this "loc" to br_ifinfo_notify() you add a new port variable,
but it's a boolean, so you can just use the port flags for it which will simplify things a lot
and remove some ifdefs along the way. And please rename it to something longer (so it's easier
to get what it does).

One question - now that it's always sent to user-space as IFLA_BRPORT_MRP_RING_OPEN attribute
wouldn't it be a problem, or is it read as a current state?
I mean you'll receive that attribute about a port even if you get a completely unrelated to MRP
notification (e.g. about a vlan change).

Thanks,
 Nik
