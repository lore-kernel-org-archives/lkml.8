Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735E8C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374322166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAhpgMvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgCDLlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:41:18 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41456 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbgCDLlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:41:18 -0500
Received: by mail-qt1-f195.google.com with SMTP id l21so1054877qtr.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 03:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8we+KmoFgb0f1SdWSTkNbXpKVEQ3mQv4+x5NOeTrT9E=;
        b=hAhpgMvguL+0Sl+C0Y4w5NF3FdnsBt6UQ9fEzebTZpKZn7IoThHzrDoMkSIxNWUZbt
         nErTXYqR5LZkXCRxcqEe9oN0Ec1aR+A9AX3z4CP2UsAXQ3Zz42K3QL8TMfNETqCJO7xS
         RYcdghPV/cnjozssmHlesWwTGfKKweEEGszrHkPzgw7SS8AOVvby52vDjxkzFIoxq6GM
         /h/b/fAKsJj+TNYDWHR83m/CgPdBQMBDtmjGAEvSmdLOsHhgPhYh5PCg6E0skacJzNr3
         go8KhL1ybF3B5HLdgm2tb79zom/6RsRFNXelgdYGdY/2CqrQTpgE7UrebnyUOIMsZJmD
         ec+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8we+KmoFgb0f1SdWSTkNbXpKVEQ3mQv4+x5NOeTrT9E=;
        b=UOF/ZJ7SGf1UZ4giKzugHkaFaP8JvV0Fnr6gG1FT/HCgUz2ydW0LZz5mOBlwRqfeMb
         kpaA8+koMhFarXVgOlM/M8NoM0TU08fGLSqGLy/PB+2Zc1f9UPSHl77GXavxAYydAvd8
         13s8aERMV7Fi48BiaebhM8CM+2MGuD6UU/lTebNpZFIRDIxmqMl1CKR9HBeITK5ZBCzh
         LFk/ZS/YmONU5Pm2SUp3N/Rq0bbE0SYhNU1R/C7Dh1756L4qCCYblL7wIpZ1MNBSDfn9
         VikACxbtC02jEr4Clhb781Y0ya3AfAYXf8nS+WT4n6rJtkxf5PP+qDHMSWc+j7+qCeoK
         Gk8A==
X-Gm-Message-State: ANhLgQ0srA8kEzAgUTEwkDN6zVds98g6xa9Dbnr9LntE60uEvG6tE2is
        KJhtpvxMcWyv4Pn59GLMChjcp1SOcz5CI8RtJMrwPQ==
X-Google-Smtp-Source: ADFU+vuVA+L/jjkp9i68p6aWcuFW7rOO9fJxRVZk/aTzJPCz1qwrZ8Zixv12e1NIAQSlmZoF3VF7C0L3MbefXktoiMs=
X-Received: by 2002:aed:3f3c:: with SMTP id p57mr2016443qtf.234.1583322076769;
 Wed, 04 Mar 2020 03:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20200131092147.32063-1-benjamin.gaignard@st.com>
In-Reply-To: <20200131092147.32063-1-benjamin.gaignard@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 4 Mar 2020 12:41:04 +0100
Message-ID: <CA+M3ks5y457YP4x_W8_Bv4OooicJSHtFyZ4CAfbEPvkhiQ5wSw@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: context: Clean up documentation
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 3 f=C3=A9vr. 2020 =C3=A0 09:11, Benjamin Gaignard
<benjamin.gaignard@st.com> a =C3=A9crit :
>
> Fix kernel doc comments to avoid warnings when compiling with W=3D1.

gentle ping.

Benjamin

