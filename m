Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C88C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08A28206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R99hccmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgFBVNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFBVM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:12:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB69C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 14:12:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d128so4576960wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RijQZzPCkhwUNScdlTK9IICuZe5qxW6gJ9RNI3+a0HU=;
        b=R99hccmFfYGoTdOr6YSXNNbpSo8W75D3IXo4TI7aU/vGGTAkzCVzIa3KqAYBC/SDwr
         cQGcLcBcjTPUfuOJ6kqyysuSkwK0dhUlETVVfLhJLa29vasiQ3p27T3XlEVVWmE9b7b+
         vrq6xDC1wX6Vidm9Df+nsH/6SSqwxxMRxEZvWJz012UsOQlteNqPrFMUztblGEzJ7Nte
         qqiLIScNB3XDtB5XopfaRRwzHuFcMvWdv2n0YrSGrIaxYthaT92Y8UzOwZ37hqE+I3fy
         T2pc98N/XSg5U7lIvbefdMx8WqJnIB+Eq1yVrfeTSwlFjMPseqtqFEW6VRZWxHXHO1tl
         MpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RijQZzPCkhwUNScdlTK9IICuZe5qxW6gJ9RNI3+a0HU=;
        b=bd5QmJvTdZ5gW/fXToEp5qhe8q3f8IynslwYd7VgPzFRvZtWznt8imiXVKxN6ULB14
         Mv93akGr85JiUYAo7EWSxuKJNMNJeDuYPNNNCg9RAJ4vjbqtHEFSdz/rGVQBzh6sInbw
         rP3tsBUe/FD1fxO6F08SLCnFpNhiJmkKxR3V7AR2WGU3cAW1s9qRvt/EWKXKJ845xTKO
         Q5i8hATeZ0jpyxZWSq8jfwqB5zGxDQNUR2h3E+KArgKqmhjLw7KqPxWygumAkT+RanKy
         7feopnUiP+7vk7hi+Iir9XX6B/rnPrz3/KIp83fYNtRU/bhPcjcPZM0vyfuW9wpllmMG
         8nog==
X-Gm-Message-State: AOAM530H157j+KUVnigymW+zSNORBC8GG4muROR4guvXNHgb89GgaE/0
        8N01jt/2yCfi8vJJSm9tCjAxyyP2g6dLIuUIkOc=
X-Google-Smtp-Source: ABdhPJyEIBXiRtdTLqxBRIYdUSTx6Yw5Mq9YNaXvhve0xnUvf8QCtyXTQnchcZ/90+HrbddFJp/kVuyyP1sgrG/XBXQ=
X-Received: by 2002:a1c:7f4e:: with SMTP id a75mr5943633wmd.127.1591132377978;
 Tue, 02 Jun 2020 14:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <1590723777-8718-1-git-send-email-hexiaoshuaishuai@gmail.com>
In-Reply-To: <1590723777-8718-1-git-send-email-hexiaoshuaishuai@gmail.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Tue, 2 Jun 2020 23:12:46 +0200
Message-ID: <CAM9Jb+gdgYSe9r_ce9Mhaj+dyKH5kocSjD_GOpoKowtG8Sxn4Q@mail.gmail.com>
Subject: Re: [PATCH] drivers/dax/bus: Use kobj_to_dev() API
To:     Shuai He <hexiaoshuaishuai@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Use kobj_to_dev() API instead of container_of().
>
> Signed-off-by: Shuai He <hexiaoshuaishuai@gmail.com>
> ---
>  drivers/dax/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index df238c8..24625d2 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -331,7 +331,7 @@ static DEVICE_ATTR_RO(numa_node);
>
>  static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct dev_dax *dev_dax = to_dev_dax(dev);
>
>         if (a == &dev_attr_target_node.attr && dev_dax_target_node(dev_dax) < 0)

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
