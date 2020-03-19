Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBECC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664B720753
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584609982;
	bh=i80PIWwQqRoWpTqME1AVxQ31D0dO2cnau71BVefHtJc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QvM59LLo6PDLxSyRjLVDRtW4CAOgsa5Jd2Fp5LVfwiccRR7NqmwlxXYXQp6cKjqP2
	 97ZFiFxos7sBXFnibAw3VXHJlZugbgy1bVAHAVFVRubX1UGbEG6bEqe0Odn0iliWHo
	 vecJh8Le32E1lShcmKjIlCUDNFNQGFQwoi3zGbGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgCSJ0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 05:26:21 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43915 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgCSJ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 05:26:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id a6so1608837otb.10;
        Thu, 19 Mar 2020 02:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bIaUrrQz5sxoRpPg3kthmDFHJOgZz3gYkQ32mtU6C2g=;
        b=Q6IzsMYja9UDQX0gA7YtsKjRdZ3pSCItCgxSCLPh+p3qb98+/HwlzPPqLu4+4GFyxm
         eGiHph2/AR8a2I+t0vEz7PzgqC2lR4mHMdEIa5w+wEDnbvRyDVCHoyuKDhlVTQNQ1xGE
         bmeIosMLSIa7JPUBSUU4cPIjQ4hPGWQmlAGqHlQd48JK+gnfVheX3pZf3ANjJ9pzfR2T
         UXW7mMeCmWEAV+PhsdOwtY9VLLoKmo/+DVXa9r1bkU07N0WPXgGbCrrVXHgzTdZM4XKO
         1uD112rLaBijY4wm1GSbM+HzvDMFgk1TOJ0cKyt+0yeO0libvZPKAXgAOXd87nvexIZg
         m8OQ==
X-Gm-Message-State: ANhLgQ2nIpHm+WqT4nL4472ivojNafpmkrEAZXkvitQULORhkcTi8zVf
        mFSKvK9tEAd4NUjjuUUo21wSx/V80MBsNcG+JAGtIw==
X-Google-Smtp-Source: ADFU+vv+qP2pk76YtrLBdi/ACWZY0xwmzWdEy5G8RrcqAXBpyrHShn4MSw/4CygaJnE6K9O5l9krAhsmtEjFhq9jXpc=
X-Received: by 2002:a9d:1d07:: with SMTP id m7mr1409379otm.167.1584609979839;
 Thu, 19 Mar 2020 02:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <1584545391-20811-1-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1584545391-20811-1-git-send-email-clabbe@baylibre.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Mar 2020 10:26:08 +0100
Message-ID: <CAJZ5v0iU6z2QFk3_s9bZarc=NJibJYBeSr98Wy=+Y8qShT5-hg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add linux-acpi list to PNP
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 4:30 PM Corentin Labbe <clabbe@baylibre.com> wrote:
>
> As asked by the PNP maintainer, linux PNP patch should be CC to
> the linux-acpi mailing list.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index be44251d1e04..4979de5c0c61 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13452,6 +13452,7 @@ F:      Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
>
>  PNP SUPPORT
>  M:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> +L:     linux-acpi@vger.kernel.org
>  S:     Maintained
>  F:     include/linux/pnp.h
>  F:     drivers/pnp/
> --

Applied as 5.7 material, thanks!
