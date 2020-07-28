Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B12C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16045206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="AMNAOQuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgG1N0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbgG1N0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:26:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDA8C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:26:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so18304173wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/s3jq9NJ73fEE3PqAt09ZsxAzz0EYmQoxyJ22ptWsE=;
        b=AMNAOQuHuu9Kq4fDu9l86Z+9ICzEZfJEibVLB529V+O1SpWFHMlJ2zLBtF+rO+y7TG
         Q+wZFwzJLVUo8NsOAhuvJbfWElzNvmspMdU+oCiHJKEmskHEEe2yRp80MyOy3BJGX7/P
         5G7J2GCI1EiCkBgjlsbKARbl8zb+EbhhKFO1lUaznDnlpxOe05I5ejiSQ08hPLfhy8Cc
         djkj9X3+p1ECObpBykTuNlRS0OjjvH4VrX6Mo3X4oLB0NSHwm334lJN/fHNRczPkHqRY
         WQ9K4Pql1wqS8SnhzjwOrh9KUf9xlJyx9GlC7iyIuXrgQG3G22OshAjviDbHhl7ZAi1l
         phyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/s3jq9NJ73fEE3PqAt09ZsxAzz0EYmQoxyJ22ptWsE=;
        b=NMGhBJhs5bbNgwjwW/BaBDmy5qApSKWjQCOVjTjkN/ryU25PvqKIXqneMTlYnhcvmJ
         K9IzU+WgHoUpP3O++gA9C4aZijAHAUrTWyKmp96J+QpiGY+bZB7CWrw08FMre4vX3xgS
         N/gwYRjWWAFvY5pgxjfJkY37lHaacIlCHrE09w8/Zlm3ghFFP1W00B09cgoXy5djZC+M
         LU1SYP2FPsY21vtOsaY2WZgVklLByOMbpm99GgzlEVjnDwMipyvXqrimvF/fcrQTX9HB
         LMa+wkLp46KyEFNFcW9FFlzoddk0V9/Ok2tLj/bqeADt32jCT6oiFFB6hVij/F6YRTQX
         sDrw==
X-Gm-Message-State: AOAM533B1Z3ddwffJTXgzADtHFGSeuuiJCZBAlWhx0pBm11zmqMWtE0/
        qXsWPjHdGKCoktZKXUa4IQilSDZuIKjudz7rzaNIcQ==
X-Google-Smtp-Source: ABdhPJySDbUjGGpOV5SM3Kmte7QuRaaRGIKl/L3Uz8KmoBnA6/EJ6CU8RhtGbCStzLkpgHgzCXMHVaU7WDEXY/mHy54=
X-Received: by 2002:a5d:6681:: with SMTP id l1mr23870585wru.47.1595942782329;
 Tue, 28 Jul 2020 06:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <cdbba354ffc234d6c03978671f99e129748ff48f.1594230107.git-series.maxime@cerno.tech>
In-Reply-To: <cdbba354ffc234d6c03978671f99e129748ff48f.1594230107.git-series.maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Jul 2020 14:26:06 +0100
Message-ID: <CAPY8ntC1tR+Y+FsHX85B3KT1VHu_eLQS=72CUwYgg9yYbjUgVg@mail.gmail.com>
Subject: Re: [PATCH v4 60/78] drm/vc4: hdmi: Remove unused CEC_CLOCK_DIV define
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Wed, 8 Jul 2020 at 18:44, Maxime Ripard <maxime@cerno.tech> wrote:
>
> The CEC_CLOCK_DIV define is not used anywhere in the driver, let's remove
> it.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 86e21de6c578..a01562a49bf0 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -55,7 +55,6 @@
>
>  #define HSM_CLOCK_FREQ 163682864
>  #define CEC_CLOCK_FREQ 40000
> -#define CEC_CLOCK_DIV  (HSM_CLOCK_FREQ / CEC_CLOCK_FREQ)
>
>  static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
>  {
> --
> git-series 0.9.1
