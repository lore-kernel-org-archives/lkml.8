Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D7DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E242F20828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6lRtbIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgCEOWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:22:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42430 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgCEOWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583418165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6noagWxZ5YiSaEFMdQzCHre9EJD3npDKEFOYBbGNFrU=;
        b=K6lRtbIFnpB7TQ3j7+DzFzYuiSMr/Jd7aUBnptwA0FfV8paPGfcewQtzDpo3g2Oc7Iy3C5
        DOQhPDPe0E1Eax1sFyaqmPtgAQcXfYvJbFIHUiswsVqR2h8V1GBfV5CMjzLl0MCON76re4
        aQQhNAn8FfKaNyn6T8oFiZBYrrL/zJo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-PAs0eptSNEKmdrGC8pDG_g-1; Thu, 05 Mar 2020 09:22:41 -0500
X-MC-Unique: PAs0eptSNEKmdrGC8pDG_g-1
Received: by mail-wm1-f69.google.com with SMTP id w12so1643624wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 06:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6noagWxZ5YiSaEFMdQzCHre9EJD3npDKEFOYBbGNFrU=;
        b=XrCWbKZqO7kZTjtNS9T2OIIc2h4MvsSEhq96BolEfqT9F53sztPNDEYTeJ+5VKXIgJ
         uUdf7cSk92e6XrSyOaeyyC1R27U+Byq6Wwtwu7c2r7peTGsPvequ9m6KwTcyCQ0OvfsM
         YwuKe85qHt+NeSwejPKZYRZ7WdpVEa/qwijSv5DkZLJnp/Bj+LkDBwA8RYox5Tzamu9G
         7kzKtB9tme507oMHb3RmUsgedTCWiTOOW5X1OztncJnew06lb9OVq47bDV0emziQh8dD
         FFRRuXSW+LJcPL1QKFuqN0R09qWu2YRTWpy0BP/rcnZVI7bjmRJ9LgAYZU58/o6dOpLs
         3rwQ==
X-Gm-Message-State: ANhLgQ0/J6ZLV+gTdIj2R8tJTLxqIZrLrU/lkT2h6UL9RE/FzBF7HYnS
        xyk2tuGkvRHKEdWcFmH0z4+GxY9J1HF60+NZ1tHuR5fA/FWeHUPXDn/NZPPOyDK//GVV54PPEJs
        3bKS65FlrTNuZQITbeQjhKkZc
X-Received: by 2002:a5d:6146:: with SMTP id y6mr10560244wrt.107.1583418159921;
        Thu, 05 Mar 2020 06:22:39 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsVPpJ1Cv7XI3CgGNNoNJ0eAJgUXSnFi1wfWwG4CQQJ1K56cUcw027pOLSq+CkOV+HtsaXJ9g==
X-Received: by 2002:a5d:6146:: with SMTP id y6mr10560228wrt.107.1583418159722;
        Thu, 05 Mar 2020 06:22:39 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id z2sm40199326wrq.95.2020.03.05.06.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 06:22:39 -0800 (PST)
Subject: Re: [PATCH][next] drm/vboxvideo/vboxvideo.h: Replace zero-length
 array with flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200305105558.GA19124@embeddedor>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8e2ab9a2-fb47-1d61-d09c-0510ad5ee5ff@redhat.com>
Date:   Thu, 5 Mar 2020 15:22:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305105558.GA19124@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/5/20 11:55 AM, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>          int stuff;
>          struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/gpu/drm/vboxvideo/vboxvideo.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vboxvideo/vboxvideo.h b/drivers/gpu/drm/vboxvideo/vboxvideo.h
> index 0592004f71aa..a5de40fe1a76 100644
> --- a/drivers/gpu/drm/vboxvideo/vboxvideo.h
> +++ b/drivers/gpu/drm/vboxvideo/vboxvideo.h
> @@ -138,7 +138,7 @@ struct vbva_buffer {
>   
>   	u32 data_len;
>   	/* variable size for the rest of the vbva_buffer area in VRAM. */
> -	u8 data[0];
> +	u8 data[];
>   } __packed;
>   
>   #define VBVA_MAX_RECORD_SIZE (128 * 1024 * 1024)
> 

