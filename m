Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441C9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C46F206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLjMH5Bj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbgGMNWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:22:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56476 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729564AbgGMNWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594646523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=edOrghovsTl9yTDWwi9fzaESzHDSf4CiS9atP/uIedw=;
        b=DLjMH5BjkOkKpvv5M4iBNZ0KSgHGXg4CnfKWkVpCUkCLz3SlWH4w0NG9+mn3fWhu3ZFmK4
        LqqbzMMnSeLc55alv0RcgJX8c/WIWHjcSqrxF9hCJvgPOkZ5iByhHvhyTkL4zPyvXXGro3
        pHZ4BNLGp/2AIcqPOjoGLWrw9PJBFyE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-YNlTpbZKOq6mmpR3JgTkqA-1; Mon, 13 Jul 2020 09:21:53 -0400
X-MC-Unique: YNlTpbZKOq6mmpR3JgTkqA-1
Received: by mail-qv1-f69.google.com with SMTP id cv20so7379818qvb.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 06:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=edOrghovsTl9yTDWwi9fzaESzHDSf4CiS9atP/uIedw=;
        b=eOAry9/91aQ3meqYXGLyLdBpqeaqqoSEGnh8ypkf0/Yw1dhyXAbwc7MPjCoiiTxoKP
         fp2W1DcmgaloRV+G6wcevz0hzmeTldgD9x5jkRVJD6vRsnX0MyLdW9Mwdwf4TVFNdCGu
         2l3Plqc9ooQwH5nJWwcHKfYV2vyX6VCWRDtmRioGgy5hHlfOtncScYxfKxwDcKoEgcFu
         0Yx6LssC40S57W8s7g8wldyTXcbGxzURgncs2rhqNXUO5TZTMqOravJiePMZgcjJTS56
         6FGAioQKCxu+PNgnAqGncfM5PD1AtnHtDznJMmjzaLapK/KdufdjibdtObCe7Z6OEr/y
         HUNA==
X-Gm-Message-State: AOAM530XIpox1LkZBL+TzqMh5FTI7gpgrWn1LZo3AWjjSe7UMp1B6yHF
        VV2ykdP0MG+Hh6jdEY1IKRQ2dkQuNRyeZ4eRBXqxUNXZoyPNCfjpSkPjsqkrYAROq3tF+IQ/l92
        ZpRCZPTSw18et18ZgxDjgTBO5
X-Received: by 2002:a0c:a306:: with SMTP id u6mr67426919qvu.88.1594646512969;
        Mon, 13 Jul 2020 06:21:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYRKNW3SgUy7XnKo2RNZqSZNx5VyzzmbGCZ2MPDith9Noszi80okXC2k3n8/dWFeBZeD0Xlg==
X-Received: by 2002:a0c:a306:: with SMTP id u6mr67426900qvu.88.1594646512707;
        Mon, 13 Jul 2020 06:21:52 -0700 (PDT)
Received: from x1.localdomain ([78.108.130.193])
        by smtp.gmail.com with ESMTPSA id l1sm19358395qtk.18.2020.07.13.06.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 06:21:51 -0700 (PDT)
Subject: Re: [PATCH] drm/vboxvideo: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200713124923.34282-1-grandmaster@al2klimov.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a48d1f1f-d292-cda1-cafc-ac16c0606d7a@redhat.com>
Date:   Mon, 13 Jul 2020 15:21:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200713124923.34282-1-grandmaster@al2klimov.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/13/20 2:49 PM, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>    If not .svg:
>      For each line:
>        If doesn't contain `\bxmlns\b`:
>          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>              If both the HTTP and HTTPS versions
>              return 200 OK and serve the same content:
>                Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

The "new" https link works for me and I see no reason why
not to do this, other then that some weird site might still
only do http, so:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

(oh on second reading I see that the script already checks
  that the new link works, ah well)

Regards,

Hans



> ---
>   Continuing my work started at 93431e0607e5.
>   See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>   (Actually letting a shell for loop submit all this stuff for me.)
> 
>   If there are any URLs to be removed completely or at least not just HTTPSified:
>   Just clearly say so and I'll *undo my change*.
>   See also: https://lkml.org/lkml/2020/6/27/64
> 
>   If there are any valid, but yet not changed URLs:
>   See: https://lkml.org/lkml/2020/6/26/837
> 
>   If you apply the patch, please let me know.
> 
>   Sorry again to all maintainers who complained about subject lines.
>   Now I realized that you want an actually perfect prefixes,
>   not just subsystem ones.
>   I tried my best...
>   And yes, *I could* (at least half-)automate it.
>   Impossible is nothing! :)
> 
> 
>   drivers/gpu/drm/vboxvideo/hgsmi_defs.h | 2 +-
>   drivers/gpu/drm/vboxvideo/vbox_hgsmi.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vboxvideo/hgsmi_defs.h b/drivers/gpu/drm/vboxvideo/hgsmi_defs.h
> index 6c8df1cdb087..3cb52f2b2274 100644
> --- a/drivers/gpu/drm/vboxvideo/hgsmi_defs.h
> +++ b/drivers/gpu/drm/vboxvideo/hgsmi_defs.h
> @@ -58,7 +58,7 @@ struct hgsmi_buffer_tail {
>   	/* Reserved, must be initialized to 0. */
>   	u32 reserved;
>   	/*
> -	 * One-at-a-Time Hash: http://www.burtleburtle.net/bob/hash/doobs.html
> +	 * One-at-a-Time Hash: https://www.burtleburtle.net/bob/hash/doobs.html
>   	 * Over the header, offset and for first 4 bytes of the tail.
>   	 */
>   	u32 checksum;
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_hgsmi.c b/drivers/gpu/drm/vboxvideo/vbox_hgsmi.c
> index 94b60654a012..a9ca4d0c3eca 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_hgsmi.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_hgsmi.c
> @@ -8,7 +8,7 @@
>   #include "vboxvideo_vbe.h"
>   #include "hgsmi_defs.h"
>   
> -/* One-at-a-Time Hash from http://www.burtleburtle.net/bob/hash/doobs.html */
> +/* One-at-a-Time Hash from https://www.burtleburtle.net/bob/hash/doobs.html */
>   static u32 hgsmi_hash_process(u32 hash, const u8 *data, int size)
>   {
>   	while (size--) {
> 

