Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268CFC2BA83
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 18:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C42A206D6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 18:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgBOSco convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 13:32:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:17492 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgBOScn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 13:32:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2020 10:32:43 -0800
X-IronPort-AV: E=Sophos;i="5.70,445,1574150400"; 
   d="scan'208";a="227966402"
Received: from aboethex-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.51.253])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2020 10:32:38 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Emmanuel Vadot <manu@FreeBSD.org>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, efremov@linux.com,
        tzimmermann@suse.de, noralf@tronnes.org, sam@ravnborg.org,
        chris@chris-wilson.co.uk, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Emmanuel Vadot <manu@FreeBSD.Org>,
        Emmanuel Vadot <manu@FreeBSD.org>
Subject: Re: [PATCH v2 1/2] drm/client: Dual licence the file in GPL-2 and MIT
In-Reply-To: <20200215180911.18299-2-manu@FreeBSD.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200215180911.18299-1-manu@FreeBSD.org> <20200215180911.18299-2-manu@FreeBSD.org>
Date:   Sat, 15 Feb 2020 20:33:09 +0200
Message-ID: <877e0n66qi.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2020, Emmanuel Vadot <manu@FreeBSD.org> wrote:
> From: Emmanuel Vadot <manu@FreeBSD.Org>
>
> Contributors for this file are :
> Chris Wilson <chris@chris-wilson.co.uk>
> Denis Efremov <efremov@linux.com>
> Jani Nikula <jani.nikula@intel.com>
> Maxime Ripard <mripard@kernel.org>
> Noralf Trønnes <noralf@tronnes.org>
> Sam Ravnborg <sam@ravnborg.org>
> Thomas Zimmermann <tzimmermann@suse.de>
>
> Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>

I've only converted some logging.

Acked-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/drm_client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
> index b031b45aa8ef..6b0c6ef8b9b3 100644
> --- a/drivers/gpu/drm/drm_client.c
> +++ b/drivers/gpu/drm/drm_client.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0 or MIT
>  /*
>   * Copyright 2018 Noralf Trønnes
>   */

-- 
Jani Nikula, Intel Open Source Graphics Center
