Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64914C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 02:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8CB20768
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 02:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjhWVyK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgDJCQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 22:16:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37326 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgDJCQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 22:16:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id m16so210269pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 19:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g3ezOHVTu/DVs9eQ5bfvyVgR22CPV+9l8W/1ERsAjaM=;
        b=EjhWVyK8B16rqGj6Gwx5TFqcG4pWyYbL0yI3j0qO+Vgv03KmaDbFUV31ZOkNUKSTQG
         Oo+dPvSSEBlfQd3X2Y1b5mv/P6y/uU73n8TD8YHf0etFsRWXJ4Uyy/N5YbKVNmoqaP/R
         q2BH8emgUM1SUM5ig2Z4BNPG1a9ZMURsoXsRbaZuVAlmJTbpeAowU825GDC+URy4HxIS
         fRsDmlxFFWLYCxO4zl711XVyLlJTr+cWWmvskWRcCz5gAyrKvSGmj3ZgM6vpygv+9L1U
         3hoiykwzzPGrmxqac7T5E6Qk1yb/jIxb4cxrZSDC8ykI1ZO4S5hfyJtW7okCq7W/uaKy
         sGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g3ezOHVTu/DVs9eQ5bfvyVgR22CPV+9l8W/1ERsAjaM=;
        b=Q+E3Ecd6pfbLK2nBP45oD2VnlBjwOPdDm66QU3y/AoL7m2NR3KSw4XoW/6PgflH8RC
         gsugjzVKtIbuFLROiUzuVml+N3IkQwUwwzTjj6HkCf+UJyDrB9lBVKYdufs0bG6DHJFb
         egY75pPL1H6YcHLYa6FiZyWHN5XsdbJee8jOW7FQbF4Dx1hWhVHJ/Aer/ehKASJabGFj
         0GBQhtii4kIk5ts5xj2h3fgGBvAotY7eaP7812/4TGSmnUkFNqNsIMgg70O1kvWfP/HU
         X8CEsQwSVYGXh6aEdzplt9GPkRpWqQWuOPKvRul6VT+EQ5sqm7h69XW2Hf0obrQ7gSl1
         LdTA==
X-Gm-Message-State: AGi0PuYbFT0DQFDfNZ6G4L05LVpNxpF9CenfgtJysIhYk3gZ0yvO/cyB
        6hRN2w6JrbqP/Jxr5U8TihdbHQ==
X-Google-Smtp-Source: APiQypJNHYZiUTXCViITxQIb0jbA9ZW5wv2BarRhmw9hMnx+q5iry/q6pNmWq864Mk8uqzFlF3vOkg==
X-Received: by 2002:a17:90a:8a08:: with SMTP id w8mr2762112pjn.119.1586484988292;
        Thu, 09 Apr 2020 19:16:28 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 6sm403583pfx.69.2020.04.09.19.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 19:16:27 -0700 (PDT)
Date:   Thu, 9 Apr 2020 19:16:36 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] rpmsg: pull in slab.h
Message-ID: <20200410021636.GZ20625@builder.lan>
References: <20200409211045.12025-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409211045.12025-1-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09 Apr 14:10 PDT 2020, Michael S. Tsirkin wrote:

> In preparation to virtio header changes, include slab.h directly as
> this module is using it.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

I presume you have some series where you need these? Otherwise let me
know and I'll pick them up.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/rpmsg/mtk_rpmsg.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rpmsg/mtk_rpmsg.c b/drivers/rpmsg/mtk_rpmsg.c
> index 232aa4e40133..83f2b8804ee9 100644
> --- a/drivers/rpmsg/mtk_rpmsg.c
> +++ b/drivers/rpmsg/mtk_rpmsg.c
> @@ -8,6 +8,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc.h>
>  #include <linux/rpmsg/mtk_rpmsg.h>
> +#include <linux/slab.h>
>  #include <linux/workqueue.h>
>  
>  #include "rpmsg_internal.h"
> -- 
> MST
> 
