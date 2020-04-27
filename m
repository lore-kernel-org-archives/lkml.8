Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A8FC55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D0F206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="LxE9mN4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgD0N6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgD0N6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:58:44 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B52C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 06:58:43 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id i19so18892908ioh.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 06:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=31DWhMiN+Q5O8LjX9FMcdqbPtRnIZ8bro6sPXS/U7gw=;
        b=LxE9mN4VwaFVH57j3DYncmgT6q+BaAcbSPQZswe7GpeID08ZumAd+p0uqp6MtY2llf
         B8HP4bFZ1bUIcHZVucZQdFyjcemKxpDDwtAkVsIZ4DXVUdkHAISXUgWEdM/UIjQ9XVd2
         Ap0vnBhtIbKfI8XNL3QQI0WPkHjJzU6+7aboB8spaFwDDAA53eOA1TwKeOlWh34YwbLE
         5wLIUS05PU9Y1K9jxQ7OYBt2b/tCb/qkL095S3oG4ym4KZW0SM5/ROQlnNescBqTaYYa
         C1gG0/OvJOIihTHWTbsKNGvnGx8GVkBjZT2DuaCdci6le78e13ERfMt8XIjWqlFu4W/1
         oiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=31DWhMiN+Q5O8LjX9FMcdqbPtRnIZ8bro6sPXS/U7gw=;
        b=EZ4HlWHxUXbJYpRDJfyCYBQH+DYVyODCYFj2fKMfu9kFr2mgORJsi706yqNhrDWY6k
         VDC/t9gnM6hLAVC2oGOhenJlDTkbrcDIKNPtFA6+HgIJxUzzYrK9UJrNJJtJjrD0xAAa
         Hp2iCs1sEVZX6OaIdfkQNGZdmMkUB3JZ6z+taAsrDOWgZgXA/1EofDU74JCgoVBxy8tM
         AAbtAEfg2vXBlhIzzJVK4x7Lidk9kJz4AuxE3swkFsgGpTnuIAYUYTmCRdI9th/Uh0aw
         UqLHVBcjGB5+KmXuTyV2GHop7vTJNzI44CJyqaFqj395Gmkrvn8/epmFyB3+F56eGmLc
         Tubw==
X-Gm-Message-State: AGi0PubfFGze1rkvsKGpXnqru+YmAVxcVZA3bpux6cWO087wrPeHd4Fz
        JnYbRJfvoCCrNSBLD6QuJnk+XgIru+ArLfa1bgAhZA==
X-Google-Smtp-Source: APiQypLGCSh1bWm5z1oGONA7AQw+6ZPTuybQVogs7OuT7yfxD7VDOGvpfztvDELSWbpZzsSsX80Vh6llLUrghBS+OOs=
X-Received: by 2002:a05:6602:2e0b:: with SMTP id o11mr20489781iow.94.1587995922530;
 Mon, 27 Apr 2020 06:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200424190722.775284-1-lyude@redhat.com>
In-Reply-To: <20200424190722.775284-1-lyude@redhat.com>
From:   Sean Paul <sean@poorly.run>
Date:   Mon, 27 Apr 2020 09:58:06 -0400
Message-ID: <CAMavQKLDtUjaLYUZka0hwRO4vgR_g+rF3KYvPMyCMY5BL9XsmQ@mail.gmail.com>
Subject: Re: [PATCH] drm/dp_mst: Fix drm_dp_send_dpcd_write() return code
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 3:07 PM Lyude Paul <lyude@redhat.com> wrote:
>
> drm_dp_mst_wait_tx_reply() returns > 1 if time elapsed in
> wait_event_timeout() before check_txmsg_state(mgr, txmsg) evaluated to
> true. However, we make the mistake of returning this time from
> drm_dp_send_dpcd_write() on success instead of returning the number of
> bytes written - causing spontaneous failures during link probing:
>
> [drm:drm_dp_send_link_address [drm_kms_helper]] *ERROR* GUID check on
> 10:01 failed: 3975
>
> Yikes! So, fix this by returning the number of bytes written on success
> instead.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: cb897542c6d2 ("drm/dp_mst: Fix W=1 warnings")
> Cc: Benjamin Gaignard <benjamin.gaignard@st.com>
> Cc: Sean Paul <sean@poorly.run>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 03a1496f6120..21dc78cb4ba6 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3436,8 +3436,12 @@ static int drm_dp_send_dpcd_write(struct drm_dp_mst_topology_mgr *mgr,
>         drm_dp_queue_down_tx(mgr, txmsg);
>
>         ret = drm_dp_mst_wait_tx_reply(mstb, txmsg);
> -       if (ret > 0 && txmsg->reply.reply_type == DP_SIDEBAND_REPLY_NAK)
> -               ret = -EIO;
> +       if (ret > 0) {
> +               if (txmsg->reply.reply_type == DP_SIDEBAND_REPLY_NAK)
> +                       ret = -EIO;
> +               else
> +                       ret = size;
> +       }
>
>         kfree(txmsg);
>  fail_put:
> --
> 2.25.3
>
