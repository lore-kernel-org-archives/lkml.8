Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C613C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D78F20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GnYrsaN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgD3PJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgD3PJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:09:10 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090F0C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 08:09:10 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 19so5474377oiy.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5zQi7r9M2LfUopK89C3EkicnA25N+tRTfqcQYXwGa4Q=;
        b=GnYrsaN6NEU0QrNKTsi1gIN/yJe1TNR5CQCeXl9rdFJBLOEmWeZUNENU3rOJ3FSWsu
         qT8FH1y2B/G4LzYSg5SbCtR7kirzz51BW/b7P9XMFnKufdGhmqHT7mXstdf34kryWalf
         HfWcFuC1VUhCy/FePn/HmAx9/c3r7M9xMRFAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5zQi7r9M2LfUopK89C3EkicnA25N+tRTfqcQYXwGa4Q=;
        b=EWsO9XhaxQf9uwHteYqXLSMaN2HRfWTzh+oEqKaBghInYZP4YaC0/uS+dPZuXXQKWs
         pRNObXP1SxIO6OymMybL4GNKFkIm0nYLo771cnLWkdIDoLFXUXJ4++2b9SAoEh59UJZ6
         ReThdtEWQGm8Ib+NCQ3wIZQafgENrMONHmGNX+/D+MAMb+2RJtWxH+oEtJzFi6ZUApUp
         NwTbETv5QRi6MVm7bh8o6MaSgY2VNLvfc/jUbwVepEYnnuSvb5tWMfSpmppYFExKaOxp
         hg+dH7BkDq0lNZ3BwESVs4yiik5kFcCBngCCC/YmxV0FFg7ugoILrkGm4tsMuY30n5ql
         6EMA==
X-Gm-Message-State: AGi0PuZhZkZgjRXs4bq0lbWinHE/tluvcpr0kJxqBuaZk9XozYNxcnPM
        ggUEjsPeyRmhhjfqU5iDG2Kxu64cppyRlECuFzxM9Q==
X-Google-Smtp-Source: APiQypK116kyr5jlTbWU6tuCGp85AedUXlIu2BotcPBsyOWDWrXsYR7fZz/xZgi6gNwZzZIxNbnanEsgIscjJj+VMQg=
X-Received: by 2002:aca:52d5:: with SMTP id g204mr2123371oib.14.1588259349392;
 Thu, 30 Apr 2020 08:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200430145439.31257-1-manu@FreeBSD.org>
In-Reply-To: <20200430145439.31257-1-manu@FreeBSD.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 30 Apr 2020 17:08:58 +0200
Message-ID: <CAKMK7uHqFhd69Y7TM64ZHyi9-O0ka3h9dWG8mmiMQV5ZVBWWcA@mail.gmail.com>
Subject: Re: [RESEND 1/2] drm/client: Dual licence the header in GPL-2 and MIT
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@linux.ie>,
        Matthew D Roper <matthew.d.roper@intel.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 4:54 PM Emmanuel Vadot <manu@freebsd.org> wrote:
>
> Source file was dual licenced but the header was omitted, fix that.
> Contributors for this file are:
> Daniel Vetter <daniel.vetter@ffwll.ch>
> Matt Roper <matthew.d.roper@intel.com>
> Maxime Ripard <mripard@kernel.org>
> Noralf Tr=C3=B8nnes <noralf@tronnes.org>
> Thomas Zimmermann <tzimmermann@suse.de>
>
> Acked-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
> Acked-by: Matt Roper <matthew.d.roper@intel.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  include/drm/drm_client.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
> index 7402f852d3c4..eb259c2547af 100644
> --- a/include/drm/drm_client.h
> +++ b/include/drm/drm_client.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 or MIT */
>
>  #ifndef _DRM_CLIENT_H_
>  #define _DRM_CLIENT_H_
> --
> 2.25.1
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
