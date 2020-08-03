Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F8AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304AA20719
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NaJI23k4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgHCLMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:12:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45645 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725945AbgHCLMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596453168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nNHHrbCTCx1Ksr9+Xzh66LKqXmd+gI0piE1Ogw1lz60=;
        b=NaJI23k4nUbUg3RSema/ybrNWyt5cMFhJRe9Yvz/VYPcUjwTiAQg55odx04SgdN53vPGEP
        oB3Ny6203YilgYn0pxZpm5X259QWogQsg3EMpExCwAfeEcTbGYMdTXR/YBHgL/ZNkqw6wh
        4icKddckSxHsRiWmM6E6riFH08GSLnU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-a4gqlMUlMbOKaMh9HbSFWQ-1; Mon, 03 Aug 2020 07:12:46 -0400
X-MC-Unique: a4gqlMUlMbOKaMh9HbSFWQ-1
Received: by mail-qk1-f200.google.com with SMTP id z1so20305835qkg.23
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 04:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nNHHrbCTCx1Ksr9+Xzh66LKqXmd+gI0piE1Ogw1lz60=;
        b=ieeH1b70nJJdpnuX+OceMnBJjvV1E/tWihVVJZKYZwEB9i6MfnjQFqsemoJpyYcGk9
         DjhHjht8+G5J8NIEIyJmsPcFxoFg/12yy9ttrQFKJ3iOdbHva6L5b6mF+jIF4T9XbfBO
         PSAsjjywNeJpxTJMAc+/2uU7SUmuU7Ti5QSEt8Fd6ODL4K6jcwa56fQVJ/FsKJCc6Fv2
         fBJjOmjYNyVzxqWp3gz1h4BMJLySb7utnGAF2ljaSnMrKol9hJlwMgJSb01ZBfm+seIo
         dM58+3d+nWquUAlT7B7lcv+Np1Ysugpo80oejxMYNi7+SVcaOHGoLwO2NvIANJECLNi+
         4xmw==
X-Gm-Message-State: AOAM531/JeLCzo0jcRcMMzuBKDr2QkN45gTh6c1Zw01TcUso7O56MgiA
        BTIG2h/ZK7frS9OjOUzYVgcDJKKhmIu50Fw3taO1UrjS3gdYk3ItEIvJQ3hxD8ALNAZe7bXqsAG
        uWMk7uj8J/eHub7mmXoatr+eF
X-Received: by 2002:a05:620a:2230:: with SMTP id n16mr16158450qkh.268.1596453166399;
        Mon, 03 Aug 2020 04:12:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOnXvj6bTJzfcAn3Xgm8v8FvIImrrzdOdNRos/LKSb3s9y2vmMmRA2Zf4ftsdV5shz2NBN5w==
X-Received: by 2002:a05:620a:2230:: with SMTP id n16mr16158433qkh.268.1596453166168;
        Mon, 03 Aug 2020 04:12:46 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id d70sm16687998qkb.71.2020.08.03.04.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 04:12:45 -0700 (PDT)
Date:   Mon, 3 Aug 2020 07:12:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Ashutosh Dixit <ashutosh.dixit@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sudeep.dutt@intel.com, arnd@arndb.de, vincent.whitchurch@axis.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] vop: Add missing __iomem annotation in vop_dc_to_vdev()
Message-ID: <20200803071234-mutt-send-email-mst@kernel.org>
References: <20200802232812.16794-1-ashutosh.dixit@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802232812.16794-1-ashutosh.dixit@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 02, 2020 at 04:28:12PM -0700, Ashutosh Dixit wrote:
> Fix the following sparse warnings in drivers/misc/mic/vop//vop_main.c:
> 
> 551:58: warning: incorrect type in argument 1 (different address spaces)
> 551:58:    expected void const volatile [noderef] __iomem *addr
> 551:58:    got restricted __le64 *
> 560:49: warning: incorrect type in argument 1 (different address spaces)
> 560:49:    expected struct mic_device_ctrl *dc
> 560:49:    got struct mic_device_ctrl [noderef] __iomem *dc
> 579:49: warning: incorrect type in argument 1 (different address spaces)
> 579:49:    expected struct mic_device_ctrl *dc
> 579:49:    got struct mic_device_ctrl [noderef] __iomem *dc
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Sudeep Dutt <sudeep.dutt@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/misc/mic/vop/vop_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
> index 85942f6717c5..25ed7d731701 100644
> --- a/drivers/misc/mic/vop/vop_main.c
> +++ b/drivers/misc/mic/vop/vop_main.c
> @@ -546,7 +546,7 @@ static int vop_match_desc(struct device *dev, void *data)
>  	return vdev->desc == (void __iomem *)data;
>  }
>  
> -static struct _vop_vdev *vop_dc_to_vdev(struct mic_device_ctrl *dc)
> +static struct _vop_vdev *vop_dc_to_vdev(struct mic_device_ctrl __iomem *dc)
>  {
>  	return (struct _vop_vdev *)(unsigned long)readq(&dc->vdev);
>  }
> -- 
> 2.26.2.108.g048abe1751