>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/gpu/drm/drm_context.c | 145 ++++++++++++++++++------------------=
------
>  1 file changed, 61 insertions(+), 84 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_context.c b/drivers/gpu/drm/drm_context.=
c
> index 1f802d8e5681..54e64d612a2b 100644
> --- a/drivers/gpu/drm/drm_context.c
> +++ b/drivers/gpu/drm/drm_context.c
> @@ -43,15 +43,11 @@ struct drm_ctx_list {
>         struct drm_file *tag;
>  };
>
> -/******************************************************************/
> -/** \name Context bitmap support */
> -/*@{*/
> -
>  /**
> - * Free a handle from the context bitmap.
> + * drm_legacy_ctxbitmap_free() - Free a handle from the context bitmap.
>   *
> - * \param dev DRM device.
> - * \param ctx_handle context handle.
> + * @dev: DRM device.
> + * @ctx_handle: context handle.
>   *
>   * Clears the bit specified by \p ctx_handle in drm_device::ctx_bitmap a=
nd the entry
>   * in drm_device::ctx_idr, while holding the drm_device::struct_mutex
> @@ -69,10 +65,10 @@ void drm_legacy_ctxbitmap_free(struct drm_device * de=
v, int ctx_handle)
>  }
>
>  /**
> - * Context bitmap allocation.
> + * drm_legacy_ctxbitmap_next() - Context bitmap allocation.
>   *
> - * \param dev DRM device.
> - * \return (non-negative) context handle on success or a negative number=
 on failure.
> + * @dev: DRM device.
> + * Return: (non-negative) context handle on success or a negative number=
 on failure.
>   *
>   * Allocate a new idr from drm_device::ctx_idr while holding the
>   * drm_device::struct_mutex lock.
> @@ -89,9 +85,9 @@ static int drm_legacy_ctxbitmap_next(struct drm_device =
* dev)
>  }
>
>  /**
> - * Context bitmap initialization.
> + * drm_legacy_ctxbitmap_init() - Context bitmap initialization.
>   *
> - * \param dev DRM device.
> + * @dev: DRM device.
>   *
>   * Initialise the drm_device::ctx_idr
>   */
> @@ -105,9 +101,9 @@ void drm_legacy_ctxbitmap_init(struct drm_device * de=
v)
>  }
>
>  /**
> - * Context bitmap cleanup.
> + * drm_legacy_ctxbitmap_cleanup() - bitmap cleanup.
>   *
> - * \param dev DRM device.
> + * @dev: DRM device.
>   *
>   * Free all idr members using drm_ctx_sarea_free helper function
>   * while holding the drm_device::struct_mutex lock.
> @@ -157,20 +153,13 @@ void drm_legacy_ctxbitmap_flush(struct drm_device *=
dev, struct drm_file *file)
>         mutex_unlock(&dev->ctxlist_mutex);
>  }
>
> -/*@}*/
> -
> -/******************************************************************/
> -/** \name Per Context SAREA Support */
> -/*@{*/
> -
>  /**
> - * Get per-context SAREA.
> + * drm_legacy_getsareactx() - Get per-context SAREA.
>   *
> - * \param inode device inode.
> - * \param file_priv DRM file private.
> - * \param cmd command.
> - * \param arg user argument pointing to a drm_ctx_priv_map structure.
> - * \return zero on success or a negative number on failure.
> + * @dev: DRM device to operate on
> + * @data: request data
> + * @file_priv: DRM file private.
> + * Return:  zero on success or a negative number on failure.
>   *
>   * Gets the map from drm_device::ctx_idr with the handle specified and
>   * returns its handle.
> @@ -212,13 +201,12 @@ int drm_legacy_getsareactx(struct drm_device *dev, =
void *data,
>  }
>
>  /**
> - * Set per-context SAREA.
> + * drm_legacy_setsareactx() - Set per-context SAREA.
>   *
> - * \param inode device inode.
> - * \param file_priv DRM file private.
> - * \param cmd command.
> - * \param arg user argument pointing to a drm_ctx_priv_map structure.
> - * \return zero on success or a negative number on failure.
> + * @dev: DRM device to operate on
> + * @data: request data
> + * @file_priv: DRM file private.
> + * Return: zero on success or a negative number on failure.
>   *
>   * Searches the mapping specified in \p arg and update the entry in
>   * drm_device::ctx_idr with it.
> @@ -257,19 +245,13 @@ int drm_legacy_setsareactx(struct drm_device *dev, =
void *data,
>         return 0;
>  }
>
> -/*@}*/
> -
> -/******************************************************************/
> -/** \name The actual DRM context handling routines */
> -/*@{*/
> -
>  /**
> - * Switch context.
> + * drm_context_switch() - Switch context.
>   *
> - * \param dev DRM device.
> - * \param old old context handle.
> - * \param new new context handle.
> - * \return zero on success or a negative number on failure.
> + * @dev: DRM device.
> + * @old: old context handle.
> + * @new: new context handle.
> + * Return: zero on success or a negative number on failure.
>   *
>   * Attempt to set drm_device::context_flag.
>   */
> @@ -291,11 +273,12 @@ static int drm_context_switch(struct drm_device * d=
ev, int old, int new)
>  }
>
>  /**
> - * Complete context switch.
> + * drm_context_switch_complete() - Complete context switch.
>   *
> - * \param dev DRM device.
> - * \param new new context handle.
> - * \return zero on success or a negative number on failure.
> + * @dev: DRM device.
> + * @file_priv: DRM file private.
> + * @new: new context handle.
> + * Return: zero on success or a negative number on failure.
>   *
>   * Updates drm_device::last_context and drm_device::last_switch. Verifie=
s the
>   * hardware lock is held, clears the drm_device::context_flag and wakes =
up
> @@ -319,13 +302,13 @@ static int drm_context_switch_complete(struct drm_d=
evice *dev,
>  }
>
>  /**
> - * Reserve contexts.
> + * drm_legacy_resctx() - Reserve contexts.
> + *
> + * @dev: DRM device to operate on
> + * @data: request data
> + * @file_priv: DRM file private.
>   *
> - * \param inode device inode.
> - * \param file_priv DRM file private.
> - * \param cmd command.
> - * \param arg user argument pointing to a drm_ctx_res structure.
> - * \return zero on success or a negative number on failure.
> + * Return: zero on success or a negative number on failure.
>   */
>  int drm_legacy_resctx(struct drm_device *dev, void *data,
>                       struct drm_file *file_priv)
> @@ -352,15 +335,13 @@ int drm_legacy_resctx(struct drm_device *dev, void =
*data,
>  }
>
>  /**
> - * Add context.
> + * drm_legacy_addctx() - Add context.
>   *
> - * \param inode device inode.
> - * \param file_priv DRM file private.
> - * \param cmd command.
> - * \param arg user argument pointing to a drm_ctx structure.
> - * \return zero on success or a negative number on failure.
> + * @dev: DRM device to operate on
> + * @data: request data
> + * @file_priv: DRM file private.
>   *
> - * Get a new handle for the context and copy to userspace.
> + * Return: zero on success or a negative number on failure.
>   */
>  int drm_legacy_addctx(struct drm_device *dev, void *data,
>                       struct drm_file *file_priv)
> @@ -405,13 +386,12 @@ int drm_legacy_addctx(struct drm_device *dev, void =
*data,
>  }
>
>  /**
> - * Get context.
> + * drm_legacy_getctx() - Get context.
>   *
> - * \param inode device inode.
> - * \param file_priv DRM file private.
> - * \param cmd command.
> - * \param arg user argument pointing to a drm_ctx structure.
> - * \return zero on success or a negative number on failure.
> + * @dev: DRM device to operate on
> + * @data: request data
> + * @file_priv: DRM file private.
> + * Return: zero on success or a negative number on failure.
>   */
>  int drm_legacy_getctx(struct drm_device *dev, void *data,
>                       struct drm_file *file_priv)
> @@ -429,13 +409,12 @@ int drm_legacy_getctx(struct drm_device *dev, void =
*data,
>  }
>
>  /**
> - * Switch context.
> + * drm_legacy_switchctx() - Switch context.
>   *
> - * \param inode device inode.
> - * \param file_priv DRM file private.
> - * \param cmd command.
> - * \param arg user argument pointing to a drm_ctx structure.
> - * \return zero on success or a negative number on failure.
> + * @dev: DRM device to operate on
> + * @data: request data
> + * @file_priv: DRM file private.
> + * Return: zero on success or a negative number on failure.
>   *
>   * Calls context_switch().
>   */
> @@ -453,13 +432,12 @@ int drm_legacy_switchctx(struct drm_device *dev, vo=
id *data,
>  }
>
>  /**
> - * New context.
> + * drm_legacy_newctx() - New context.
>   *
> - * \param inode device inode.
> - * \param file_priv DRM file private.
> - * \param cmd command.
> - * \param arg user argument pointing to a drm_ctx structure.
> - * \return zero on success or a negative number on failure.
> + * @dev: DRM device to operate on
> + * @data: request data
> + * @file_priv: DRM file private.
> + * Return: zero on success or a negative number on failure.
>   *
>   * Calls context_switch_complete().
>   */
> @@ -479,13 +457,12 @@ int drm_legacy_newctx(struct drm_device *dev, void =
*data,
>  }
>
>  /**
> - * Remove context.
> + * drm_legacy_rmctx() - Remove context.
>   *
> - * \param inode device inode.
> - * \param file_priv DRM file private.
> - * \param cmd command.
> - * \param arg user argument pointing to a drm_ctx structure.
> - * \return zero on success or a negative number on failure.
> + * @dev: DRM device to operate on
> + * @data: request data
> + * @file_priv: DRM file private.
> + * Return: zero on success or a negative number on failure.
>   *
>   * If not the special kernel context, calls ctxbitmap_free() to free the=
 specified context.
>   */
> --
> 2.15.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
