Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C136C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307FB2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RkQSkqLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732635AbgFWMqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbgFWMqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:46:00 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075A6C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 05:46:00 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id i15so1627627uah.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 05:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAof4l6XkgdGT8Mvck4bZOKs1Q1y9tSFhmWkYUfuub8=;
        b=RkQSkqLyGwzs2iFHffDo1JgFlZQCxD0GMS1SrehB2RFZw9k0BJYiHmRBlNEwe1tCPy
         +jPLJSiXL6eSGnAFlsjoSczsgTk3TPm/9R8U+QLLJx49+C4W9iOGAf6iOC6Pn+e2jS87
         IBZuG2DZUr8Y1bY35wdtz4HPFn+v6jIie8BxFfPjkMfzpnZoyb4+a7kzJ/4mavO9N2UF
         xwBdk8dXrsPR6epUDoIJNV2fb937Jbc5D0scsYIeeJScw61PIz3j0AULrpkEhxI83K33
         GR4SwWNBU3kGPztqFmTi3OqIqR4MEcpY2ja/N6bnL3jAZ05EVKSXF9obk6elz9SOOva5
         kwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAof4l6XkgdGT8Mvck4bZOKs1Q1y9tSFhmWkYUfuub8=;
        b=NTMdDz9lYKSZjpni4un+c8y2m35+WK8FZrobRBmy2NdJcbs3P0OVog6wwKS5nCrvpg
         BEhaHMdwe5Bno/PJvcURBK7k48dmSxGRw4h4O32bF5CMQywf7UZF5qZrWV08zKOYpcjk
         TfKwSySrS4Qf9KBy8+MfGvubkh8+KpgKH0d2Hl/CNqVaIbasApnRRwsdLXeUt7gjqwQC
         7ZLioRouV50eF9ZRFbwYSoGuqnfok8N0hgyE+OUbcLO0z7T4cpiwEaTXmJV1ngcMJVW8
         6Byiw8lwhGmUQudVeAcvn5RokkgXBoR+Wa4xUx+6i6XugAmvBJ6ZOFpQhl0nrhvrrgnh
         n+tQ==
X-Gm-Message-State: AOAM531E/yPuxkNZp4ygGzeafSd/cod86XYNsGg/Mh+FjWOLqqO4Q/rw
        /mmB/I4bv+YWCWmDCf7WAztuGT16FNB74DQCTUbuzA==
X-Google-Smtp-Source: ABdhPJyIYYRHdQZVKDkjYnKg3hSsbW9yUVOGY6lvGON7kQV2dQbJBZxTNVcxlvAzgD+CVerQPYrcvIbxjahad/EcX3A=
X-Received: by 2002:ab0:a81:: with SMTP id d1mr15034075uak.67.1592916359200;
 Tue, 23 Jun 2020 05:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <1592212056-31955-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1592212056-31955-1-git-send-email-wangqing@vivo.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 23 Jun 2020 18:15:48 +0530
Message-ID: <CAHLCerNJ8QAzTohuNW3tseji31Ab7Ga11PXo=T+sm8yeoPFkaA@mail.gmail.com>
Subject: Re: [PATCH] drivers/thermal: Use kobj_to_dev() instead
To:     Wang Qing <wangqing@vivo.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 2:37 PM Wang Qing <wangqing@vivo.com> wrote:
>
> Use kobj_to_dev() instead of container_of()
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Acked-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>  mode change 100644 => 100755 drivers/thermal/thermal_sysfs.c
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index aa99edb..3e92ff9
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -438,7 +438,7 @@ static umode_t thermal_zone_mode_is_visible(struct kobject *kobj,
>                                             struct attribute *attr,
>                                             int attrno)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct thermal_zone_device *tz;
>
>         tz = container_of(dev, struct thermal_zone_device, device);
> @@ -464,7 +464,7 @@ static umode_t thermal_zone_passive_is_visible(struct kobject *kobj,
>                                                struct attribute *attr,
>                                                int attrno)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct thermal_zone_device *tz;
>         enum thermal_trip_type trip_type;
>         int count, passive = 0;
> --
> 2.7.4
>
