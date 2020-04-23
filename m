Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB11C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B7272076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="J2cpulx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgDWRKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbgDWRKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 13:10:24 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E164C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 10:10:24 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id f82so6238973ilh.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDZIPCWX04Rv+fQmlklcXypovzaN+rHOhRlSd4PpxpA=;
        b=J2cpulx9oZ2gZmglxutj3TyqQ8tuAOLt1ykp7NvCjHhmH64qa0lhr0WOvIg5r1AqTH
         JT40RG45msOHeSLfTCdmJ//Nf55FVKLudexF7d5Fw9QnGiCcYlEOPszkruT1F57qk/du
         22oBjDZxiXwwbQ5abxX2Wk93IRNiqbOAsqRUR0PcjBx08EAo0YLLLjYV8S/tDotWTqvA
         Kcb3O/7b/PaJOmA39pt3Gs6aypz3hotCogXg8aN9l0mVS+d2yPGQCX7Gxw4wHzWgNrB6
         3DPzOZOFIsp3ek79oXYfupdk7+dpg/S2FXphszTTXwWhVWhpVy6Rvlz3v4b0HcPBg+/g
         iZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDZIPCWX04Rv+fQmlklcXypovzaN+rHOhRlSd4PpxpA=;
        b=EYTrIciCwLbt7rjR07qit4O/oblWInt0S8zItxcfl2h6sKX0WtrZL0hFL47QyeKJle
         Bn++Kb6Sie5PBSZ+KYudrJtGfm7V7LHHzh/XKIBjh2lnFtQ0D28usZhBlaBUQkuHtvj8
         KbaZYFVwt7RmXApPi7rGpD5IxqsXZVSk3y/P98yzWRi/F1nBozJ3N5DK+u2/ahbCOu0f
         ZuoQo/TXwzQw6WmG6qSdcpGopG38/mcz+fDqOO6SPz24bPucrsB5pQDysDM+b7PYNeUo
         oHxZC41TdGCKy+JHPunNCsgv9kCUN559mpZFos3C4HxluTsWg0FpY94Hsl0USQGNHRDv
         AMKg==
X-Gm-Message-State: AGi0PubeX9SerMtvOGUWjuDTZSLLQtluqbEbpHfBFvgsGMwEO9LRHsUJ
        gaPNXzwj11M0t8I19JvNwBSrROU246xexBvBBghVEA==
X-Google-Smtp-Source: APiQypIo3mex+K2fC8WKDWJ+oW+1j5+G8dhUV5kVlwhJ8MrS4yMIIlw6dA5ap2Q8FuRB6t/4/Nm+mAmwN5y4P/oschg=
X-Received: by 2002:a92:5f17:: with SMTP id t23mr4493221ilb.2.1587661823557;
 Thu, 23 Apr 2020 10:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200423164225.680178-1-lyude@redhat.com>
In-Reply-To: <20200423164225.680178-1-lyude@redhat.com>
From:   Sean Paul <sean@poorly.run>
Date:   Thu, 23 Apr 2020 13:09:46 -0400
Message-ID: <CAMavQKJf9aXnUcK83ZXhinJcK+ttDrscnNCyXGMZWqspG1681w@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/dp_mst: Remove single tx msg restriction."
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Wayne Lin <Wayne.Lin@amd.com>,
        Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <waynelin@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 12:42 PM Lyude Paul <lyude@redhat.com> wrote:
>
> This reverts commit 6bb0942e8f46863a745489cce27efe5be2a3885e.
>
> Unfortunately it would appear that the rumors we've heard of sideband
> message interleaving not being very well supported are true. On the
> Lenovo ThinkPad Thunderbolt 3 dock that I have, interleaved messages
> appear to just get dropped:
>
>   [drm:drm_dp_mst_wait_tx_reply [drm_kms_helper]] timedout msg send
>   00000000571ddfd0 2 1
>   [dp_mst] txmsg cur_offset=2 cur_len=2 seqno=1 state=SENT path_msg=1 dst=00
>   [dp_mst]      type=ENUM_PATH_RESOURCES contents:
>   [dp_mst]              port=2
>
> DP descriptor for this hub:
>   OUI 90-cc-24 dev-ID SYNA3  HW-rev 1.0 SW-rev 3.12 quirks 0x0008
>
> It would seem like as well that this is a somewhat well known issue in
> the field. From section 5.4.2 of the DisplayPort 2.0 specification:
>
>   There are MST Sink/Branch devices in the field that do not handle
>   interleaved message transactions.
>
>   To facilitate message transaction handling by downstream devices, an
>   MST Source device shall generate message transactions in an atomic
>   manner (i.e., the MST Source device shall not concurrently interleave
>   multiple message transactions). Therefore, an MST Source device shall
>   clear the Message_Sequence_No value in the Sideband_MSG_Header to 0.
>
>   MST Source devices that support field policy updates by way of
>   software should update the policy to forego the generation of
>   interleaved message transactions.
>
> This is a bit disappointing, as features like HDCP require that we send
> a sideband request every ~2 seconds for each active stream. However,
> there isn't really anything in the specification that allows us to
> accurately probe for interleaved messages.
>
> If it ends up being that we -really- need this in the future, we might
> be able to whitelist hubs where interleaving is known to work-or maybe
> try some sort of heuristics. But for now, let's just play it safe and
> not use it.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 6bb0942e8f46 ("drm/dp_mst: Remove single tx msg restriction.")
> Cc: Wayne Lin <Wayne.Lin@amd.com>
> Cc: Sean Paul <seanpaul@chromium.org>

