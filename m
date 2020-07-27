Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FCAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A792070A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFD/ySOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgG0NlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgG0NlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:41:24 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DBBC0619D2;
        Mon, 27 Jul 2020 06:41:23 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o18so17087299eje.7;
        Mon, 27 Jul 2020 06:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WRU4i5nuotlpyXHsJ/GhJzUxBSJEh2EwvWzY/0mhtJs=;
        b=mFD/ySOZnh4it4pc167jVC6Z34oW7cMd8EdI/V69L+eE5UfUVpA0w/wnxhr4dXFW9z
         LFiExckvP8rfz/TYYUgH+E1vDKzNZsx3rCTKEWxBtycZ6+gMWOCgcjSmg7mom3w2/kwf
         iQF1Tsv489AjXrDW9JlBgaIs/w1rLl9JtXftS5lwWS1LvgdlXY5xQxDijG5tNDY7jakQ
         oPJLsDI5NnIb7jqcoZF4iEFQYrfZvu3usWajfcMIEtPYAzF74ds8cFcDFDl/tzCKAllP
         zDXlxyeVU/+9v45b/WDh8wjgQvKDVX2HfOGwY+4Gx6NeA389zat2buQigFyMFaW0ZVT/
         65QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=WRU4i5nuotlpyXHsJ/GhJzUxBSJEh2EwvWzY/0mhtJs=;
        b=Ig75W7khuqZB0ZVKabrpSIo1ynhyozQibzI+GrVxJIj92q5hqcfmje7blXkOTuMwUz
         uRQXhSPvFZ/U+cMbyV64GGnlZQYQgLzAZRcpQlvqKGk3D4zr83/ahOQXEr9f2qDFRACt
         LEZlXk447hHMpkksLGQ5yS7XwAiMAhvatvaKBKp++icQ9i6SvwnC4Jaaf3ZH2ZY56gD0
         ta1btdknJtOVVs/zhppcbxle1N2ZA5w5Qsfu9+6GRHInLgoF5XwW2myuMnFskdDXE9zQ
         xiEGUN3KmbBzfXH1AyTmW9NShRsoN3xbn9zRcgIZOqe7uPEddmFLvoSG9jU5qqsTnuW4
         dUcw==
X-Gm-Message-State: AOAM530teN2d6l9t7pol9jyGCBD+SOWrCT/zv7UEe7f3wlxqFAyFdyiT
        o62n87edtuk/LKNHZF+tTPQqVEHg
X-Google-Smtp-Source: ABdhPJyBJhGj0hE+6xxGNbOwiNpVx+ZqZqnr6spvxdyioOzNcY9AaM+Mx08+jlrNxnYSY44/BNGa0A==
X-Received: by 2002:a17:906:a88b:: with SMTP id ha11mr5428219ejb.545.1595857281845;
        Mon, 27 Jul 2020 06:41:21 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id s2sm754721ejh.95.2020.07.27.06.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 06:41:21 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 2/2] drm/radeon: avoid a useless memset
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200727103436.50793-1-christophe.jaillet@wanadoo.fr>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <898acaf6-9975-40b1-1104-586b64689ccd@gmail.com>
Date:   Mon, 27 Jul 2020 15:41:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727103436.50793-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 27.07.20 um 12:34 schrieb Christophe JAILLET:
> Avoid a memset after a call to 'dma_alloc_coherent()'.
> This is useless since
> commit 518a2f1925c3 ("dma-mapping: zero memory returned from dma_alloc_*")
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/radeon/radeon_gart.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gart.c b/drivers/gpu/drm/radeon/radeon_gart.c
> index b7ce254e5663..3808a753127b 100644
> --- a/drivers/gpu/drm/radeon/radeon_gart.c
> +++ b/drivers/gpu/drm/radeon/radeon_gart.c
> @@ -85,7 +85,6 @@ int radeon_gart_table_ram_alloc(struct radeon_device *rdev)
>   	}
>   #endif
>   	rdev->gart.ptr = ptr;
> -	memset((void *)rdev->gart.ptr, 0, rdev->gart.table_size);
>   	return 0;
>   }
>   

