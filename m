Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCC1C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCE120692
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hVQRyo8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgDGFbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 01:31:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38350 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgDGFbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 01:31:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id w3so807914plz.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 22:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=41IO2HqHht+ZeKeK2ykxdow5aEQBx0dgx4waOMPLHDA=;
        b=hVQRyo8wK5XJdAecp57qNrLjN7ivvan3f8qEmi6v01TZxs/ciBaqawgP3ZZHdniyst
         ZS/YerHyd6lblfRI3vf6YZXim4gT2PsVLa41y24xR5WyIlpTqbM1RF39MFJwK6OhUh7u
         XphQCp3JCKGKVQgEMn3CsA6htS32F3XOh1m8NiXo7FJsUHvj5caZWw3oW0bjLGDHUrFk
         DyF3MK5a7uE93LtnNAsSvKX4LZOV7nHcolKfSYrKiKFTwkK4MNGrZCCKbCZy/GuPZ229
         L2HaKHA8OvsJnJz4jBjCsBLJac6FLmuVPao4uR4U/HpBQTR7JdPGoKRuKGBmBSNT/EaW
         CZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=41IO2HqHht+ZeKeK2ykxdow5aEQBx0dgx4waOMPLHDA=;
        b=kpZKisnN+UL0EVNjhyRtys7utnXsK1bXo/fI+JzrtySd8QAeyn86+0Y0Vc+Q1nB73f
         Pe57q8DwilGFb5Esy3617OabCUFubiRL3yHn0unzVYfAqxgO3G2PN7DpSzRZYX3+f33B
         XeBufXP1VKPtzOvYoBDz6E1Se9BrkmqspMXFGY1WPDDSGA1gAemUTzwgkhhLd43MpQZ+
         n2k2fGddyEh7LkfaJej2vB/QPD+XfxhEDC6mxqXoNdx/EIDXeA4zySnmmKCIz4l5wheZ
         P6H/K5++Y/nvGEaVYap3uQ/JesPk7pYIWYMsw7H+rBvGldj9v7xSZCR6LtYNkjJqdhEh
         hgwg==
X-Gm-Message-State: AGi0Pub19erscvPcVSaFVzDvGfJmX34axpHLlD9O0vRtZJLXujaJjyJl
        aF6Kk72rm1dhr9I51ywvMnsW3A==
X-Google-Smtp-Source: APiQypIaW+sL+MjDJYp3cA6sTY/k+200IoZZfyBeGQi+bSvqYbhFU2nWq0xksktaG7n85/Md3L/gqQ==
X-Received: by 2002:a17:90b:46c4:: with SMTP id jx4mr727636pjb.6.1586237508117;
        Mon, 06 Apr 2020 22:31:48 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x78sm13076433pfc.146.2020.04.06.22.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 22:31:47 -0700 (PDT)
Date:   Mon, 6 Apr 2020 22:31:52 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v8 07/19] remoteproc: pull in slab.h
Message-ID: <20200407053152.GI20625@builder.lan>
References: <20200407011612.478226-1-mst@redhat.com>
 <20200407011612.478226-8-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407011612.478226-8-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06 Apr 18:16 PDT 2020, Michael S. Tsirkin wrote:

> In preparation to virtio header changes, include slab.h directly as
> this module is using it.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/remoteproc/remoteproc_sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index 7f8536b73295..52b871327b55 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/remoteproc.h>
> +#include <linux/slab.h>
>  
>  #include "remoteproc_internal.h"
>  
> -- 
> MST
> 
