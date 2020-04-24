Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28B2C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8031920857
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfOZcWCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgDXTQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727022AbgDXTQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:16:29 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB4CC09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 12:16:28 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x25so11855559wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8C+l34ylQ/fd4X7uZblckP7QFtPAfaKyL9kDot/4z4=;
        b=hfOZcWCALviq/FPpDxJ2lRmuzD2k7d7BdrAIZwQNcD7ZpG6rqG6beBNBN419L9LgHv
         qWjU1pqWXZMldct5Op1Mhn56WkPAnuYF8iYsZp1LvlJoAtnoR2IX23+YFb4QHUZQySXu
         Tun26rsYLpcFezcxPqxzfXbSLofJAa4rioAzb3z7A90I9bDLzeN+dvso/uNDAWd+VjYM
         HRjr0RMi5xnR/T8UmG9WG58ZA0169rBq20xYx13B4msc5HFIBd+4PsZTOzqNP1siOtH6
         4++h0v99wy+7hTEm4DrOPbpy9+BPYqg+ZR3W7N72cnOWqgIVBmHxh32mbCDWUHPN6N44
         hYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8C+l34ylQ/fd4X7uZblckP7QFtPAfaKyL9kDot/4z4=;
        b=rxynrPwdrA9OYkEpPLY3VZrtWdOfEXnwhul3BdYfH6VZ6LtV4HmzwKm4DwHP/xA2M1
         8s731UsuhSeDI4D6Y+kVLwSYDN3DV8zfHaIc/apVCOtmKJrS3xEMsW+fnvdqDvyRDzWX
         clgkiv0Eek19gh/2PhTPQ79yRP8OV/P1YaUEEegxdQLc6+rPtr9SDSQFYxMC43E204pZ
         iG8Y7+bULoFjQZHERLCrvMDyGPQrVtwRfUb7eMs+yux7+V/4G6dUjoQkxzL56QTfW2Gk
         BEGG6dIB5VBjO+CUyJFNweCYBuT/bkEkPeF2PC1QiPe7HEhhi8Khq1eT976Dr2/0Xo66
         BegA==
X-Gm-Message-State: AGi0PuYywtO3dubES6WgM8sUFlHrV7WZdYSQ8L8DKwX3SaGbQDOd4ypL
        WcaTQZKooNW8PHp7U2CBLm/AWwaBeRzDugK9lGEFFw==
X-Google-Smtp-Source: APiQypI9iWjkNlysuw5QaKuCzf9HmzjnV2ROy4i4+cCk9La240gYY1Dav76tBMmZFXyjCeHhhtFoiPI8C2aIGFxIVXY=
X-Received: by 2002:a1c:9d8c:: with SMTP id g134mr12074171wme.79.1587755787069;
 Fri, 24 Apr 2020 12:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200424190722.775284-1-lyude@redhat.com>
In-Reply-To: <20200424190722.775284-1-lyude@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 24 Apr 2020 15:16:15 -0400
Message-ID: <CADnq5_OhwMgkUNNE1gXJqSKxBMUkWU11oiOidE+SahUgatBzZA@mail.gmail.com>
Subject: Re: [PATCH] drm/dp_mst: Fix drm_dp_send_dpcd_write() return code
To:     Lyude Paul <lyude@redhat.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sean Paul <sean@poorly.run>
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

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
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
