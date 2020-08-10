Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318DCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0847820658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNAmfy/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgHJUlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgHJUlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:41:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86645C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:41:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a5so9440950wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j5EMGvKq/QSX5Nimp/54WIo9VIgueJVLDNTbT/YFCVY=;
        b=HNAmfy/Sdw56Fk4HXbA5HK6MYGqBTOc2AiPdgnLx5JtcUuh68tZ6Tx1iKnBrXpZh6G
         5qiF697ztbHxs49Rlt7PhputKn0uB+xYoVhJqP5n/uiaPEUWURIiCNlyt6xQqllxW8bD
         xlzXLHwtGbs3iuwy4MIoIMpDPfmNYfYFQP/r3DAVGUVS4Mcwp1Eir7Rxg9ZlYxYO3hcF
         K7UY+xDks8E04zhwdP4KHcLSvFq75GqOZdSb/nWg1H6TuAlHUKHMgk4h8S8dRELbBisv
         kQZdyXeOm0uKHhGUmLymXvT3NrgY3FY3HrkXlNO9yc6qYWcD5mcKi4jhEy5ajNvmeTwQ
         f65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j5EMGvKq/QSX5Nimp/54WIo9VIgueJVLDNTbT/YFCVY=;
        b=neC2FKbnn+AhwKMkRZLg1CBpMAxlmSUF7tyCtjfMtEtHgGDSDcLGNaIrR4VJav3Utb
         kJE94SRMZHuicgknBz7SJ6LxR4OtDeRY27FO3hoLh+I00Uhrme6vQAN3+DZw9uSd6KWr
         +gl7uvH8hM26VmqSpCSDlt9JsrrqH2k2ugs+4AH2k1Z5FjO3O/3/LEiQQBjevyjsRHTy
         fJHoLRZXCi1WRc/kIw07OI2Al/aSTwmDYpEoOUm/jREAe8OGMnYrwp2QQMFbVqP5tDp+
         O0bpPnblRA7KNK+SceJyAhEfap5KkweuIgvmapp0IPL7uA0OTLzE+N1rtR48pK0d6B0W
         QbTg==
X-Gm-Message-State: AOAM532ChsrkaIpOGUkvvz/7AW8PKehXUN8MKzPavPo1hzYi7NIhUHO9
        pwXOvoWBTVBc/7RSkZHrR0HNPd9MgktEREeXNVA=
X-Google-Smtp-Source: ABdhPJzOmgYQCKeWOO9uF9gzi1K9AZ4CcZsAsbDF7u1GYgArYAoq9f8y7HNIy/6aGB8LTYBu9CAicrnWnsBweA0NmWs=
X-Received: by 2002:a5d:618e:: with SMTP id j14mr27138572wru.374.1597092070897;
 Mon, 10 Aug 2020 13:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200810125919.185312-1-miaoqinglang@huawei.com>
In-Reply-To: <20200810125919.185312-1-miaoqinglang@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 10 Aug 2020 16:40:59 -0400
Message-ID: <CADnq5_PunHA1VHHj7VtEHG6o2Z_Z1WS325y_R9xO+gsV_JCOXw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: convert to use le16_add_cpu()
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Aug 10, 2020 at 9:05 AM Qinglang Miao <miaoqinglang@huawei.com> wrote:
>
> Convert cpu_to_le16(le16_to_cpu(E1) + E2) to use le16_add_cpu().
>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/command_table.c  | 4 +---
>  drivers/gpu/drm/amd/display/dc/bios/command_table2.c | 5 +----
>  2 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> index 5815983ca..070459e3e 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> @@ -1877,9 +1877,7 @@ static enum bp_result set_crtc_using_dtd_timing_v3(
>                          * but it is 4 either from Edid data (spec CEA 861)
>                          * or CEA timing table.
>                          */
> -                       params.usV_SyncOffset =
> -                                       cpu_to_le16(le16_to_cpu(params.usV_SyncOffset) + 1);
> -
> +                       le16_add_cpu(&params.usV_SyncOffset, 1);
>                 }
>         }
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> index bed91572f..e8f52eb8e 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> @@ -569,10 +569,7 @@ static enum bp_result set_crtc_using_dtd_timing_v3(
>                          * but it is 4 either from Edid data (spec CEA 861)
>                          * or CEA timing table.
>                          */
> -                       params.v_syncoffset =
> -                               cpu_to_le16(le16_to_cpu(params.v_syncoffset) +
> -                                               1);
> -
> +                       le16_add_cpu(&params.v_syncoffset, 1);
>                 }
>         }
>
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
