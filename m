Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E13C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B2B20857
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="XG1RcADn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDRIL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 04:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgDRIL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 04:11:26 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005A8C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:11:25 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q22so4455456ljg.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WYFITaaT1BncDtNMM/RoDBsqGjAFkSfw0DOTJFDWPi0=;
        b=XG1RcADnklId5AQ2Mf+qLBIdYcwOp7cqlnm8mCfZsA020g9D87x2oFiiuDbX8l4oEi
         aIHw/qAdH/QGt1gVsAB6GpbRwjd1em5990YrvZmxYaIqvd9QGjlygV+tl7G2Qnm8xpZO
         uZMgkEYo7wuqbjCqDWAAmjxTzABqX7lNpTe14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WYFITaaT1BncDtNMM/RoDBsqGjAFkSfw0DOTJFDWPi0=;
        b=Btg2TrgII52zGTNi3NKzJ33SN5IYMsmJZOZsarL1YCQ7mFWmlA2uXlklvvREus6p0c
         NsqU6kn2Wlh6TVInyaVmt4tMLvleZk1kyhm+0JSGd/sLnorEvMFya9k+/Ji53frSAgQH
         MCgZ17JJsV9dJNdoGsDL8UrxQfrM5sgvh6GuMdFNwIcLfnpnJ0isJJtUUIhNIiaIgrVk
         7oeK2tnRG/ZjZF3I69ae8EpJvzWgvmoYuEL4XvnFMiuzd8zOcV11PNzQMannLHt/MwKx
         zVsW/eSXcqjTzt9xUtOhFz2kGCLw3/MNokcWGsJg7nogQUS9kjKqupt8Rc/7iLVHG0eO
         jaKQ==
X-Gm-Message-State: AGi0Pua0TPwZkoaxCZrb7Y6jAujP7JTdDipk2dIOHvSYmUgnJgSov6sP
        Wgl6P/as5V9Stf4h4zx4/pxikOKkgY8IzU8M
X-Google-Smtp-Source: APiQypI8M/7d9Z+0gooRguYMX/NZnTmW2MvF76AoBKyJf7m18GTUBATnblM1vF4oewGsuDTLAXtEBA==
X-Received: by 2002:a2e:6a0e:: with SMTP id f14mr4464414ljc.102.1587197484276;
        Sat, 18 Apr 2020 01:11:24 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id c203sm20185006lfd.38.2020.04.18.01.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 01:11:23 -0700 (PDT)
Subject: Re: [RFC net-next v5 3/9] bridge: mrp: Expose function
 br_mrp_port_open
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net,
        jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org,
        roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com
References: <20200414112618.3644-1-horatiu.vultur@microchip.com>
 <20200414112618.3644-4-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <2b387697-0e4c-7d8a-ae52-d1e8ce1f6bf4@cumulusnetworks.com>
Date:   Sat, 18 Apr 2020 11:11:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414112618.3644-4-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2020 14:26, Horatiu Vultur wrote:
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
>  include/linux/mrp_bridge.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 include/linux/mrp_bridge.h
> 
> diff --git a/include/linux/mrp_bridge.h b/include/linux/mrp_bridge.h
> new file mode 100644
> index 000000000000..23d46b356263
> --- /dev/null
> +++ b/include/linux/mrp_bridge.h
> @@ -0,0 +1,24 @@
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
> + *
> + * This eventually notify the userspace which is required to react on these
> + * changes.
> + */
> +
> +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> +int br_mrp_port_open(struct net_device *dev, u8 loc);
> +#else
> +inline int br_mrp_port_open(struct net_device *dev, u8 loc)  {}

static and put {} on their own, check how such functions are defined in other places (e.g. br_private.h)
but in general I think you can drop this function favor of br_ifinfo_notify(). More about that in my review
of next patches.

> +#endif
> +
> +#endif
> 

