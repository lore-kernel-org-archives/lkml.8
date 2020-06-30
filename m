Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD42CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822C020672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d68s4qdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733102AbgF3Lrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgF3Lre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:47:34 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11D5C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 04:47:33 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u25so11179488lfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 04:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TFC+WBq7XDcW3TVW9x+KN+I5qxP4pcdSU4SbEe6OPp0=;
        b=d68s4qdCmK1TtORh+eQRf0S7WXOcI+wvGvLs0azHsmlx3wZ3fI54RdBA5MqjXEH0p+
         Dno6/2KH6VsHo19RJMbFwmdFbzQMnSLyHtrAwgCBbwyjgEzbuLqg9DKsoJh7YhxkHfbm
         tUL3kppZ8Sk8n2Af1NYQHQcMuczHcJ3e4AOZZpCTh+/uiCYXxwhp3IHzo4bKbUiJc1QQ
         1ArdlHjQ0zEZBV3RpZBrpGl6hTIjj1jY0wI3SkzUY3vg+qU7IchTcVxls8NUWxD1QXk1
         +du+8q924Xyfm35vp3ktf98nOwNKpTPgL2hUzZf++WzzPjFbIjwGpoLqiIcJN6Q8GN12
         DjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFC+WBq7XDcW3TVW9x+KN+I5qxP4pcdSU4SbEe6OPp0=;
        b=HEixW+QJtGoK3ncXnhSkk4dvbAUAmTJmoGHZ34/jnJN2oV611X5OM3fPj+/b5mpopz
         dKOvxvMbLliqBa3XzbrnB1dTgIU/j2hEoxgplpypJU+Hbzb3uoHXSzqmP20SBh4EqGGn
         C7rvDIpF9MdBCjC0eYWKLnK22OG20fWHCB7oBTJG+n0/Cjtt3wdzMg5eoIwD4vMNuEDk
         tYpBAKe8jK0RQ9XBrgHh76Q5dzDNpLqNsQDWH4ExYHR98tFg63QqenQGlTWN15ECe0PG
         1ym7wnnJ6VeS2gysIws1Tuh8V5CoJxUuZ7eizcnUveXv4ROBD+uRCz56m76LvzaAppbr
         cqnw==
X-Gm-Message-State: AOAM533pfZFlV8xXUKL8SuZTDTfoN9bNuRfRHEDGzrkhyQ8iIIE9GdJM
        gpTQLISdUpYfvW5lsr2xg6H1mihAzBl7spj7s06/0bQI
X-Google-Smtp-Source: ABdhPJwt26oQzvsh96ZHTy2TwPcowmHp/AIV+YTF2oMGp3rjnTbFRwFrzSq6RtZFwbFkyJsPWznIdHy8/vEzrb45av8=
X-Received: by 2002:a19:c797:: with SMTP id x145mr11835531lff.143.1593517652008;
 Tue, 30 Jun 2020 04:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200625144509.17918-1-daniel.lezcano@linaro.org> <20200625144509.17918-3-daniel.lezcano@linaro.org>
In-Reply-To: <20200625144509.17918-3-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 30 Jun 2020 17:17:20 +0530
Message-ID: <CAP245DUMjTQr2vKirZ+FxEYWC=VQ_k+OegxQgXcKDU8ThWuCsQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] thermal: core: Remove old uapi generic netlink
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 8:15 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> In order to set the scene for the new generic netlink thermal
> management and notifications, let remove the old dead code remaining

s/management/management api/

s/let/let's/

> in the uapi headers.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  include/linux/thermal.h      |  5 -----
>  include/uapi/linux/thermal.h | 12 +-----------
>  2 files changed, 1 insertion(+), 16 deletions(-)
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index faf7ad031e42..fc93a6348082 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -302,11 +302,6 @@ struct thermal_zone_params {
>         int offset;
>  };
>
> -struct thermal_genl_event {
> -       u32 orig;
> -       enum events event;
> -};
> -
>  /**
>   * struct thermal_zone_of_device_ops - scallbacks for handling DT based zones
>   *
> diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
> index 96218378dda8..22df67ed9e9c 100644
> --- a/include/uapi/linux/thermal.h
> +++ b/include/uapi/linux/thermal.h
> @@ -6,21 +6,12 @@
>
>  /* Adding event notification support elements */
>  #define THERMAL_GENL_FAMILY_NAME                "thermal_event"
> -#define THERMAL_GENL_VERSION                    0x01
> +#define THERMAL_GENL_VERSION                    0x02

This hunk should be removed since you set version back to 1 in the
next patch and we don't actually intend to bump the version yet.


>  #define THERMAL_GENL_MCAST_GROUP_NAME           "thermal_mc_grp"
>
> -/* Events supported by Thermal Netlink */
> -enum events {
> -       THERMAL_AUX0,
> -       THERMAL_AUX1,
> -       THERMAL_CRITICAL,
> -       THERMAL_DEV_FAULT,
> -};
> -
>  /* attributes of thermal_genl_family */
>  enum {
>         THERMAL_GENL_ATTR_UNSPEC,
> -       THERMAL_GENL_ATTR_EVENT,
>         __THERMAL_GENL_ATTR_MAX,
>  };
>  #define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
> @@ -28,7 +19,6 @@ enum {
>  /* commands supported by the thermal_genl_family */
>  enum {
>         THERMAL_GENL_CMD_UNSPEC,
> -       THERMAL_GENL_CMD_EVENT,
>         __THERMAL_GENL_CMD_MAX,
>  };
>  #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
> --
> 2.17.1
>
