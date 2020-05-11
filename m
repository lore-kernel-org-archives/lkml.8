Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94776C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D91B2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBDRrTAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbgEKSPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729750AbgEKSPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:15:20 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57E0C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:15:20 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id r25so15931036oij.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y6gpOVSJl7lrYMpPspDPOwT905Iv9urAirQvkpvSx34=;
        b=cBDRrTAxc8bdQGofdLumcpSo9AwuCBzcdPIo0QyVdeyv8eC2XwFdk9/C9DaJy93D2H
         0ctUoaoTDj+uAEAg1mlDSfFwoe8DrDSkEAPo3lUXi3ja1ggGr3FS6H/7XtSmroHgXzK/
         BNXAK8BQtYk+mIP8R0aStsa6gwMJIr6/Jfx6g3vgDE+AAOId8U7hunHhdeKxSYYLqiJV
         opA8PcVKjLQCXZUlqy0zqM5zOqLvkTl1+l4EmaT4nFKWrGaJ4SN/lT2PvQe+2nXh38k4
         vZBuqizx6+pBxHyWVdQX92IKT0m7aA0VVI6BB5lrSClUDs6mvT5JbxKGScwaSETSATvL
         G/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y6gpOVSJl7lrYMpPspDPOwT905Iv9urAirQvkpvSx34=;
        b=dCHp7CfqpylOeYRTOhmCvEFnFwY13CAV3urN3UJTRLTJhUnbBOqakIyStNIla/M7SM
         4uguWzn8cRXoSDr5g3uGme+QoIoMB5IJTTDU47gtIE7AFKLd6mSBkal1czw5Wv5FAcLg
         WxwxVxPSxIreHJRe6R2ZaX0Xf7gDzG+rse0BiMNklX/wvhGAmYuTsMHWbPH12cp8LLUM
         DerTRuZU29dVbrzHEcIvDmr88R6FqzTa3jLcRQ+6/iukbdXEbcJweZ2+IWfOYBfaEzRz
         kiUo1hWtK685Nl40F+cmaJeDBmoqbU95iv4lFg/FEsf+3yHbH7l/vcngNJRfUdOcJzVz
         bdKA==
X-Gm-Message-State: AGi0Pub6f9Vjef1KptgZ0mlyd/rfdI7dsjlf31VVVU/5JilsI90/6vJF
        in160sHdEdmrr1JPeCj8fKI2QZznDBBwz+1+O0l7IM91
X-Google-Smtp-Source: APiQypJ+PkSA8uenryJETuWW7bHYFLqIga4xeFPZz4MV5587HJ3lvd/ps/KS9pTb3okcz9vlcXOV4qLqP5YNxhBUmmg=
X-Received: by 2002:aca:3254:: with SMTP id y81mr573964oiy.172.1589220919864;
 Mon, 11 May 2020 11:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200511151334.362-1-srinivas.kandagatla@linaro.org> <20200511151334.362-2-srinivas.kandagatla@linaro.org>
In-Reply-To: <20200511151334.362-2-srinivas.kandagatla@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 11 May 2020 11:14:44 -0700
Message-ID: <CAGETcx8+khWkCUffwWqHit1c-koKFqLKJbRZTF_ZnDX=srJ=pg@mail.gmail.com>
Subject: Re: [PATCH 1/2] slimbus: core: Set fwnode for a device when setting of_node
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 8:13 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> From: Saravana Kannan <saravanak@google.com>
>
> When setting the of_node for a newly created device, also set the
> fwnode. This allows fw_devlink feature to work for slimbus devices.
>
> Also, remove some unnecessary NULL checks. The functions in question
> already do NULL checks.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> [Srini: removed unnecessary NULL check from other patch]
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/slimbus/core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
> index 526e3215d8fe..1f3beee74fdf 100644
> --- a/drivers/slimbus/core.c
> +++ b/drivers/slimbus/core.c
> @@ -162,9 +162,8 @@ static int slim_add_device(struct slim_controller *ctrl,
>         sbdev->ctrl = ctrl;
>         INIT_LIST_HEAD(&sbdev->stream_list);
>         spin_lock_init(&sbdev->stream_list_lock);
> -
> -       if (node)
> -               sbdev->dev.of_node = of_node_get(node);
> +       sbdev->dev.of_node = of_node_get(node);
> +       sbdev->dev.fwnode = of_fwnode_handle(node);
>
>         dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
>                                   sbdev->e_addr.manf_id,
> --
> 2.21.0

The edits look fine to me.

-Saravana
