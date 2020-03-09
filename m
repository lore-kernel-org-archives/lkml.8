Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A62C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9B42464B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgX6EII8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgCIVEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:04:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43758 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgCIVEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:04:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id v9so13015992wrf.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 14:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FsRBSfdE1T1XkabqS4jssoseR6/tPbgLzifbVihUd4s=;
        b=ZgX6EII84RmyCkN3dglDEucICaphO9XwhwVQuaP7HVZeOZ6YWrwgBw2JEHwiGvWd5z
         FM5vYp/5CUgsPWT6WxNu3M50+zkQbVsAjzcHFluVqTfvUhp70MYcvBCuJwyrLMrKKIV/
         RGCbVN14H/1SvI4Z7tQZtW0RKGmKeakHF24G+qskLBlB5GspV/3MZy/DA2IMr/LqWl4u
         6i6AzNhbQlqokPdO4PNvDLWxLLkKLgrfmF6pWthMdvMfEnRweqA1UPy9hNSKHYTDcow6
         jWb7LiVeR+I+g3JxvDWtcBxSAB3uHBLZeThXRU02TatRdzf6H+iiZJZi44FK5d+/qdpM
         ypaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FsRBSfdE1T1XkabqS4jssoseR6/tPbgLzifbVihUd4s=;
        b=ThoTT1wwsPUvr4BEisgC/DHdsLr8f6+0RUgENA8UoA9hAykcpAnypH4G1JLR3q466Q
         uE/5AYZxPmyHJkXhwZSZOHB3ztZ8tSpujM64g6h2I/SL8xjcjA6SnqaqVI7bUc10rXlc
         uyx62VApk/C/nekWpttegihSEHZAy/TsCRbmvGYHix1Ys7Btl1zSmxtjv469GDXMCIGR
         5Ftyu5Am5Qz5n9zOz08GueLRw70PO5ACUWVMjJfbk+bQmSDfNNteUByfrB8Zupt1jrvj
         LxpAeHj75X9/JynyslD300rZi23fqaGV1QWZS9SNuygPSfQGC3DHBPIDi1JSaXD63nAl
         J1bg==
X-Gm-Message-State: ANhLgQ027TYeUvDI9O7888bK1lvCL8diNJ18kdCRolBD24oG6j2zSPbF
        DwofY3ctadhJDTvt4PCEuSJp3jlWjQeq/Gx0qow=
X-Google-Smtp-Source: ADFU+vvaVP3DmMgzVl/RSGMO9/7IVNUa3ayUwouhdphjHeiOOcBXoS6Zqjaw5cOAztoAagck3sdi/WeIAMOjZA+JoCY=
X-Received: by 2002:a5d:6688:: with SMTP id l8mr22417777wru.362.1583787858603;
 Mon, 09 Mar 2020 14:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200306234923.547873-1-lyude@redhat.com>
In-Reply-To: <20200306234923.547873-1-lyude@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 9 Mar 2020 17:04:07 -0400
Message-ID: <CADnq5_P_qA8eKoGxeLiGBQXyBT3eL61ghLt3F6ee0eRpbJzOeA@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/dp_mst: Fix link address probing regressions
To:     Lyude Paul <lyude@redhat.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        David Francis <david.francis@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 6:49 PM Lyude Paul <lyude@redhat.com> wrote:
>
> While fixing some regressions caused by introducing bandwidth checking
> into the DP MST atomic helpers, I realized there was another much more
> subtle regression that got introduced by a seemingly harmless patch to
> fix unused variable errors while compiling with W=1 (mentioned in patch
> 2). Basically, this regression makes it so sometimes link address
> appears to "hang". This patch series fixes it.

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Lyude Paul (2):
>   drm/dp_mst: Make drm_dp_mst_dpcd_write() consistent with
>     drm_dp_dpcd_write()
>   drm/dp_mst: Fix drm_dp_check_mstb_guid() return code
>
>  drivers/gpu/drm/drm_dp_mst_topology.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> --
> 2.24.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
