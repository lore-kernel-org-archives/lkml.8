Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D24EC2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E9F2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BFn6qsZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgDGICo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:02:44 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39207 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgDGICo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 04:02:44 -0400
Received: by mail-ot1-f66.google.com with SMTP id x11so2178533otp.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 01:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+IGGvwXtvpMoFyJXBYUflNRrfjRZwkCQuMyByMcQho=;
        b=BFn6qsZEZ4ktGp46hnAl9O7se/SSwvgjXfSJ606X4QvyDqgcq2yEP0Y2ZvJZXUevB0
         9bgtFW/7tYpvIYHL7cFCt1CLsmcTzC6qdcXg1kl2ulXPwB7afeCjLIuKgAFUeMpKJF6c
         DvgZoU2Maqj/2MtZKUsDkWj4c9YZMwMpsgGNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+IGGvwXtvpMoFyJXBYUflNRrfjRZwkCQuMyByMcQho=;
        b=VbAbzdc58K4ESl6BzO66d1hvmJSSoj7EJzFFTYZV9wvEBX7g4CYRsbIpIGUIsXQgAb
         1oWDlvZt0BjXMfasMcswC5crhw2XVAH63Bhh8nqDfiJYoCoqx37a8xka9SVNXbK6qhaC
         /s/68SeRUS7OFN2RdX3uY3kU1NbZ2uU7+fNsbZ+MzYqlczpu8deRDBqvGJMq2GomCQD6
         waLojRd2axI7mnxyKaYN1DEVFGZTkE30v/PXtvTlQczCOY0HqKZ+mdWxBEQ1C8NtRUa5
         giUofSJUgqmkox5CuGj5piBQcWlk8UEq8m6tYVqbnRVRNsrqnX6WI8F5Zg07viY9icwq
         5ISQ==
X-Gm-Message-State: AGi0PuaoRq4JO9s3/59wqiPW21xGe8eSiGH4IDVDFFG4FIxSAhdUL6M4
        3gre98VMyyCcr7WMP7cf97/IMOOiorGGGIIjjYS0je3+
X-Google-Smtp-Source: APiQypI0IVHv01F8Nt/anDTLR+c5S/0mtBDi0RIysglEWUDApMRa4zR5cD1gvrCxl6Z7NEIzrfxyzmkFDQyWfRw4sic=
X-Received: by 2002:a9d:6e8f:: with SMTP id a15mr604218otr.188.1586246562936;
 Tue, 07 Apr 2020 01:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190820230626.23253-1-john.stultz@linaro.org> <20190820230626.23253-20-john.stultz@linaro.org>
In-Reply-To: <20190820230626.23253-20-john.stultz@linaro.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 7 Apr 2020 10:02:29 +0200
Message-ID: <CAKMK7uHr5U-pPsxdQ4MpfK5v8iLjphDFug_3VTiUAf06nhS=yQ@mail.gmail.com>
Subject: Re: [PATCH v5 19/25] drm: kirin: Add register connect helper
 functions in drm init
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 1:06 AM John Stultz <john.stultz@linaro.org> wrote:
>
> From: Xu YiPing <xuyiping@hisilicon.com>
>
> As part of refactoring the kirin driver to better support
> different hardware revisions, this patch adds a flag to the
> device specific driver data so that we can conditionally
> register the connectors at init.
>
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel <dri-devel@lists.freedesktop.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
> [jstultz: reworded commit message]
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Whatever it is you're doing, this is nonsense. drm_dev_register does
register connectors for you. If you hotplug connectors later on, you
have to register them (manually), but definitely that should happen in
the hotplug code. General rule: If it's not a hotplugged dp mst
connector, calling drm_connector_register from drivers is pointless
(and yes I know there's tons of that stuff around, for historical
reasons).

Further the flag isn't even set, so this is just dead code.

Please revert.

Thanks, Daniel

> ---
> v5: checkpatch --strict whitespace fixups noticed by Sam
> ---
>  .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   |  1 +
>  .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   | 43 +++++++++++++++++++
>  .../gpu/drm/hisilicon/kirin/kirin_drm_drv.h   |  1 +
>  3 files changed, 45 insertions(+)
>
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> index 21c5d457a97d..89bdc0388138 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> @@ -1073,6 +1073,7 @@ static struct drm_driver ade_driver = {
>  };
>
>  struct kirin_drm_data ade_driver_data = {
> +       .register_connects = false,
>         .num_planes = ADE_CH_NUM,
>         .prim_plane = ADE_CH1,
>         .channel_formats = channel_formats,
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> index c9faaa848cc6..68de8838da3c 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> @@ -98,6 +98,40 @@ static int compare_of(struct device *dev, void *data)
>         return dev->of_node == data;
>  }
>
> +static int kirin_drm_connectors_register(struct drm_device *dev)
> +{
> +       struct drm_connector *connector;
> +       struct drm_connector *failed_connector;
> +       struct drm_connector_list_iter conn_iter;
> +       int ret;
> +
> +       mutex_lock(&dev->mode_config.mutex);
> +       drm_connector_list_iter_begin(dev, &conn_iter);
> +       drm_for_each_connector_iter(connector, &conn_iter) {
> +               ret = drm_connector_register(connector);
> +               if (ret) {
> +                       failed_connector = connector;
> +                       goto err;
> +               }
> +       }
> +       drm_connector_list_iter_end(&conn_iter);
> +       mutex_unlock(&dev->mode_config.mutex);
> +
> +       return 0;
> +
> +err:
> +       drm_connector_list_iter_begin(dev, &conn_iter);
> +       drm_for_each_connector_iter(connector, &conn_iter) {
> +               if (failed_connector == connector)
> +                       break;
> +               drm_connector_unregister(connector);
> +       }
> +       drm_connector_list_iter_end(&conn_iter);
> +       mutex_unlock(&dev->mode_config.mutex);
> +
> +       return ret;
> +}
> +
>  static int kirin_drm_bind(struct device *dev)
>  {
>         struct drm_device *drm_dev;
> @@ -117,8 +151,17 @@ static int kirin_drm_bind(struct device *dev)
>
>         drm_fbdev_generic_setup(drm_dev, 32);
>
> +       /* connectors should be registered after drm device register */
> +       if (driver_data->register_connects) {
> +               ret = kirin_drm_connectors_register(drm_dev);
> +               if (ret)
> +                       goto err_drm_dev_unregister;
> +       }
> +
>         return 0;
>
> +err_drm_dev_unregister:
> +       drm_dev_unregister(drm_dev);
>  err_kms_cleanup:
>         kirin_drm_kms_cleanup(drm_dev);
>  err_drm_dev_put:
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
> index fdbfc4a90f22..95f56c9960d5 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
> @@ -39,6 +39,7 @@ struct kirin_drm_data {
>         u32 channel_formats_cnt;
>         int config_max_width;
>         int config_max_height;
> +       bool register_connects;
>         u32 num_planes;
>         u32 prim_plane;
>
> --
> 2.17.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
