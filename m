Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6265DC4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433692072C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgCTPJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:09:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:8237 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgCTPJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:09:39 -0400
IronPort-SDR: ABkSjmQN9aN3/GK0PrCcLjE6NXJNCMrQGBUHME4bwGO1hj/iMKU3LL/TURl16toJlOZqSxZPO5
 ET11Zjkk1oYQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 08:09:39 -0700
IronPort-SDR: AFkBwF5WP4WysFrNZm4zA8IBQflVD1OzTdUEPsvTGlxHXrP6iOww7F+msDj/FYXc2cMAVwk0hr
 /bws+txLF6Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,284,1580803200"; 
   d="scan'208";a="445000342"
Received: from mdroper-desk1.fm.intel.com (HELO mdroper-desk1.amr.corp.intel.com) ([10.1.27.64])
  by fmsmga005.fm.intel.com with ESMTP; 20 Mar 2020 08:09:38 -0700
Date:   Fri, 20 Mar 2020 08:09:38 -0700
From:   Matt Roper <matthew.d.roper@intel.com>
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        noralf@tronnes.org, kraxel@redhat.com, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/client: Dual licence the header in GPL-2 and MIT
Message-ID: <20200320150938.GA2520475@mdroper-desk1.amr.corp.intel.com>
References: <20200320022114.2234-1-manu@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200320022114.2234-1-manu@FreeBSD.org>
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

Acked-by: Matt Roper <matthew.d.roper@intel.com>

> 
> Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>
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
Matt Roper
Graphics Software Engineer
VTT-OSGC Platform Enablement
Intel Corporation
(916) 356-2795
