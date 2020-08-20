Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6046AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261BB204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVv6MSZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgHTSL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgHTSLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:11:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C191C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 11:11:21 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a5so2993014wrm.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPlGwJIUawBNMyu0GOt8u+swdga2De9aEs3KqrqQvrs=;
        b=QVv6MSZ8Sh06WnMusxMgELfzaIEbb2IkEvNAueK335WPwymR2s7FFHdnAs6qw0+41z
         YucDvXomV/OWqs4SUkwEyzhxh2dS9zJBFLzIARA3RBrRM4kf08+EqfGyeAVtUtpkaV6t
         Zg1TXHJZKyik23/eXCy/rv/Kb2gOmaARcKGnMgnbNLBKH2QmOSqIYUPZ9qyTuvgunnwL
         5K/pjUcfgkt0KK0iIDZIOg0G2X79W7y/BYlk6djqWExJ2pQajQ0Z3pn7i8ie2S9CyhGD
         l3BiPQcBqCIde/rfb6123vgwXvhQsYQPWHUT/ZSLTbgULk/JiKICKi7/lixWk/wKQPcj
         ekdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPlGwJIUawBNMyu0GOt8u+swdga2De9aEs3KqrqQvrs=;
        b=XYqSjexm3LKI+YDQ7U2RijeiiPKn5d59HQKqJQCeUKrKwn+S4pc86kQ0N0akoe3Bdh
         vR3zNZAiJL9JeCsLkQD8EeT1A26+O3fcPZpCZnVf+0z95LUwygI2hJkRaAop0j6va1P9
         NHvqzDK6veeOhjvUYfvLo1eaGcBRiuf3ThBes1wdBRzL/0n6LK9Tmi2cNZrP7/IeY6yh
         jP30OpmNiFj46Cc9iw5y8TAretMFmDc+b0AyxoG93devYP+Cbdr3k9uv8Pp+SpM/4kNl
         A/NNOH+1vtowUHhVkiDYVBDl7jpHpFrqZDVVmCyhJK3DJtrmeFYjBkfeJQ0uWlKvobpC
         1IvA==
X-Gm-Message-State: AOAM533LlZby4Z9YJuxM2xTONxAfLK3NtxHqdonbogzwU09Bg8JM8UL1
        7tZX4daA8FWVHLxPF1+wzzAgNFyXzESCCS9pgpU=
X-Google-Smtp-Source: ABdhPJxuIGpO6/AQWt7ia2owpwQILxjXyYzx0hIYF34TL+5QaBNo3srd6VF6rJurt0B1vw0fUdiH500DdzT7oNp8RSk=
X-Received: by 2002:adf:a351:: with SMTP id d17mr4251209wrb.111.1597947079898;
 Thu, 20 Aug 2020 11:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200819113409.10137-1-wanghai38@huawei.com> <DM6PR12MB26191A1647B5AADB390CDE77E45A0@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26191A1647B5AADB390CDE77E45A0@DM6PR12MB2619.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 Aug 2020 14:11:08 -0400
Message-ID: <CADnq5_O_+GJ6z4gN9nf4pm38v83VCA9paNrumJPSSx-S0wD2eA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/powerplay: remove duplicate include
To:     "Quan, Evan" <Evan.Quan@amd.com>
Cc:     Wang Hai <wanghai38@huawei.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Aug 19, 2020 at 11:00 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
>
> -----Original Message-----
> From: Wang Hai <wanghai38@huawei.com>
> Sent: Wednesday, August 19, 2020 7:34 PM
> To: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; airlied@linux.ie; daniel@ffwll.ch
> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Subject: [PATCH -next] drm/amd/powerplay: remove duplicate include
>
> Remove asic_reg/nbio/nbio_6_1_offset.h which is included more than once
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h
> index e6d9e84059e1..0d08c57d3bca 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h
> @@ -34,7 +34,6 @@
>  #include "asic_reg/gc/gc_9_2_1_offset.h"
>  #include "asic_reg/gc/gc_9_2_1_sh_mask.h"
>
> -#include "asic_reg/nbio/nbio_6_1_offset.h"
>  #include "asic_reg/nbio/nbio_6_1_offset.h"
>  #include "asic_reg/nbio/nbio_6_1_sh_mask.h"
>
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
