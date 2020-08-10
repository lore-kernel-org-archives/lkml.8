Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82812C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F8AD206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="daq6B7hM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgHJWnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHJWnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:43:09 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3298C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 15:43:08 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id c6so858010pje.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 15:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BZRBvIO7zS3GhTZZrI/geBFN/+zTjp/Q6v4hCxIZSGU=;
        b=daq6B7hM6pw3A1WyKOGbx+M1g7vfSG+6pGFUO6gK6OdyWuF8WvtalMocXoQovYw+p4
         /lm0QHg1ntjX5+QWyibavky4SRbhmQbV4hGydqe2Qmio7rEB5pc/ag00xlNxHjFpv2dC
         xrs1cJ0uj7kmtPRyhCtidP+Z6H3CA3a/tiw1Wm7S4isXIqf/cNgqrw5Zz/FwBcF3i4Zu
         cY51BO8kT11zKzsPMLZ/fB9NF9vlJ3FgqED/v+VEvlFe7ICJno+UbXMFU5IJL9lMl+Tf
         zZz4r3AS5sp9ShvgVisIrk8OT5UX/SnA/6pRmdK4PqPdLxeRBCZheUQqxDF/vhcRjbZU
         yWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BZRBvIO7zS3GhTZZrI/geBFN/+zTjp/Q6v4hCxIZSGU=;
        b=jUEiSKUemGfRFLZ5FexRWahNR/xFWotBx5T1rmkH8+hjONyB1uwjA2V7UWzMoiOQ85
         D58A7hu+ubvxq5Q9jiooHUZFFPTpkxj7eb6QOTeyME5ZCySQuRnxCR43L85xDzlH1YWW
         RZRGUPXO7fvqfgx+nJgTkFc6K8gQBDj7rBpJoFrzkTLPl5+iDeAYzJiGXQv0fZ/P9kpd
         7I6x5Een0mCneY9ewvlk1D+1skv1CsqYIuabCe2zMoOKwTs6pPccsUGkn39HfrICoe4q
         3++9whDBBin9EEHmdXlxpUQmjqanNSuZk0vxqVioLZOubsbgLfvLxKw0NKCbA2sss9/3
         dH4Q==
X-Gm-Message-State: AOAM530MRhakP84NdVEmZoq1IpbnH5T8bW5hQGhKWHPBnyTwGF2Q+ehB
        ojIazzoKgfKE04dgcB5BEOZ4E20DxX4=
X-Google-Smtp-Source: ABdhPJx6LGHWc2IoBS8/ZZN9+hyr66SqoaSz21Ur3pvFiSPK0WIdZ54bOdnr9dDQdJnGUD6lUY5rig==
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr26697737plo.324.1597099388353;
        Mon, 10 Aug 2020 15:43:08 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y10sm498949pjv.55.2020.08.10.15.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 15:43:07 -0700 (PDT)
Date:   Mon, 10 Aug 2020 16:43:06 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] rpmsg: virtio: fix compilation warning for
 virtio_rpmsg_channel description
Message-ID: <20200810224306.GF3223977@xps15>
References: <20200731074850.3262-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731074850.3262-1-arnaud.pouliquen@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 09:48:50AM +0200, Arnaud Pouliquen wrote:
> Complete the virtio_rpmsg_channel structure description to fix a
> compilation warning with W=1 option:
> 
> drivers/rpmsg/virtio_rpmsg_bus.c:95: warning: Cannot understand
>  * @vrp: the remote processor this channel belongs to
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 9006fc7f73d0..7d7ed4e5cce7 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -123,7 +123,12 @@ enum rpmsg_ns_flags {
>  };
>  
>  /**
> - * @vrp: the remote processor this channel belongs to
> + * struct virtio_rpmsg_channel - rpmsg channel descriptor
> + * @rpdev: the rpmsg channel device
> + * @vrp: the virtio remote processor device this channel belongs to
> + *
> + * This structure stores the channel that links the rpmsg device to the virtio
> + * remote processor device.
>   */
>  struct virtio_rpmsg_channel {
>  	struct rpmsg_device rpdev;
> -- 
> 2.17.1
> 
