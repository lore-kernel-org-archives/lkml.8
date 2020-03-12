Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4065CC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177CE20650
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFuW7YyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgCLOXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:23:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52929 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbgCLOXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:23:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id 11so6302204wmo.2;
        Thu, 12 Mar 2020 07:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dA44/I1QbEkp26HsS2gxH3ezQBrq3Jv9y5bBZu912Y0=;
        b=HFuW7YyPKrK83ubj5R7+KkP1itV8Df1zykmwz5swPLhELoHn3gdPaqfkU0zhBK2Grs
         baRnK1c4/CWO57wcF2HFDKEXS2vKZFS3ilfvJ2ngnsB/T7CDbQk3ZxOhPVOxD8fh18tS
         m1ZofGxh6WKrMMp4UCV8D1uuDHzL0X/181D7pRITK692vzLratBNkHkZJg99a0dobw83
         mx3Ydg3vsvOyAekpj31LRYLMOSeM5/3GU7QQhtI+ycBhiZLdsqdqNxEscvRWBrnHkxaC
         T31mSzwl+c7YjpyKD662mB+KfCY3SEgzMkVCE6DTIky4WGChdyESILEu+0hDBb4uKl+r
         BRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dA44/I1QbEkp26HsS2gxH3ezQBrq3Jv9y5bBZu912Y0=;
        b=YEXCAqBXO8FLfWB8OK2EAQymyhE4w9v5JuSpd5Czqw+yyJ0Jq90BtxP+b81gZi2Bwv
         BZALrA/5A/esWpzn9pCLHyJdDsEfQOLDHEMDQfR/RYPUC3Ntgz8/acxnhg4v65ZYvxxR
         fnc2DpE6qBYbKCO1BJ1K2YEgtFlJffvKuKA1Ff0aLmN+gqPcuz/vW7O2wGU6+fkrwWY8
         8EL9OyC9fb9J19KkRKg6hwKcJ2uuhsGzAmAmjeR8mgG42pWDaa+de14C8nxM+zmdOanm
         uCZX2hs5C5lY0V12MqsVEFrH1UkCtG+3SelUjlcEqY05lsBSb+ZvLJnIl5dyyYxBZVrT
         XRfg==
X-Gm-Message-State: ANhLgQ2Bnkijj/FnpU3ECqWOqlbPRXEbYfcx2NDts1e9s2AHKPdfIHNF
        YjIS+S98AztqWjuSsVvrjynWAfe0CYDboEh2jlM=
X-Google-Smtp-Source: ADFU+vsi+U4lSevQi2U0MZAwb5EtFRnXvKFJCMWeT+WV57OOOomrWmd04fBStp0WtmBv9CGj8sCSva8PdiK3VstXdcY=
X-Received: by 2002:a1c:f009:: with SMTP id a9mr5164075wmb.73.1584022993776;
 Thu, 12 Mar 2020 07:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200224103120.zrvgqaokmoehs5y7@kili.mountain>
In-Reply-To: <20200224103120.zrvgqaokmoehs5y7@kili.mountain>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 12 Mar 2020 10:23:02 -0400
Message-ID: <CADnq5_Or06=BeVmnx35vSqvK1vUxx+Vvzq9h=UY7OkRU+SK+4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: clean up some indenting
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        David Francis <David.Francis@amd.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 5:31 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> These lines were accidentally indented 4 spaces more than they should
> be.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4cb3eb7c6745..408405d9f30c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2138,10 +2138,10 @@ static void handle_hpd_rx_irq(void *param)
>                 }
>         }
>  #ifdef CONFIG_DRM_AMD_DC_HDCP
> -           if (hpd_irq_data.bytes.device_service_irq.bits.CP_IRQ) {
> -                   if (adev->dm.hdcp_workqueue)
> -                           hdcp_handle_cpirq(adev->dm.hdcp_workqueue,  aconnector->base.index);
> -           }
> +       if (hpd_irq_data.bytes.device_service_irq.bits.CP_IRQ) {
> +               if (adev->dm.hdcp_workqueue)
> +                       hdcp_handle_cpirq(adev->dm.hdcp_workqueue,  aconnector->base.index);
> +       }
>  #endif
>         if ((dc_link->cur_link_settings.lane_count != LANE_COUNT_UNKNOWN) ||
>             (dc_link->type == dc_connection_mst_branch))
> --
> 2.11.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
