Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1654FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE866208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcX55Q+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405672AbgFYVLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390087AbgFYVLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:11:12 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72787C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:11:12 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id l6so881212pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X2Y5t1dKzr/SYf36lPT97sgIrFXEnQgrqfJccb62zp4=;
        b=QcX55Q+XgMXu91WqdPsHUPMZjt7V9aPWd2V9HjPFdibFoCViwpNOJJ/VOV1j1Oy4jl
         Wm0Q7PwLCXx2I/tp+YvmvireijJ2ZXVrHNAu8WlLkEwFaIeHwphV9Sn/vG23dCXqfg/6
         lxWIzqOGTsOP9ACva8vlaAMTtWz7lnEkhEpEDmkcYP+gv4yDhcya4EIfyaxzco7ldWtn
         ZK39YOeNmNRPKToukKT3l/+S1IguHFUDRGKu8gJq8IqJwS+c3jhoMBxpG7hs3EL5zzTv
         UnpUEn6ch9Erv4Wt4tjI7QGiMvL8nVZ5+vHtT3hyG4ca1en6X/JM1ctQrA/ODrQh31FE
         Fq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X2Y5t1dKzr/SYf36lPT97sgIrFXEnQgrqfJccb62zp4=;
        b=q+dL9Ibvr0i6bY6uZW/o+FrLlFi0Rlz3L/cXsVoOpuA+EhmRPeMwFzWG44jqkVfQn+
         1Z5b2Z3GDZicKxqnLjEoztZvBsFYoK7ykAALa6vJpitb2cCwmsLK8NiFYEazakXpgVC2
         N5VAXi2m1EqmdiOrRkvlyQtLjPllLJ5F+vo8hKMEUb4bvUlaXbu0nqJoR3RMWAlr7sIQ
         i+VA7sNWqf0kMsyG0s2q6oq5ezA4AggFvpzT6EdLuhfMEq5G//6TgjqcnTCEDmrgTnhE
         zvi0hN9PdLElAo3PKPLKOdNtatxwN8DpWrAqhUM4IXPAtpojOeBN6JQ2kFmOje7C9xZH
         Od1w==
X-Gm-Message-State: AOAM531eBTDxmQcTYeAhXgKpTYbcj1JbfvC3ATnOan/jnQb3SjXVk172
        zApTW+Sx7SdA8jZU5FuhZ5Y=
X-Google-Smtp-Source: ABdhPJxhsyqnkWH+CcEUij/QFTHxVO3QgaiFu0KYrj1SmjF28Ou81cgVD2ZfeCyiw2+7ofSf13lz+w==
X-Received: by 2002:a17:902:fe0b:: with SMTP id g11mr8928417plj.269.1593119472022;
        Thu, 25 Jun 2020 14:11:12 -0700 (PDT)
Received: from localhost (g2.222-224-226.ppp.wakwak.ne.jp. [222.224.226.2])
        by smtp.gmail.com with ESMTPSA id t19sm1374874pgg.19.2020.06.25.14.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 14:11:11 -0700 (PDT)
Date:   Fri, 26 Jun 2020 06:11:08 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] openrisc: fix __user in raw_copy_to_user()'s prototype
Message-ID: <20200625211108.GG1401039@lianli.shorne-pla.net>
References: <20200622121124.80398-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622121124.80398-1-luc.vanoostenryck@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 02:11:24PM +0200, Luc Van Oostenryck wrote:
> raw_copy_to_user()'s prototype seems to be a copy & paste of
> raw_copy_from_user() and as such has the __user annotation
> in the 'from' argument instead of the 'to'.
> 
> So, move the __user annotation in the prototype to the 'to'.

Thank you,

I have queued this for 5.9.  If you think its more urgent let me know.

-Stafford

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  arch/openrisc/include/asm/uaccess.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
> index 17c24f14615f..46e31bb4a9ad 100644
> --- a/arch/openrisc/include/asm/uaccess.h
> +++ b/arch/openrisc/include/asm/uaccess.h
> @@ -241,7 +241,7 @@ raw_copy_from_user(void *to, const void __user *from, unsigned long size)
>  	return __copy_tofrom_user(to, (__force const void *)from, size);
>  }
>  static inline unsigned long
> -raw_copy_to_user(void *to, const void __user *from, unsigned long size)
> +raw_copy_to_user(void __user *to, const void *from, unsigned long size)
>  {
>  	return __copy_tofrom_user((__force void *)to, from, size);
>  }
