Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E221C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C2D12075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvUZ62Lb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgETIzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:55:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29296 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726224AbgETIzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589964952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=akmujYwqV7IKXWS2Az7WtujSNlNlXXC54n9CWBMtkzk=;
        b=gvUZ62LbvL1BoqRCD2aVKCdgiNREboayyM9tRNCNcGaJBIppp4GajYQEwQNHEQ57W8L86p
        eCJU4WC3PZ+VJe3FvW295yD386QHRcmYzmQoQaLbBbu38Scsyi3kcF+yS03Da2f8Wot3p+
        snGM4UtkmxWArUET/fv15msRFZK+hKk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-9gpAt7FENdG6Z9DoeKtpWQ-1; Wed, 20 May 2020 04:55:51 -0400
X-MC-Unique: 9gpAt7FENdG6Z9DoeKtpWQ-1
Received: by mail-wm1-f71.google.com with SMTP id l26so653075wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=akmujYwqV7IKXWS2Az7WtujSNlNlXXC54n9CWBMtkzk=;
        b=sHabzXU/UqH/ebcCLCjUE2xQNkDVVSOv95JxIPL3jlM2vQ5m9p52mX3iVyiH0kPMbV
         XwHJ8F2GJwuOPPLcTzCM7DVz2Xd6EYMKoPMilI6HkQisdlbPfUvR5x2da9NF2VYF1c6u
         bU87GjhdsAq4HBO4U6zjUc3HPcHkeUT/1m6x0elTl+htMaVPh6lv5J4J4IxK1Y5FOS2T
         z+suVsmuFNNX8rgRPGYbiY24M5t7jHCp1SSLCKzUjjgZ5X3zW1YxKXOrg9YHqdSxMiMT
         NsdjrLx1PaCgKec5aCEIzePsobK2QtW44/NBSHN7dFNxUSVWstJGaddyZN6E+XwsgSgZ
         D5/g==
X-Gm-Message-State: AOAM533JGUpR9fijhPzL+QPCzWLLGQLboFQTy5XEaMFJUGIXxNZUvSii
        FrZlALTuRqT9BmSw4SGPhIR0Uyh3c+nMZ67bzmEjT9vs0QKXw1l1evqiug4XxuS3DaIyuGwRC92
        8yrDOPfAV4nL+fAIiVG4LKlzh
X-Received: by 2002:a1c:7d43:: with SMTP id y64mr3854358wmc.46.1589964949961;
        Wed, 20 May 2020 01:55:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPuljQ8ACnjmB5WsbRcDo1UAcpbT6hdWx3g2qAjmLnp22LP//Nkfq0hACI7Qm5NJJeVIUT0Q==
X-Received: by 2002:a1c:7d43:: with SMTP id y64mr3854341wmc.46.1589964949786;
        Wed, 20 May 2020 01:55:49 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id v24sm2480851wmh.45.2020.05.20.01.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 01:55:49 -0700 (PDT)
Date:   Wed, 20 May 2020 04:55:47 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] m68k: add missing __user annotation in get_user()
Message-ID: <20200520045441-mutt-send-email-mst@kernel.org>
References: <20200520065750.8401-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520065750.8401-1-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 02:57:50PM +0800, Jason Wang wrote:
> The ptr is a pointer to userspace memory. So we need annotate it with
> __user otherwise we may get sparse warnings like:
> 
> drivers/vhost/vhost.c:1603:13: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected void const *__gu_ptr @@    got unsigned int [noderef] [usertypvoid const *__gu_ptr @@
> drivers/vhost/vhost.c:1603:13: sparse:    expected void const *__gu_ptr
> drivers/vhost/vhost.c:1603:13: sparse:    got unsigned int [noderef] [usertype] <asn:1> *idxp
> 
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-kernel@vger.kernel.org
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Makes sense:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  arch/m68k/include/asm/uaccess_mm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/include/asm/uaccess_mm.h b/arch/m68k/include/asm/uaccess_mm.h
> index 7e85de984df1..9ae9f8d05925 100644
> --- a/arch/m68k/include/asm/uaccess_mm.h
> +++ b/arch/m68k/include/asm/uaccess_mm.h
> @@ -142,7 +142,7 @@ asm volatile ("\n"					\
>  		__get_user_asm(__gu_err, x, ptr, u32, l, r, -EFAULT);	\
>  		break;							\
>  	case 8: {							\
> -		const void *__gu_ptr = (ptr);				\
> +		const void __user *__gu_ptr = (ptr);			\
>  		union {							\
>  			u64 l;						\
>  			__typeof__(*(ptr)) t;				\
> -- 
> 2.20.1

