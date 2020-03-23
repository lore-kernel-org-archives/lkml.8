Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7AAC54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0FF206F8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eEY3uZnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgCWKCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 06:02:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52450 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbgCWKCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 06:02:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id z18so5098265wmk.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 03:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c/G3djmQ9L0s/XsuKOJMNgPp2LxlAoZHW8O26I1non0=;
        b=eEY3uZnhGEDCgL9uvcc+LVLbAOe814GpFFht2gcuhkkWurLKI7o/UlKGmkUdVtuEWs
         f5WO6hDGOofOCnnKSop6fczJf2pKeWBaCxp9XBwoTO1IFcePhT44oN6SzIfCgo58Yr+G
         +xDOJYD1d8IAF8r83fkECDl7N430d8Wf2hagE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=c/G3djmQ9L0s/XsuKOJMNgPp2LxlAoZHW8O26I1non0=;
        b=RcgX0Bzz/s4AXGICIav/vwiFjpy89iFWhCJnKc7aEU+CqVGiImhabQ/cYoePJ2OZ3b
         YkrIwTbg+SG8IeNnaww6BoHfheiUMMfKUuDg7qHw+Mke/Pya+7mkyuYOFKWGSjThWXID
         QbqkvmYvFMHa5pDkDobbYqDME3xnN05WfMk7BtqiDOdwTuqKJv1sVaczCPfiJEal9n5E
         xt7HyzV+2CeWAFv5HgbadtK9GUJGxCejZiTnZHltliqrTm3rqhDnEvnv7/7mT1cs+WWk
         qz9waPSiSud9QnES4729LdMe3d6EC4PKhGBe7S2XM4KYRUfULUjK6TIX7z+aLMVrylzk
         l+SQ==
X-Gm-Message-State: ANhLgQ3TKkitIM7S9L/GjZfz+S9w06oYUy1sloagXBCZGNIEGATqr5rJ
        eQgMafsy2soQadDtVH5sRE2udQ==
X-Google-Smtp-Source: ADFU+vsk7vFUSdGnPkqggTjZX5hkr49MPDRR/bYWeclQuUjn3zcUH6a9NaMeOd4uYXwUkAsjJGuHmQ==
X-Received: by 2002:a1c:9a8d:: with SMTP id c135mr26810585wme.183.1584957721327;
        Mon, 23 Mar 2020 03:02:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i8sm22081696wrw.55.2020.03.23.03.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 03:02:00 -0700 (PDT)
Date:   Mon, 23 Mar 2020 11:01:58 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Emmanuel Vadot <manu@FreeBSD.org>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        matthew.d.roper@intel.com, noralf@tronnes.org, kraxel@redhat.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/client: Dual licence the header in GPL-2 and MIT
Message-ID: <20200323100158.GG2363188@phenom.ffwll.local>
Mail-Followup-To: Emmanuel Vadot <manu@FreeBSD.org>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, matthew.d.roper@intel.com,
        noralf@tronnes.org, kraxel@redhat.com, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200320022114.2234-1-manu@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200320022114.2234-1-manu@FreeBSD.org>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 03:21:13AM +0100, Emmanuel Vadot wrote:
> Source file was dual licenced but the header was omitted, fix that.
> Contributors for this file are:
> Daniel Vetter <daniel.vetter@ffwll.ch>
> Matt Roper <matthew.d.roper@intel.com>
> Maxime Ripard <mripard@kernel.org>
> Noralf Trønnes <noralf@tronnes.org>
> Thomas Zimmermann <tzimmermann@suse.de>
> 
> Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  include/drm/drm_client.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
> index 3ed5dee899fd..94c9c72c206d 100644
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

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
