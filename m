Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9A1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 102DD206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgGFRUS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:20:18 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:60364 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729551AbgGFRUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:20:18 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21731955-1500050 
        for multiple; Mon, 06 Jul 2020 18:19:51 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200703125046.8395-1-f.suligoi@asem.it>
References: <20200703125046.8395-1-f.suligoi@asem.it>
Subject: Re: [PATCH] drm/i915: Fix spelling mistake in i915_reg.h
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Date:   Mon, 06 Jul 2020 18:19:49 +0100
Message-ID: <159405598951.24180.13345481240552002697@build.alporthouse.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Flavio Suligoi (2020-07-03 13:50:46)
> Fix typo: "TRIGER" --> "TRIGGER"
> 
> The two misplelled macros:
> 
> 1) OAREPORTTRIG1_EDGE_LEVEL_TRIGER_SELECT_MASK
> 2) OAREPORTTRIG5_EDGE_LEVEL_TRIGER_SELECT_MASK
> 
> are not used in any other sources of the kernel,
> so this change can be consider only a local change
> for the i915_reg.h file.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  drivers/gpu/drm/i915/i915_reg.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
> index 9d6536afc94b..c2153364724a 100644
> --- a/drivers/gpu/drm/i915/i915_reg.h
> +++ b/drivers/gpu/drm/i915/i915_reg.h
> @@ -868,7 +868,7 @@ static inline bool i915_mmio_reg_valid(i915_reg_t reg)
>  
>  #define OAREPORTTRIG1 _MMIO(0x2740)
>  #define OAREPORTTRIG1_THRESHOLD_MASK 0xffff
> -#define OAREPORTTRIG1_EDGE_LEVEL_TRIGER_SELECT_MASK 0xffff0000 /* 0=level */
> +#define OAREPORTTRIG1_EDGE_LEVEL_TRIGGER_SELECT_MASK 0xffff0000 /* 0=level */
>  
>  #define OAREPORTTRIG2 _MMIO(0x2744)
>  #define OAREPORTTRIG2_INVERT_A_0  (1 << 0)
> @@ -921,7 +921,7 @@ static inline bool i915_mmio_reg_valid(i915_reg_t reg)
>  
>  #define OAREPORTTRIG5 _MMIO(0x2750)
>  #define OAREPORTTRIG5_THRESHOLD_MASK 0xffff
> -#define OAREPORTTRIG5_EDGE_LEVEL_TRIGER_SELECT_MASK 0xffff0000 /* 0=level */
> +#define OAREPORTTRIG5_EDGE_LEVEL_TRIGGER_SELECT_MASK 0xffff0000 /* 0=level */

Ok, these names are not copied straight from the docs, so renaming them
will not hinder us when finding the relevant fields.

Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
