Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD14C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6FB2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="ZuGdEOTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgDFTWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:22:12 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34694 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDFTWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:22:12 -0400
Received: by mail-io1-f65.google.com with SMTP id f3so746881ioj.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 12:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43HXVgJ+DiEVH1P2f9yVtx9VewU1GvCtyVKXZCcL8NA=;
        b=ZuGdEOTD9N4jwjCU/i8i/+B+2F/G8mHv4MwHgrqiW0IkvfL2kn02yzQrj3bnYjEZUb
         GV7NWiw3nMs/5TcIBCz4ZtD376LyHJ1PyHDIVbslGa2YB2DV0FPLtB+okiDJ1sRpdObM
         7fyIfuCruHRwTccgqyqwgJ7j5uv3luktjo29sp8qpCEwNj6s5RO1IYB5OaYCYYVQp/1/
         4/w/MrCHce1ItSoMdjaZLUPSyaBR2GPoqmEjkXrUl01z4uJepJIi3QrTjfVFRquc9d/b
         O5oGYXIAEtNTCNiLSbuaPt709/RpRkMtcCo8wTIa/liwLUK78tyTKJSvjnoCi62ABqeK
         XbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43HXVgJ+DiEVH1P2f9yVtx9VewU1GvCtyVKXZCcL8NA=;
        b=GrTEiFbN0XwPSDVnJBJQPPh0uvW6hFf51yEJg9CYbwkqcLXQXOrX3+ilhpYFcpp2c3
         EfbUDJI8piY055hu58enkFupWq7mWrXoq5c6sjoe8A9lOv5HcY3H/VXVv8+EY5/G7ODb
         dw8+paplp3rJCKJutnBX8JAnvxqcdetL2hzQtKj4lHsHo34BeuKlOf62OqtizteSMgnE
         6fewCmBuFTF0nGme9DtHgsZBBRo1EI1xRnyXcwdgb+TgD/KlQH6m9g4/HRWA3iftay2B
         DqU6kMuftu47k5MUSvK+P7WsaOXi2PqhF8Is+rAscg65V+wxec47YZ8ybssi5T+Kmvfj
         j+6w==
X-Gm-Message-State: AGi0PuY65TLKyJa9hTwK5yKlBizAN+HekUDbjQkCh3W2GMxxqhr1ADh1
        oXbHudA1gn4gtC0uNNMd1+ywlnZ3UsQTzq16om4hsA==
X-Google-Smtp-Source: APiQypKbLX+EYrn5ISXhltuzxMnHhVG/jM5JqBjkhcE0PmL8GJTBlHiWzYMl6zAPAtT4U224p5ZDsjQt38CxSqog/Xc=
X-Received: by 2002:a02:1c07:: with SMTP id c7mr858228jac.19.1586200930891;
 Mon, 06 Apr 2020 12:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200403200757.886443-1-lyude@redhat.com> <20200403200757.886443-2-lyude@redhat.com>
In-Reply-To: <20200403200757.886443-2-lyude@redhat.com>
From:   Sean Paul <sean@poorly.run>
Date:   Mon, 6 Apr 2020 15:21:34 -0400
Message-ID: <CAMavQK+fjw_Odj-nQkUnZVyGXv_62znBXk2MsUVzkZxuQDJC9A@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/dp_mst: Improve kdocs for drm_dp_check_act_status()
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
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

On Fri, Apr 3, 2020 at 4:08 PM Lyude Paul <lyude@redhat.com> wrote:
>
> No functional changes.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Sean Paul <sean@poorly.run>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 10d0315af513..2b9ce965f044 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -4462,10 +4462,14 @@ static int drm_dp_dpcd_write_payload(struct drm_dp_mst_topology_mgr *mgr,
>
>
>  /**
> - * drm_dp_check_act_status() - Check ACT handled status.
> + * drm_dp_check_act_status() - Polls for ACT handled status.
>   * @mgr: manager to use
>   *
> - * Check the payload status bits in the DPCD for ACT handled completion.
> + * Tries waiting for the MST hub to finish updating it's payload table by
> + * polling for the ACT handled bit.
> + *
> + * Returns:
> + * 0 if the ACT was handled in time, negative error code on failure.
>   */
>  int drm_dp_check_act_status(struct drm_dp_mst_topology_mgr *mgr)
>  {
> --
> 2.25.1
>
