Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97633C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CB220774
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BjHea3ws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgCXPb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:31:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38328 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbgCXPb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:31:27 -0400
Received: by mail-io1-f68.google.com with SMTP id m15so13430861iob.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 08:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TvsXpRudrZXefQZMYk6cuc0cWu2RbTQ4gqZzuO1RbrE=;
        b=BjHea3wsg4pgRhuX5WvEm0e9slsyWVMuRNw2u5Xiba9mrWowe3NHzi4SMiyOfhRZl2
         VHDjDIl3XwbleetS0cuDb3fDQmZNs4rtS5UMl6A/IqxHlA8aVz2dgfdAnwibWW3zHMJO
         n2aHiBktj1ddQWYVNRo/NJaqEgppcrEZFUixzc7tqvXoNjZCCbBfSXvlXCxi0tSpDzgn
         PnB0zxefpTre2CedKpmwwlVJvSdiN/tui9ky+kB2VGxExJ2YYcZvF97AiqIUV1iHsU44
         8PeuvVizzF3Lv/O2Bjg/nLDrz3V3einDnFaD6unLfWe0DvAjH7zUFur458nDcdXefd/A
         OWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TvsXpRudrZXefQZMYk6cuc0cWu2RbTQ4gqZzuO1RbrE=;
        b=gj9uw+79Zu713AWAB7KkO6fiNPIdtrDfRe0uqMcVBa5a0Ba+juKEuj/IfLN4DaYFoa
         P5SaVzJWHXvXpxw4Y4OWKrI0KI2hsNDeRE3IJB93qIG+Vp6EEGaWeck1RcT+/ZB6RC+2
         +4stUMsLgZg1LA9NUj6sWu11sJMALbeiwP9STmEdLp11Jb6752Nr1ordLUY/76wDR4So
         wSYTO9y1EmbPlRBUp1sVtqmKjMVhAZf3NH4LEc0dUYA5hAu/1maCT1jkcuD4jGGMAmyU
         ie1NPkb50yY0EsDnFvFKvRxKT6EvamLwQHMeRsj9jGFpVuntmbE91Qv1ZxDWvEzs/EAu
         /uFA==
X-Gm-Message-State: ANhLgQ3upKvOx0lVzub5aZleVC4XmHkpUy66VdbHt4amNO64I0c+b3eP
        VUpl1emGB4JhhuoM85zynWQBWPFyP+7FfS6Cra8/ug==
X-Google-Smtp-Source: ADFU+vuvx4HnHO0hvtSOlMwQMQBrgQYOkwH/y5TjDGcYLA1l6gQGvtVy1A0STfXLgY8fOuyRtSObqclduiOLIK8p0pg=
X-Received: by 2002:a6b:ed17:: with SMTP id n23mr24380151iog.165.1585063886297;
 Tue, 24 Mar 2020 08:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200324042213.GA10452@asgard.redhat.com>
In-Reply-To: <20200324042213.GA10452@asgard.redhat.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 24 Mar 2020 09:31:15 -0600
Message-ID: <CANLsYkwVybRG9L6gDJTzZ=eXut66vJYfuEtOfLzaYaVpdybT1A@mail.gmail.com>
Subject: Re: [PATCH] coresight: do not use the BIT() macro in the UAPI header
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Pratik Patel <pratikp@codeaurora.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Williams <michael.williams@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Mar 2020 at 22:22, Eugene Syromiatnikov <esyr@redhat.com> wrote:
>
> The BIT() macro definition is not available for the UAPI headers
> (moreover, it can be defined differently in the user space); replace
> its usage with the _BITUL() macro that is defined in <linux/const.h>.
>
> Fixes: 237483aa5cf4 ("coresight: stm: adding driver for CoreSight STM component")
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> ---
>  include/uapi/linux/coresight-stm.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/coresight-stm.h b/include/uapi/linux/coresight-stm.h
> index aac550a..8847dbf 100644
> --- a/include/uapi/linux/coresight-stm.h
> +++ b/include/uapi/linux/coresight-stm.h
> @@ -2,8 +2,10 @@
>  #ifndef __UAPI_CORESIGHT_STM_H_
>  #define __UAPI_CORESIGHT_STM_H_
>
> -#define STM_FLAG_TIMESTAMPED   BIT(3)
> -#define STM_FLAG_GUARANTEED    BIT(7)
> +#include <linux/const.h>
> +
> +#define STM_FLAG_TIMESTAMPED   _BITUL(3)
> +#define STM_FLAG_GUARANTEED    _BITUL(7)

Greg, if you want to pick this up right away:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Otherwise let me know and I'll add it to my next tree.

Thanks,
Mathieu

>
>  /*
>   * The CoreSight STM supports guaranteed and invariant timing
> --
> 2.1.4
>
