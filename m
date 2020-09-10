Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DC9C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 107DF20BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTdhcYLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgIJRto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:49:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36292 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727857AbgIJRsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599760085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ehkzB4LttygthmWCADkLgwoMYDzvXG4NiI7HnkwKLek=;
        b=UTdhcYLvxBi1Bau5hz+Iqcq8FJ1trQs3Ri4rHYhT7OJAy2vtlTY0OV8114J7XMI8BOE84T
        iBkK/x0ugwEGSeSRP9u11aAlt+EBULrNEo0ap1l/LxC+LQ6MGZkGpBMMA3b5ETUPLnzTPp
        89KEijfzCTb2wl4kXMtVK4sniABb+rs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-jz0-BJkJM5SSKqcPNeS_jw-1; Thu, 10 Sep 2020 13:48:02 -0400
X-MC-Unique: jz0-BJkJM5SSKqcPNeS_jw-1
Received: by mail-qk1-f198.google.com with SMTP id r4so4082982qkb.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=ehkzB4LttygthmWCADkLgwoMYDzvXG4NiI7HnkwKLek=;
        b=q9EHz/7r0XbwMBZgdbAv6dd/YPeAVsNvWyNayXlyu/q4M+QaoDrRFTrub5fASUZAC7
         yCntIyoLwRr7BcvBQcuqvkSNC8rGT41L+0dOUgZFeGlouoANrIGt588ttx9O2+5jYPwl
         tld8zOytnHfu1Kr27KzU0GSSCv6KtAfGaztcsBey+BlRIk/dlhuTP8DPalsbG4Gq4Ker
         W/nEL3IOtjVBK+TQ/XX9zodc5EiX4eIyZEb8FHBzymnny8d6mmP8kW7hdwiqPIyDDo1l
         2oq8yuzC4jKniHEtRE+Cu2Z1ZFuFuq2+5uMeV3TiRbF85Y/8Pt7sDl8I2nDFchrVIjZA
         E4SQ==
X-Gm-Message-State: AOAM531WZhwwe1ayuPVA69e1TT1fIctA9s5h7IHaWzs8kdMHTq+JTUAh
        RGGFbohS38JIElfsWEUi9vI4GZjtCl7NnlAW9sjGQJaEAFSc6jFbBkBKR66/e24xchf2tTripRI
        6HDFs9UkeNkCGFDJ+qdAeJPN3
X-Received: by 2002:ac8:4757:: with SMTP id k23mr8914739qtp.105.1599760082024;
        Thu, 10 Sep 2020 10:48:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzrl4LkG26r8eXUfai68ZH7uwANmEYme9QgnBK2OI1JAg0CpzmWdq4JyMISo9AxCnwM+2uzQ==
X-Received: by 2002:ac8:4757:: with SMTP id k23mr8914716qtp.105.1599760081800;
        Thu, 10 Sep 2020 10:48:01 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id o13sm6910440qkm.16.2020.09.10.10.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 10:48:01 -0700 (PDT)
Message-ID: <d1571cdd6a68e8f17ff2e386abd35fd5819d2de8.camel@redhat.com>
Subject: Re: [PATCH] V2: Currently, DRM get the capability of the mst hub
 only from DP_DPCD_REV and get the slower speed even the mst hub can run in
 the faster speed.
From:   Lyude Paul <lyude@redhat.com>
To:     Koba Ko <koba.ko@canonical.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     anthony.wong@canonical.com
Date:   Thu, 10 Sep 2020 13:48:00 -0400
In-Reply-To: <20200910063640.21519-1-koba.ko@canonical.com>
References: <20200910063640.21519-1-koba.ko@canonical.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit message should be shorter and follow the format other commits for
drm usually do, in this case something like:

drm/dp_mst: Retrieve extended DPCD caps for topology manager

On Thu, 2020-09-10 at 14:36 +0800, Koba Ko wrote:
> As per DP-1.3, First check DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT.
> If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 1, read the DP_DP13_DPCD_REV to
> get the faster capability.
> If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 0, read DP_DPCD_REV.
> 
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> ---
> ChangeLog:
> 1. use drm_dp_read_dpcd_caps instead.
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 7753c718ddf9..293f71d0ae90 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3694,8 +3694,8 @@ int drm_dp_mst_topology_mgr_set_mst(struct
> drm_dp_mst_topology_mgr *mgr, bool ms
>  			((dpcd_ext & DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT)
> ?  DP_DP13_DPCD_REV : DP_DPCD_REV);
>  
>  		/* get dpcd info */
> -		ret = drm_dp_dpcd_read(mgr->aux, dpcd_offset, mgr->dpcd,
> DP_RECEIVER_CAP_SIZE);
> -		if (ret != DP_RECEIVER_CAP_SIZE) {
> +		ret = drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd);
> +		if (ret < 0) {
>  			DRM_DEBUG_KMS("failed to read DPCD\n");

Let's use drm_dbg_kms() here, and let's also print the return code when this
fails.

With those things fixed:

Reviewed-by: Lyude Paul <lyude@redhat.com>

>  			goto out_unlock;
>  		}
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

