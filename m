Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF409C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6701206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="gI6JqKUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDFTln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:41:43 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:44863 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDFTln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:41:43 -0400
Received: by mail-il1-f196.google.com with SMTP id j69so663191ila.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 12:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ObVP0Ql3dQSFUBj6FV5Dg+/qcbDaFb2lAm/CHxNPrtM=;
        b=gI6JqKUGVUQakEsJwvly5Do7pbjw3onnRbPQjkzq1YbMEBwieSme/YWuPIdBnzk0xd
         ZuruKprdkpX1HPPz+mE5Hz/C++ZAsVeYUY95JoJc83c19JHEvD/e5ui1qyBb7bDWLjBV
         3p6xhFrM4c11nrIozp8hs6vpA+4041AZuZKXy4INYvRAdjYRU+7ksGYLd8NAERgah4VQ
         uAqxk4wZjpK+XXY1EudhEA0sJo7YOgV76/51TXQJR/7AddfF8yAtsQRdA+L3YCpfDH7r
         QiD+yzzIP/kuLpEXA4LU0RqoE+alEE4+34WRy5LE+cy8tj1mI1Km8k8GP9Wr5HAtrD28
         qBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ObVP0Ql3dQSFUBj6FV5Dg+/qcbDaFb2lAm/CHxNPrtM=;
        b=kK9AoWo8ovPqIpbyn1v3wH2VxXW6ZpZV/S4xWE/3eiQKCtYKd4VNqFimU5t3IPBrYg
         y19kFOlXLAurIZ/tu6ND1cTMd1q8P21x2cmS08NIRscc171RJnAwSA/rlIqib96aLRNk
         pO+HsuFTQ7F4cOFkSuUp0T5c0ivCiQM9fOtlVWt+lmRsKsYXQM9XmYUXmeN/AYBZSwrT
         R7+ivrYel26fDV24bAjv6tNaB31Nr59KO9Bh6tMB+avC9CKDqjRIe4YFOrhASMdivsqV
         mgKQIbv/4Qc59TYwZ+hh+E3aDHIA30GSudMM+9FMCRLGIA2OBvoKbXsxX0tf5hPVtpjB
         Ct/g==
X-Gm-Message-State: AGi0PuZj1PgvTqNqdJihXj69N7ygyn3Vi/a3gazVcqcNPe6de+eHnFxu
        lDud3BTlViaoG403jLrAL6AAAwgZ7GgMv5VuHlE/Pg==
X-Google-Smtp-Source: APiQypIbcoeF7b0s3ehgR6+NX7GL4qHxlh0wQ9LF1er1s2zpgqE4Aw5++0SluYrIgrxIk4IZ7o519esepLHNrIwEBjE=
X-Received: by 2002:a92:91d6:: with SMTP id e83mr1037033ill.165.1586202101788;
 Mon, 06 Apr 2020 12:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200403200757.886443-1-lyude@redhat.com> <20200403200757.886443-4-lyude@redhat.com>
In-Reply-To: <20200403200757.886443-4-lyude@redhat.com>
From:   Sean Paul <sean@poorly.run>
Date:   Mon, 6 Apr 2020 15:41:05 -0400
Message-ID: <CAMavQK+yVxFYNUR1wdfwB_UhRS2ziy0N5k+WTwAqUwRovX3GMA@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/dp_mst: Increase ACT retry timeout to 3s
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        stable <stable@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Todd Previte <tprevite@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 4:08 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Currently we only poll for an ACT up to 30 times, with a busy-wait delay
> of 100=C2=B5s between each attempt - giving us a timeout of 2900=C2=B5s. =
While
> this might seem sensible, it would appear that in certain scenarios it
> can take dramatically longer then that for us to receive an ACT. On one
> of the EVGA MST hubs that I have available, I observed said hub
> sometimes taking longer then a second before signalling the ACT. These
> delays mostly seem to occur when previous sideband messages we've sent
> are NAKd by the hub, however it wouldn't be particularly surprising if
> it's possible to reproduce times like this simply by introducing branch
> devices with large LCTs since payload allocations have to take effect on
> every downstream device up to the payload's target.
>
> So, instead of just retrying 30 times we poll for the ACT for up to 3ms,
> and additionally use usleep_range() to avoid a very long and rude
> busy-wait. Note that the previous retry count of 30 appears to have been
> arbitrarily chosen, as I can't find any mention of a recommended timeout
> or retry count for ACTs in the DisplayPort 2.0 specification. This also
> goes for the range we were previously using for udelay(), although I
> suspect that was just copied from the recommended delay for link
> training on SST devices.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: ad7f8a1f9ced ("drm/helper: add Displayport multi-stream helper (v0=
.6)")
> Cc: Sean Paul <sean@poorly.run>
> Cc: <stable@vger.kernel.org> # v3.17+
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
> index 7aaf184a2e5f..f313407374ed 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -4466,17 +4466,30 @@ static int drm_dp_dpcd_write_payload(struct drm_d=
p_mst_topology_mgr *mgr,
>   * @mgr: manager to use
>   *
>   * Tries waiting for the MST hub to finish updating it's payload table b=
y
> - * polling for the ACT handled bit.
> + * polling for the ACT handled bit for up to 3 seconds (yes-some hubs re=
ally
> + * take that long).
>   *
>   * Returns:
>   * 0 if the ACT was handled in time, negative error code on failure.
>   */
>  int drm_dp_check_act_status(struct drm_dp_mst_topology_mgr *mgr)
>  {
> -       int count =3D 0, ret;
> +       /*
> +        * There doesn't seem to be any recommended retry count or timeou=
t in
> +        * the MST specification. Since some hubs have been observed to t=
ake
> +        * over 1 second to update their payload allocations under certai=
n
> +        * conditions, we use a rather large timeout value.
> +        */
> +       const int timeout_ms =3D 3000;
> +      unsigned long timeout =3D jiffies + msecs_to_jiffies(timeout_ms);
> +       int ret;
> +       bool retrying =3D false;
>         u8 status;
>
>         do {
> +               if (retrying)
> +                       usleep_range(100, 1000);
> +
>                 ret =3D drm_dp_dpcd_readb(mgr->aux,
>                                         DP_PAYLOAD_TABLE_UPDATE_STATUS,
>                                         &status);
> @@ -4488,13 +4501,12 @@ int drm_dp_check_act_status(struct drm_dp_mst_top=
ology_mgr *mgr)
>
>                 if (status & DP_PAYLOAD_ACT_HANDLED)
>                         break;
> -               count++;
> -               udelay(100);
> -       } while (count < 30);
> +               retrying =3D true;
> +       } while (jiffies < timeout);

Somewhat academic, but I think there's an overflow possibility here if
timeout is near ulong_max and jiffies overflows during the usleep. In
that case we'll be retrying for a very loong time.

I wish we had i915's wait_for() macro available to all drm...

Sean

>
>         if (!(status & DP_PAYLOAD_ACT_HANDLED)) {
> -               DRM_DEBUG_KMS("failed to get ACT bit %d after %d retries\=
n",
> -                             status, count);
> +               DRM_DEBUG_KMS("failed to get ACT bit %d after %dms\n",
> +                             status, timeout_ms);
>                 return -EINVAL;
>         }
>         return 0;
> --
> 2.25.1
>