Bummer :-(

Thanks for digging into this!

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 14 ++++++++++++--
>  include/drm/drm_dp_mst_helper.h       |  5 +++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 21f10ceb3d6c..03a1496f6120 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1205,6 +1205,8 @@ static int drm_dp_mst_wait_tx_reply(struct drm_dp_mst_branch *mstb,
>                     txmsg->state == DRM_DP_SIDEBAND_TX_SENT) {
>                         mstb->tx_slots[txmsg->seqno] = NULL;
>                 }
> +               mgr->is_waiting_for_dwn_reply = false;
> +
>         }
>  out:
>         if (unlikely(ret == -EIO) && drm_debug_enabled(DRM_UT_DP)) {
> @@ -1214,6 +1216,7 @@ static int drm_dp_mst_wait_tx_reply(struct drm_dp_mst_branch *mstb,
>         }
>         mutex_unlock(&mgr->qlock);
>
> +       drm_dp_mst_kick_tx(mgr);
>         return ret;
>  }
>
> @@ -2789,9 +2792,11 @@ static void process_single_down_tx_qlock(struct drm_dp_mst_topology_mgr *mgr)
>         ret = process_single_tx_qlock(mgr, txmsg, false);
>         if (ret == 1) {
>                 /* txmsg is sent it should be in the slots now */
> +               mgr->is_waiting_for_dwn_reply = true;
>                 list_del(&txmsg->next);
>         } else if (ret) {
>                 DRM_DEBUG_KMS("failed to send msg in q %d\n", ret);
> +               mgr->is_waiting_for_dwn_reply = false;
>                 list_del(&txmsg->next);
>                 if (txmsg->seqno != -1)
>                         txmsg->dst->tx_slots[txmsg->seqno] = NULL;
> @@ -2831,7 +2836,8 @@ static void drm_dp_queue_down_tx(struct drm_dp_mst_topology_mgr *mgr,
>                 drm_dp_mst_dump_sideband_msg_tx(&p, txmsg);
>         }
>
> -       if (list_is_singular(&mgr->tx_msg_downq))
> +       if (list_is_singular(&mgr->tx_msg_downq) &&
> +           !mgr->is_waiting_for_dwn_reply)
>                 process_single_down_tx_qlock(mgr);
>         mutex_unlock(&mgr->qlock);
>  }
> @@ -3823,6 +3829,7 @@ static int drm_dp_mst_handle_down_rep(struct drm_dp_mst_topology_mgr *mgr)
>         mutex_lock(&mgr->qlock);
>         txmsg->state = DRM_DP_SIDEBAND_TX_RX;
>         mstb->tx_slots[seqno] = NULL;
> +       mgr->is_waiting_for_dwn_reply = false;
>         mutex_unlock(&mgr->qlock);
>
>         wake_up_all(&mgr->tx_waitq);
> @@ -3830,6 +3837,9 @@ static int drm_dp_mst_handle_down_rep(struct drm_dp_mst_topology_mgr *mgr)
>         return 0;
>
>  out_clear_reply:
> +       mutex_lock(&mgr->qlock);
> +       mgr->is_waiting_for_dwn_reply = false;
> +       mutex_unlock(&mgr->qlock);
>         if (msg)
>                 memset(msg, 0, sizeof(struct drm_dp_sideband_msg_rx));
>  out:
> @@ -4683,7 +4693,7 @@ static void drm_dp_tx_work(struct work_struct *work)
>         struct drm_dp_mst_topology_mgr *mgr = container_of(work, struct drm_dp_mst_topology_mgr, tx_work);
>
>         mutex_lock(&mgr->qlock);
> -       if (!list_empty(&mgr->tx_msg_downq))
> +       if (!list_empty(&mgr->tx_msg_downq) && !mgr->is_waiting_for_dwn_reply)
>                 process_single_down_tx_qlock(mgr);
>         mutex_unlock(&mgr->qlock);
>  }
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index 2d7c26592c05..96bcf33c03d3 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -592,6 +592,11 @@ struct drm_dp_mst_topology_mgr {
>          */
>         bool payload_id_table_cleared : 1;
>
> +       /**
> +        * @is_waiting_for_dwn_reply: whether we're waiting for a down reply.
> +        */
> +       bool is_waiting_for_dwn_reply : 1;
> +
>         /**
>          * @mst_primary: Pointer to the primary/first branch device.
>          */
> --
> 2.25.3
>
