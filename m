Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5063C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 07:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782A8206B8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 07:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="jcwWn7Cx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgDDHaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 03:30:55 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35506 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDDHay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 03:30:54 -0400
Received: by mail-ua1-f68.google.com with SMTP id a6so3638171uao.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 00:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0LcIqyzOelKRy7NwzrnjxsMz0cnQ+jIhiQgIFia4NZA=;
        b=jcwWn7CxkuVo6AYV6g8AWv5uMyYcuB5tY0C74eAEWC4EB8IuR/4OrfsQyUWFp88Pgn
         ZH2QK25HNNb7Oi/uZM2c2Rznck5aUPxKL5hqpCjz7kN5YmfmIGb2btyiO2Jur+yvxyNq
         EwohwQRvXw216bPpEUtq6ZLdnHyCs66b7hgcffHMFvm1pDGiTAgAbX+U5I85dUTevw5l
         2ugV6grGu7UxGKJ4+qoXgy5CZQePlSbG7X3LKm7Bp8+CAu53e3VpdpuXxUk0m1SNy320
         MM9i7YucgeiMWQtD0JpwPaP+WofdGniDtsZi4nY7a9afDpuKmQ5mbCHkNOQnKfMoHy1U
         WGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0LcIqyzOelKRy7NwzrnjxsMz0cnQ+jIhiQgIFia4NZA=;
        b=Srja7uipvBBja6xC+zAK7gefPcNC2VTDmvCimZ+LXFQugzff33Qp9pqnDXTCmGKSfb
         /H8d9DGuy4b3K3gKNazLSMR3inuHtpmacw9hYhfhQSSmoXD5DHUxCwdi7h+aaOZ4J+r1
         OURxSEGdqSLuZ9i3/6BDThmFa7liwqDWs7GRPQ+SAUIbRrTef92RxxkLhGTUBvxFieLI
         jTay1wAcmgPIjPbpwko4Mar7BUHri3J9n23tqkGXfLx4K5zBfvmbwFDtG3rbAIxjMREc
         ToQwCot6GmjIYmEmoucYAJ8zeyD4DgQlG6MJruNvAf4wydw96Epdj4Uu+FvZ9ZGQUKKP
         HJAQ==
X-Gm-Message-State: AGi0PuantVcd/6oxi4wN71XxmFdRtFGiM00TGXq6R6K0Xzp7YxoCJkY3
        oFFV4yqIQi3LmlBJEbPez7XQ3R9Y5aUXO2fv+kyGew==
X-Google-Smtp-Source: APiQypLWneYbyshOq2SV62p8HIJNS2Hf5WwI6L9HOKzNAuWCgiWC9wPz+d7ubbBhyByIcy8k8iCwmBA0Z5kic/1eHsc=
X-Received: by 2002:ab0:654c:: with SMTP id x12mr9585976uap.48.1585985452418;
 Sat, 04 Apr 2020 00:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200402142747.8307-1-daniel.lezcano@linaro.org> <20200402142747.8307-2-daniel.lezcano@linaro.org>
In-Reply-To: <20200402142747.8307-2-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Sat, 4 Apr 2020 13:00:00 +0530
Message-ID: <CAHLCerMw_-M3nAs9hhPFdqVtay0ayLKSc09Y9bSRFQ0rM9mF=Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/9] thermal: Move struct thermal_attr to the private header
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 7:58 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The structure belongs to the thermal core internals but it is exported
> in the include/linux/thermal.h
>
> For better self-encapsulation and less impact for the compilation if a
> change is made on it. Move the structure in the thermal core internal
> header file.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/thermal_core.h | 5 +++++
>  include/linux/thermal.h        | 6 +-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 828305508556..5d08ad60d9df 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -41,6 +41,11 @@ extern struct thermal_governor *__governor_thermal_table_end[];
>              __governor < __governor_thermal_table_end; \
>              __governor++)
>
> +struct thermal_attr {
> +       struct device_attribute attr;
> +       char name[THERMAL_NAME_LENGTH];
> +};
> +
>  /*
>   * This structure is used to describe the behavior of
>   * a certain cooling device on a certain trip point
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 71cff87dcb46..5aa80fb2fb61 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -35,6 +35,7 @@
>  struct thermal_zone_device;
>  struct thermal_cooling_device;
>  struct thermal_instance;
> +struct thermal_attr;
>
>  enum thermal_device_mode {
>         THERMAL_DEVICE_DISABLED = 0,
> @@ -119,11 +120,6 @@ struct thermal_cooling_device {
>         struct list_head node;
>  };
>
> -struct thermal_attr {
> -       struct device_attribute attr;
> -       char name[THERMAL_NAME_LENGTH];
> -};
> -
>  /**
>   * struct thermal_zone_device - structure for a thermal zone
>   * @id:                unique id number for each thermal zone
> --
> 2.17.1
>
