Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67989C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389BE206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HFmh7HTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCCEjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 23:39:42 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45996 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgCCEjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 23:39:42 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22so717913pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 20:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Fsfwjx7jgGYItwF5bCeIDJyJTUNRPkOSFQYt5/XqQ6U=;
        b=HFmh7HTAS7PHa+TvciXQAcYw5whCIuhZU2zUpAkLC9ZJSjxyCGmEPDXrMVM0dfkTyv
         ETn18Etqs5FyLnJDrAVM/OwrQtNrlzIHx775yZXbREV7ssdmKxlU8CZQObyJhmBCBrLZ
         qwhlET/uk886S32xAP95UNxC5j3EejlV71gy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Fsfwjx7jgGYItwF5bCeIDJyJTUNRPkOSFQYt5/XqQ6U=;
        b=fPL6lbul8LV/Dmpt+mPC39CAF0CUYfJ69Aa5tdVH6Pwjuwy4blaN/JPzW3jDzcAK6X
         euv9T9RgljVrqit+tE/nOWbjY/G+0y6WqMZhcsrFcgOZFTTw3NTRhK96X7ODVQ9YMjE2
         vxQs+qfVJ000dttYagR3EIhnIUNi0J5OVVPdOzkMnlQx+urqYn4NQ5sxy9q73CqoQnYd
         QleLSrHBAnpSR36oKWKQFMzLgLfQu3sLbeNMSXZIjLlkhpQqzd5TJPwrJsqSbAR1Ykqb
         0Z2Xmqu15gCpU85VL0ATC4HW7PK+ZPwhFSPmrPxmQFCcuZ2gxvDrrPqYvmza/aPSP1wC
         uSpA==
X-Gm-Message-State: ANhLgQ3IlP0aaifUcrLu7wXmp1tt9EvYsJE7N+y9QVC40LGCe/acwCZx
        JsrQ5GAckit950KhSsBfwd+tXg==
X-Google-Smtp-Source: ADFU+vvU6WYjtUTp1RucOTTWWsoavTwgO9nAvwOPiJV4Gr7RaT3WB98LZl3onhyoGq/qdZgd/7XeWA==
X-Received: by 2002:a17:902:7087:: with SMTP id z7mr2493646plk.270.1583210379715;
        Mon, 02 Mar 2020 20:39:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u126sm22329618pfu.182.2020.03.02.20.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 20:39:38 -0800 (PST)
Date:   Mon, 2 Mar 2020 20:39:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/edid: Distribute switch variables for initialization
Message-ID: <202003022038.07A611E@keescook>
References: <20200220062229.68762-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200220062229.68762-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 10:22:29PM -0800, Kees Cook wrote:
> Variables declared in a switch statement before any case statements
> cannot be automatically initialized with compiler instrumentation (as
> they are not part of any execution flow). With GCC's proposed automatic
> stack variable initialization feature, this triggers a warning (and they
> don't get initialized). Clang's automatic stack variable initialization
> (via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
> doesn't initialize such variables[1]. Note that these warnings (or silent
> skipping) happen before the dead-store elimination optimization phase,
> so even when the automatic initializations are later elided in favor of
> direct initializations, the warnings remain.
> 
> To avoid these problems, move such variables into the "case" where
> they're used or lift them up into the main function body.
> 
> drivers/gpu/drm/drm_edid.c: In function ‘drm_edid_to_eld’:
> drivers/gpu/drm/drm_edid.c:4395:9: warning: statement will never be executed [-Wswitch-unreachable]
>  4395 |     int sad_count;
>       |         ^~~~~~~~~
> 
> [1] https://bugs.llvm.org/show_bug.cgi?id=44916
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Ping. Can someone pick this up, please?

Thanks!

-Kees

> ---
>  drivers/gpu/drm/drm_edid.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 805fb004c8eb..2941b65b427f 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -4392,9 +4392,9 @@ static void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
>  			dbl = cea_db_payload_len(db);
>  
>  			switch (cea_db_tag(db)) {
> -				int sad_count;
> +			case AUDIO_BLOCK: {
>  
> -			case AUDIO_BLOCK:
> +				int sad_count;
>  				/* Audio Data Block, contains SADs */
>  				sad_count = min(dbl / 3, 15 - total_sad_count);
>  				if (sad_count >= 1)
> @@ -4402,6 +4402,7 @@ static void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
>  					       &db[1], sad_count * 3);
>  				total_sad_count += sad_count;
>  				break;
> +			}
>  			case SPEAKER_BLOCK:
>  				/* Speaker Allocation Data Block */
>  				if (dbl >= 1)
> 

-- 
Kees Cook
